//! API: `/api/v[n]/search`
//!
//! Supported version: `v1`.

use std::sync::Arc;

use axum::response::IntoResponse;
use axum::{Extension, Json};
use tracing::info;
use unm_types::Context;

use crate::executor::search::SearchPayload;

pub async fn search_v1(
    Extension(default_context): Extension<Arc<Context>>,
    Json(payload): Json<SearchPayload>,
) -> impl IntoResponse {
    info!(
        "[v1][Search] Searching the song “{}” with the engines “{:?}”",
        payload.song,
        payload.engines.get_engines_list()
    );

    let context = payload
        .context
        .construct_context((*default_context).clone());
    let response = payload.search(&context).await;

    match response {
        Ok(response) => response.into_response(),
        Err(e) => e.into_response(),
    }
}
