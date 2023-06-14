//! UNM Engine: Migu
//!
//! It can fetch audio from Migu Music.

mod types;

use std::collections::HashMap;

use anyhow::Ok;
use async_trait::async_trait;
use types::MiguResponse;
use unm_engine::interface::Engine;
use unm_request::build_client;
use unm_request::json::Json;
use unm_selector::SimilarSongSelector;
use unm_types::{Context, RetrievedSongInfo, SerializedIdentifier, Song, SongSearchInformation};
use url::Url;

pub const ENGINE_ID: &str = "migu";

/// The `migu` engine that can fetch audio from Migu Music.
pub struct MiguEngine;

#[async_trait]
impl Engine for MiguEngine {
    async fn search<'a>(
        &self,
        info: &'a Song,
        ctx: &'a Context,
    ) -> anyhow::Result<Option<SongSearchInformation>> {
        log::info!("Searching “{info}” with Migu engine…");

        let api = construct_search_api(info.keyword().as_str())?;
        let client = build_client(ctx.proxy_uri.as_deref())?;

        let response = client.get(api).send().await?;
        let result = response.json::<Json>().await?;
        let migu_songs = {
            let raw = result
                .pointer("/songResultData/result")
                .ok_or_else(|| {
                    anyhow::anyhow!("Could not extract the field 'result' from response")
                })?
                .clone();
            let response = serde_json::from_value::<Vec<types::MiguResponse>>(raw);

            match response {
                Err(e) => {
                    log::error!(
                        "json deserialization error at line {}, column {}",
                        e.line(),
                        e.column()
                    );
                    Err(e)
                }
                t => t,
            }
        }?;

        let matched_song = find_match(info, migu_songs);

        if let Some(song) = matched_song {
            let serialized_audio_map = {
                let audio_map = song
                    .context
                    .clone()
                    .ok_or_else(|| anyhow::anyhow!("context must be able to retrieve"))?;

                serde_json::to_string(&audio_map)?
            };

            Ok(Some(
                SongSearchInformation::builder()
                    .source(ENGINE_ID.into())
                    .identifier(serialized_audio_map)
                    .song(Some(song))
                    .build(),
            ))
        } else {
            Ok(None)
        }
    }

    async fn retrieve<'a>(
        &self,
        identifier: &'a SerializedIdentifier,
        ctx: &'a Context,
    ) -> anyhow::Result<RetrievedSongInfo> {
        log::info!("Retrieving with Migu engine…");

        let availables_qualities = serde_json::from_str::<'_, HashMap<String, String>>(identifier)?;
        let prefered_qualities = if ctx.enable_flac {
            vec!["ZQ", "SQ", "HQ", "PQ"]
        } else {
            vec!["HQ", "PQ", "LQ"]
        };

        let matched_song_url = prefered_qualities
            .into_iter()
            .filter_map(|quality| availables_qualities.get(quality))
            .next();

        if let Some(url) = matched_song_url {
            Ok(RetrievedSongInfo::builder()
                .source(ENGINE_ID.into())
                .url(url.clone())
                .build())
        } else {
            Err(anyhow::anyhow!("Could not find any matched song"))
        }
    }
}

/// Construct the search API to request,
/// which the `keyword` will be encoded and trimmed.
fn construct_search_api(keyword: &str) -> anyhow::Result<Url> {
    Ok(Url::parse_with_params(
        r#"https://pd.musicapp.migu.cn/MIGUM2.0/v1.0/content/search_all.do?&ua=Android_migu&version=5.0.1&pageNo=1&pageSize=10&searchSwitch={"song":1,"album":0,"singer":0,"tagSong":0,"mvSong":0,"songlist":0,"bestShow":1}"#,
        &[("text", keyword.trim())],
    )?)
}

fn find_match(info: &Song, data: Vec<MiguResponse>) -> Option<Song> {
    log::debug!("Finding the matched song from data…");

    let SimilarSongSelector { selector, .. } = SimilarSongSelector::new(info);

    data.into_iter().map(Song::from).find(|s| selector(&s))
}

#[cfg(test)]
mod tests {
    use reqwest::Url;

    use crate::construct_search_api;

    #[test]
    fn construct_search_api_test() {
        let url = |u| Url::parse(u).unwrap();

        assert_eq!(construct_search_api("Twice - TT").unwrap(), url("https://pd.musicapp.migu.cn/MIGUM2.0/v1.0/content/search_all.do?&ua=Android_migu&version=5.0.1&pageNo=1&pageSize=10&searchSwitch={\"song\":1,\"album\":0,\"singer\":0,\"tagSong\":0,\"mvSong\":0,\"songlist\":0,\"bestShow\":1}&text=Twice+-+TT"));
        assert_eq!(construct_search_api("Twice").unwrap(), url("https://pd.musicapp.migu.cn/MIGUM2.0/v1.0/content/search_all.do?&ua=Android_migu&version=5.0.1&pageNo=1&pageSize=10&searchSwitch={\"song\":1,\"album\":0,\"singer\":0,\"tagSong\":0,\"mvSong\":0,\"songlist\":0,\"bestShow\":1}&text=Twice"));
        assert_eq!(construct_search_api("Twice    ").unwrap(), url("https://pd.musicapp.migu.cn/MIGUM2.0/v1.0/content/search_all.do?&ua=Android_migu&version=5.0.1&pageNo=1&pageSize=10&searchSwitch={\"song\":1,\"album\":0,\"singer\":0,\"tagSong\":0,\"mvSong\":0,\"songlist\":0,\"bestShow\":1}&text=Twice"));
        assert_eq!(construct_search_api("     TT").unwrap(), url("https://pd.musicapp.migu.cn/MIGUM2.0/v1.0/content/search_all.do?&ua=Android_migu&version=5.0.1&pageNo=1&pageSize=10&searchSwitch={\"song\":1,\"album\":0,\"singer\":0,\"tagSong\":0,\"mvSong\":0,\"songlist\":0,\"bestShow\":1}&text=TT"));
    }
}
