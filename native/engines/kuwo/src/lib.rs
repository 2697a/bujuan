//! UNM Engine: Kuwo
//!
//! Note that we only implemented the API that can
//! only fetch the 320kbps audio file.
//!
//! FIXME: KuwoDES implementation for Lossless file.

use api::typing::MusicID;
use async_trait::async_trait;
use unm_engine::interface::Engine;
use unm_types::{Context, RetrievedSongInfo, SerializedIdentifier, Song, SongSearchInformation};

pub mod api;

pub const ENGINE_ID: &str = "kuwo";
pub struct KuwoEngine;

#[async_trait]
impl Engine for KuwoEngine {
    async fn search<'a>(
        &self,
        info: &'a Song,
        ctx: &'a Context,
    ) -> anyhow::Result<Option<SongSearchInformation>> {
        log::info!("Searching “{info}” in Kuwo Music…");

        let response = api::search_music_by_keyword(&info.keyword(), 1, 30, ctx).await?;

        let mut song_iterator = response
            .data
            .list
            .into_iter()
            .filter(|d| d.pay == "0")
            .map(Song::from);

        log::debug!("Matching the song…");
        let unm_selector::SimilarSongSelector { selector, .. } =
            unm_selector::SimilarSongSelector::new(info);
        let matched_song = song_iterator.find(|s| selector(&s));

        Ok(matched_song.map(|song| {
            SongSearchInformation::builder()
                .source(ENGINE_ID.into())
                .identifier(song.id.clone())
                .song(Some(song))
                .build()
        }))
    }

    async fn retrieve<'a>(
        &self,
        identifier: &'a SerializedIdentifier,
        ctx: &'a Context,
    ) -> anyhow::Result<RetrievedSongInfo> {
        log::info!("Retrieving MID “{identifier}” from Kuwo Music…");

        let mid = MusicID::from_str_radix(identifier, 10)?;
        let response = api::get_music(mid, ctx).await?;
        let url = response.data.url;

        Ok(RetrievedSongInfo::builder()
            .source(ENGINE_ID.into())
            .url(url)
            .build())
    }
}
