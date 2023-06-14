//! UNM Engine: Bilibili
//!
//! Note that you may need to include the following
//! headers to fetch the song from the retrieved URL:
//!
//! ```http
//! Referer: https://www.bilibili.com/
//! User-Agent: okhttp/3.4.1
//! ``

pub mod api;

use async_trait::async_trait;
use log::{debug, info};
use unm_engine::interface::Engine;
use unm_selector::SimilarSongSelector;
use unm_types::{Context, RetrievedSongInfo, SerializedIdentifier, Song, SongSearchInformation};

pub const ENGINE_ID: &str = "bilibili";

/// The `bilibili` engine that can fetch audio from Bilibili Music.
pub struct BilibiliEngine;

#[async_trait]
impl Engine for BilibiliEngine {
    async fn search<'a>(
        &self,
        info: &'a Song,
        ctx: &'a Context,
    ) -> anyhow::Result<Option<SongSearchInformation>> {
        info!("Searching with Bilibili engine…");

        let response = api::search(&info.keyword(), ctx).await?;
        let mut song_iterator = response.data.result.into_iter().map(Song::from);

        debug!("Matching the song…");
        let SimilarSongSelector { selector, .. } = SimilarSongSelector::new(info);
        let matched = song_iterator.find(|s| selector(&s));

        Ok(matched.map(|song| {
            SongSearchInformation::builder()
                .source(ENGINE_ID.into())
                .identifier(song.id.to_string())
                .song(Some(song))
                .build()
        }))
    }

    async fn retrieve<'a>(
        &self,
        identifier: &'a SerializedIdentifier,
        ctx: &'a Context,
    ) -> anyhow::Result<RetrievedSongInfo> {
        info!("Retrieving the song by identifier…");

        let response = api::track(identifier, ctx).await?;
        let url = response
            .data
            .get_music_url()
            .ok_or_else(|| anyhow::anyhow!("unable to retrieve the identifier"))?;

        Ok(RetrievedSongInfo::builder()
            .source(ENGINE_ID.into())
            .url(url)
            .build())
    }
}
