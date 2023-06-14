//! The API service that deals with [`Executor`].

pub(crate) mod context;
pub(crate) mod engine;
pub(crate) mod retrieve;
pub(crate) mod search;

use axum::http::StatusCode;
use axum::response::IntoResponse;
use axum::Json;
use once_cell::sync::OnceCell;
use serde_json::json;
use thiserror::Error;
use tracing::{debug, instrument, trace};
use unm_engine::executor::{Executor, ExecutorError};

static EXECUTOR: OnceCell<Executor> = OnceCell::new();

/// Get the global UNM Executor.
///
/// It should construct only once in the whole lifetime,
/// so you can call it freely without worrying about the cost.
#[instrument]
pub fn get_unm_executor() -> &'static Executor {
    trace!("Getting UNM Executor…");
    EXECUTOR.get_or_init(unm_api_utils::executor::build_full_executor)
}

#[derive(Debug, Error)]
pub enum ApiExecutorError {
    #[error("Failed to search: {0}")]
    SearchFailed(ExecutorError),

    #[error("Failed to retrieve: {0}")]
    RetrieveFailed(ExecutorError),
}

pub type ApiExecutorResult<T> = Result<T, ApiExecutorError>;

impl IntoResponse for ApiExecutorError {
    #[instrument]
    fn into_response(self) -> axum::response::Response {
        debug!("Converting ApiExecutorError to Response…");

        let error_response = format!("{self}");

        let code = match self {
            ApiExecutorError::SearchFailed(executor_error) => match executor_error {
                ExecutorError::EnginesMissing { .. } => StatusCode::UNPROCESSABLE_ENTITY,
                ExecutorError::NoMatchedSong { .. } => StatusCode::NOT_FOUND,
                _ => StatusCode::INTERNAL_SERVER_ERROR,
            },
            ApiExecutorError::RetrieveFailed(executor_error) => match executor_error {
                ExecutorError::EngineResolveFailed { .. } => StatusCode::UNPROCESSABLE_ENTITY,
                _ => StatusCode::INTERNAL_SERVER_ERROR,
            },
        };

        (code, Json(json!({ "error": error_response }))).into_response()
    }
}
