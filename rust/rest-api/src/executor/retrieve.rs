use serde::Deserialize;
use tracing::debug;
pub use unm_types::SongSearchInformation;
use unm_types::{Context, RetrievedSongInfo};

use super::context::ApiContext;
use super::{get_unm_executor, ApiExecutorError, ApiExecutorResult};

#[derive(Deserialize)]
pub struct RetrievePayload {
    /// The retrieved song info.
    ///
    /// It is the value returned by the search API.
    pub retrieved_song_info: SongSearchInformation,

    /// The context for retrieving.
    #[serde(default)]
    pub context: ApiContext,
}

impl RetrievePayload {
    pub async fn retrieve(&self, context: &Context) -> ApiExecutorResult<RetrievedSongInfo> {
        debug!("Retrieving the specified song info…");

        let result = get_unm_executor()
            .retrieve(&self.retrieved_song_info, context)
            .await
            .map_err(ApiExecutorError::RetrieveFailed)?;

        Ok(result)
    }
}
