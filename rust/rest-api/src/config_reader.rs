use std::borrow::Cow;
use std::fs;

use serde::de::DeserializeOwned;
use serde::Deserialize;
use tracing::{info, instrument};
use unm_types::Context;

pub trait ExternalConfigReader: DeserializeOwned {
    fn read_toml(file_path: Cow<'static, str>) -> anyhow::Result<Self>;
}

#[derive(Deserialize)]
#[non_exhaustive]
pub struct ApiConfigTomlStructure {
    pub context: Context,
    #[serde(default)]
    pub rate_limit: RateLimitConfig,
}

#[derive(Default, Debug, Deserialize)]
pub struct RateLimitConfig {
    /// The max requests allowed per duration.
    ///
    /// By default, it is `30` requests.
    #[serde(default)]
    pub max_requests: RateLimitMaxRequests,
    /// The applied duration of the rate limit.
    ///
    /// By default, it is `300` seconds.
    #[serde(default)]
    pub limit_duration_seconds: RateLimitDurationSeconds,
}

#[derive(Debug, Deserialize)]
pub struct RateLimitMaxRequests(pub u64);
#[derive(Debug, Deserialize)]
pub struct RateLimitDurationSeconds(pub u64);

impl Default for RateLimitMaxRequests {
    fn default() -> Self {
        Self(30)
    }
}

impl Default for RateLimitDurationSeconds {
    fn default() -> Self {
        Self(300)
    }
}

impl ExternalConfigReader for ApiConfigTomlStructure {
    #[instrument]
    fn read_toml(file_path: Cow<'static, str>) -> anyhow::Result<Self> {
        info!("Reading configuration from TOML file: {}", file_path);

        let file_content = fs::read_to_string(&*file_path)?;
        let context = toml::from_str::<'_, Self>(&file_content)?;

        Ok(context)
    }
}
