//! UNM Engine: PyNCM
//!
//! It can fetch audio from the unofficial
//! Netease Cloud Music API.

use http::header::HOST;
use log::{debug, info};
use serde::Deserialize;
use unm_engine::interface::Engine;
use unm_request::build_client;
use unm_types::{Context, RetrievedSongInfo, SerializedIdentifier, Song, SongSearchInformation};
use url::Url;

#[derive(Deserialize)]
#[non_exhaustive]
struct PyNCMResponse {
    /// The status code of this response.
    pub code: i32,
    pub data: Vec<PyNCMResponseEntry>,
}

#[derive(Deserialize)]
#[non_exhaustive]
struct PyNCMResponseEntry {
    /// The NCM ID of this song.
    pub id: i64,
    /// The URL of this song.
    pub url: Option<String>,
}

pub const ENGINE_ID: &str = "pyncm";

/// The `pyncm` engine that can fetch audio from
/// the unofficial Netease Cloud Music API.
pub struct PyNCMEngine;

#[async_trait::async_trait]
impl Engine for PyNCMEngine {
    async fn search<'a>(
        &self,
        info: &'a Song,
        ctx: &'a Context,
    ) -> anyhow::Result<Option<SongSearchInformation>> {
        info!("Searching with PyNCM engine…");

        let response = fetch_song_info(&info.id, ctx).await?;

        if response.code == 200 {
            // We return the URL we got from PyNCM as the song identifier,
            // so we can return the URL in retrieve() easily.
            let match_result = find_match(&response.data, &info.id)?.map(|url| {
                SongSearchInformation::builder()
                    .source(ENGINE_ID.into())
                    .identifier(url)
                    .build()
            });

            Ok(match_result)
        } else {
            Err(anyhow::anyhow!(
                "failed to request. code: {}",
                response.code
            ))
        }
    }

    async fn retrieve<'a>(
        &self,
        identifier: &'a SerializedIdentifier,
        _: &'a Context,
    ) -> anyhow::Result<RetrievedSongInfo> {
        info!("Retrieving with PyNCM engine…");

        // We just return the identifier as the URL of song.
        Ok(RetrievedSongInfo::builder()
            .source(ENGINE_ID.into())
            .url(identifier.to_string())
            .build())
    }
}

/// Fetch the song info in [`PyNCMResponse`].
async fn fetch_song_info(id: &str, ctx: &Context) -> anyhow::Result<PyNCMResponse> {
    debug!("Fetching the song information…");

    let bitrate = if ctx.enable_flac { 999000 } else { 320000 };
    let url = Url::parse_with_params(
        "http://76.76.21.21/api/pyncm?module=track&method=GetTrackAudio",
        &[("song_ids", id), ("bitrate", &bitrate.to_string())],
    )?;

    let client = build_client(ctx.proxy_uri.as_deref())?;
    let response = client
        .get(url)
        .header(HOST, "music.163-my-beloved.com")
        .send()
        .await?;
    Ok(response.json::<PyNCMResponse>().await?)
}

/// Find the matched song from an array of [`PyNCMResponseEntry`].
fn find_match(data: &[PyNCMResponseEntry], song_id: &str) -> anyhow::Result<Option<String>> {
    info!("Finding the matched song…");

    data.iter()
        .find(|entry| {
            // Test if the ID of this entry matched what we want to fetch,
            // and there is content in its URL.
            entry.id.to_string() == song_id && entry.url.is_some()
        })
        .map(|v| v.url.clone())
        .ok_or_else(|| anyhow::anyhow!("no matched song"))
}

#[cfg(test)]
mod tests {
    use unm_types::ContextBuilder;

    #[tokio::test]
    async fn test_fetch_song_info() {
        use super::fetch_song_info;

        let song_id = "1939601619"; // Madeon – Love You Back
        let result = fetch_song_info(song_id, &ContextBuilder::default().build().unwrap()).await;

        if let Ok(response) = result {
            assert_eq!(response.code, 200);
            assert_eq!(response.data.len(), 1);
            assert_eq!(response.data[0].id.to_string(), song_id);
            assert!(response.data[0].url.is_some());
        } else {
            panic!("failed to fetch song info");
        }
    }
}
