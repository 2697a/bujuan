use std::borrow::Cow;
use std::collections::HashMap;
use std::sync::Arc;

use futures::{FutureExt, StreamExt};
use log::{debug, error, info, trace, warn};
use unm_types::{Context, RetrievedSongInfo, SearchMode, Song, SongSearchInformation};

use crate::interface::Engine;

pub type EngineId = Cow<'static, str>;
pub type EngineImplementation = Arc<dyn Engine + Send + Sync>;

#[derive(Default)]
pub struct Executor {
    engine_map: HashMap<EngineId, EngineImplementation>,
}

impl Executor {
    pub fn new() -> Self {
        Default::default()
    }

    /// Register the `engine_impl` with the `engine_id` to [`Executor`].
    ///
    /// Better to use the `engine_id` provided by the engine trait,
    /// so we can take it correctly when received [`SongSearchInformation`].
    ///
    /// ```ignore
    /// use unm_engine_bilibili::{BilibiliEngine, ENGINE_ID as BILIBILI_ENGINE_ID};
    ///
    /// let mut executor = Executor::new();
    /// executor.register(BILIBILI_ENGINE_ID, BilibiliEngine::default());
    /// ```
    pub fn register(&mut self, engine_id: EngineId, engine_impl: EngineImplementation) {
        debug!("Registering engine: {engine_id}");
        self.engine_map.insert(engine_id, engine_impl);
    }

    /// Deregister the `engine_id` from [`Executor`].
    pub fn deregister(&mut self, engine_id: EngineId) {
        debug!("Deregistering engine: {engine_id}");
        self.engine_map.remove(&engine_id);
    }

    /// Show all the registered engines.
    pub fn list(&self) -> Vec<&str> {
        self.engine_map
            .keys()
            .map(|v| v.as_ref())
            .collect::<Vec<&str>>()
    }

    /// Search with the specified engines.
    pub async fn search(
        &self,
        engines: &[EngineId],
        song: &Song,
        ctx: &Context,
    ) -> ExecutorResult<SongSearchInformation> {
        info!("Searching {song} with engines {engines:?}");
        self.validate_engines(engines)?;

        let mut futures = Vec::with_capacity(engines.len());

        for engine_id in engines {
            let engine = self.resolve_engine(engine_id)?;

            let future = async move {
                info!("Searching {song} with engine {engine_id}…");

                let mut result = engine
                    .search(song, ctx)
                    .await
                    .map_err(ExecutorError::EngineSearchError)?
                    .ok_or_else(|| ExecutorError::NoMatchedSong {
                        keyword: song.keyword(),
                    })?;

                // Try to retrieve to check if the source available to retrieve.
                result.pre_retrieve_result = Some(
                    engine
                        .retrieve(&result.identifier, ctx)
                        .await
                        .map_err(ExecutorError::EngineRetrieveError)?,
                );

                // Specify the Error type explicitly.
                Ok::<SongSearchInformation, ExecutorError>(result)
            }
            .boxed();

            futures.push(future);
        }

        trace!("Executing futures…");

        let mut futures = match ctx.search_mode {
            SearchMode::FastFirst => {
                debug!("Use SearchMode::FastFirst mode!");
                futures::stream::FuturesUnordered::from_iter(futures.into_iter()).boxed()
            }
            SearchMode::OrderFirst => {
                debug!("Use SearchMode::OrderFirst mode!");
                futures::stream::FuturesOrdered::from_iter(futures.into_iter()).boxed()
            }
            _ => unimplemented!(),
        };

        while let Some(future) = futures.next().await {
            match future {
                Ok(result) => {
                    info!("Found {} with engine {}!", song, result.source);
                    return Ok(result);
                }
                Err(e) => {
                    warn!("Failed to run: {:?}, waiting for next candidate…", e);
                    continue;
                }
            }
        }

        error!("All futures have been run, and no any result found. Give up.");
        Err(ExecutorError::NoMatchedSong {
            keyword: song.keyword(),
        })
    }

    pub async fn retrieve<'a>(
        &self,
        song: &'a SongSearchInformation,
        ctx: &Context,
    ) -> ExecutorResult<RetrievedSongInfo> {
        info!("Retrieving song from {}…", song.source);

        if let Some(ref retrieved) = song.pre_retrieve_result {
            Ok(retrieved.clone())
        } else {
            let engine = self.resolve_engine(&song.source)?;
            engine
                .retrieve(&song.identifier, ctx)
                .await
                .map_err(ExecutorError::EngineRetrieveError)
        }
    }

    /// Validate engines to check if the engines specified are all registered.
    fn validate_engines(&self, engines: &[EngineId]) -> ExecutorResult<()> {
        debug!("Validating if all the engines ({engines:?}) are registered…");
        let mut missing_engines = Vec::with_capacity(engines.len());

        for engine_id in engines {
            trace!("Validating: {engine_id}");
            if self.engine_map.contains_key(engine_id) {
                trace!("Engine {engine_id} is registered");
            } else {
                trace!("Engine {engine_id} is not registered");
                missing_engines.push(engine_id);
            }
        }

        if missing_engines.is_empty() {
            Ok(())
        } else {
            Err(ExecutorError::EnginesMissing {
                unregistered_engines_list: format!("{missing_engines:?}"),
            })
        }
    }

    /// Resolve `engine_id` to the registered `engine_impl`.
    ///
    /// See the `register()` method for further information.
    fn resolve_engine(&self, engine_id: &str) -> ExecutorResult<EngineImplementation> {
        debug!("Resolving engine {engine_id}…");
        self.engine_map
            .get(engine_id)
            .cloned()
            .ok_or(ExecutorError::EngineResolveFailed {
                engine: engine_id.to_string(),
            })
    }
}

#[derive(Debug, thiserror::Error)]
pub enum ExecutorError {
    #[error("These engines are not registered: {unregistered_engines_list:?}")]
    EnginesMissing { unregistered_engines_list: String },

    #[error("Failed to resolve engine {engine}")]
    EngineResolveFailed { engine: String },

    #[error("Error searching with engine: {0}")]
    EngineSearchError(anyhow::Error),

    #[error("Error retrieving with engine: {0}")]
    EngineRetrieveError(anyhow::Error),

    #[error("No matched song of {keyword}.")]
    NoMatchedSong { keyword: String },
}

pub type ExecutorResult<T> = Result<T, ExecutorError>;
