use unm_request::build_client;
use unm_types::Context;
use url::Url;

use self::typing::{SearchResult, TrackResult};

pub mod typing;

pub async fn search(keyword: &str, context: &Context) -> anyhow::Result<SearchResult> {
    let client = build_client(context.proxy_uri.as_deref())?;
    let url = Url::parse_with_params(
        "https://api.bilibili.com/audio/music-service-c/s",
        &[
            ("search_type", "music"),
            ("page", "1"),
            ("pagesize", "30"),
            ("keyword", keyword),
        ],
    )?;

    let response = client.get(url).send().await?;
    Ok(response.json::<SearchResult>().await?)
}

pub async fn track(id: &str, context: &Context) -> anyhow::Result<TrackResult> {
    let client = build_client(context.proxy_uri.as_deref())?;
    let url = Url::parse_with_params(
        "https://www.bilibili.com/audio/music-service-c/web/url",
        &[("rivilege", "2"), ("quality", "2"), ("sid", id)],
    )?;

    let response = client.get(url).send().await?;
    Ok(response.json::<TrackResult>().await?)
}
