use axum::Json;
use serde::Deserialize;
use tracing::debug;
use unm_types::{Context, Song, SongSearchInformation};

use super::context::ApiContext;
use super::engine::ApiEnginesList;
use super::{get_unm_executor, ApiExecutorError, ApiExecutorResult};

#[derive(Deserialize)]
pub struct SearchPayload {
    /// The list with the engines to use.
    ///
    /// If not specified, we use all the supported engines.
    /// For more information, see [`ApiEnginesList`].
    #[serde(default)]
    pub engines: ApiEnginesList,

    /// The song to search.
    pub song: Song,

    /// The context for searching.
    #[serde(default)]
    pub context: ApiContext,
}

impl SearchPayload {
    /// Search with the specified context.
    ///
    /// You may need to call `construct_context` to construct
    /// an user-customized context, and pass it to here.
    ///
    /// The `SongSearchInformation` return value is important
    /// to retrieve audio.
    pub async fn search(
        &self,
        context: &Context,
    ) -> ApiExecutorResult<Json<SongSearchInformation>> {
        debug!("Searching the specified song…");

        let engines_list = self.engines.get_engines_list();
        let result = get_unm_executor()
            .search(&engines_list, &self.song, context)
            .await
            .map_err(ApiExecutorError::SearchFailed)?;

        Ok(Json(result))
    }
}
