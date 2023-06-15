use reqwest::Response;
use serde::de::DeserializeOwned;
use thiserror::Error;

#[async_trait::async_trait]
pub trait ResponseExt {
    async fn jsonp<T: DeserializeOwned>(self) -> RequestExtModuleResult<T>;
}

#[async_trait::async_trait]
impl ResponseExt for Response {
    async fn jsonp<T: DeserializeOwned>(self) -> RequestExtModuleResult<T> {
        let json_str = {
            let jsonp_str = self
                .text()
                .await
                .map_err(RequestExtModuleError::GetTextFailed)?;
            crate::json::extract_jsonp(&jsonp_str)
        };

        serde_json::from_str::<T>(&json_str).map_err(RequestExtModuleError::DeserializeFailed)
    }
}

/// Error in this module.
#[derive(Error, Debug)]
pub enum RequestExtModuleError {
    #[error("failed to call .text() on the response: {0}")]
    GetTextFailed(reqwest::Error),

    #[error("failed to deserialize to a struct: {0}")]
    DeserializeFailed(serde_json::Error),
}

/// The [`Result`] of this module.
pub type RequestExtModuleResult<T> = Result<T, RequestExtModuleError>;
