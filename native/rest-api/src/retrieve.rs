//! A service that forward the retrieved URI.

use std::time::Duration;

use axum::response::IntoResponse;
use axum::Json;
use http::{HeaderMap, StatusCode};
use once_cell::sync::Lazy;
use reqwest::{Client, Url};
use serde_json::json;
use thiserror::Error;
use tracing::{debug, instrument};
use unm_types::RetrievedSongInfo;

static CLIENT: Lazy<Client> = Lazy::new(|| {
    debug!("Constructing the client…");

    reqwest::Client::builder()
        .build()
        .expect("failed to construct reqwest client")
});

/// Determine the header for requesting by the specified engine.
#[instrument]
pub fn determine_header(engine: &str) -> HeaderMap {
    debug!("Determining the header to use…");

    let mut hm = HeaderMap::new();

    if engine == unm_engine_bilibili::ENGINE_ID {
        hm.insert(
            http::header::REFERER,
            http::HeaderValue::from_static("https://www.bilibili.com/"),
        );
        hm.insert(
            http::header::USER_AGENT,
            http::HeaderValue::from_static("okhttp/3.4.1"),
        );
    }

    hm
}

pub async fn request_as_stream(
    retrieved: &RetrievedSongInfo,
) -> RetrievedResult<impl futures::Stream<Item = reqwest::Result<bytes::Bytes>>> {
    debug!(
        "Request the song URL ({}) and return as stream…",
        retrieved.url
    );

    let url = Url::parse(&retrieved.url)?;
    let request = CLIENT
        .get(url)
        .headers(determine_header(&retrieved.source))
        .timeout(Duration::from_secs(10))
        .build()
        .map_err(RetrieveError::ConstructRequestFailed)?;

    let response = CLIENT
        .execute(request)
        .await
        .map_err(RetrieveError::RequestFailed)?;

    Ok(response.bytes_stream())
}

#[derive(Debug, Error)]
pub enum RetrieveError {
    #[error("failed to construct request: {0}")]
    ConstructRequestFailed(reqwest::Error),

    #[error("failed to request: {0}")]
    RequestFailed(reqwest::Error),

    #[error("failed to parse URL: {0}")]
    UrlParseError(#[from] url::ParseError),
}
pub type RetrievedResult<T> = Result<T, RetrieveError>;

impl IntoResponse for RetrieveError {
    #[instrument]
    fn into_response(self) -> axum::response::Response {
        debug!("Convert RetrieveError to Response…");

        let error_response = format!("{self}");

        (
            StatusCode::INTERNAL_SERVER_ERROR,
            Json(json!({ "error": error_response })),
        )
            .into_response()
    }
}
