//! UNM Engine: Kugou
//!
//! It can fetch audio from Kugou Music.

use std::collections::HashMap;
use std::sync::Arc;

use async_trait::async_trait;
use concat_string::concat_string;
use futures::FutureExt;
use log::{debug, info};
use reqwest::Url;
use serde::{Deserialize, Serialize};
use unm_engine::interface::Engine;
use unm_request::build_client;
use unm_request::json::{Json, UnableToExtractJson};
use unm_selector::SimilarSongSelector;
use unm_types::{
    Album,
    Context,
    RetrievedSongInfo,
    SerializedIdentifier,
    Song,
    SongSearchInformation,
};

pub const ENGINE_ID: &str = "kugou";

/// The search and track engine powered by Kugou Music.
pub struct KugouEngine;

/// The context for determining the song to fetch from Kugou Music.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KugouSongContext {
    /// The ID of standard audio.
    pub id: Option<String>,
    /// The ID of HQ audio.
    pub id_hq: Option<String>,
    /// The ID of SQ audio.
    pub id_sq: Option<String>,
}

#[derive(Clone, Copy, Debug)]
pub enum KugouFormat {
    Hash,
    HqHash,
    SqHash,
}

impl AsRef<str> for KugouFormat {
    fn as_ref(&self) -> &str {
        match self {
            KugouFormat::Hash => "hash",
            KugouFormat::HqHash => "hqhash",
            KugouFormat::SqHash => "sqhash",
        }
    }
}

impl std::fmt::Display for KugouFormat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.as_ref())
    }
}

impl From<KugouSongContext> for HashMap<String, String> {
    fn from(ctx: KugouSongContext) -> Self {
        debug!("Constructing the context HashMap from KugouSongContext…");

        let mut map = HashMap::with_capacity(3);

        [
            (KugouFormat::Hash, ctx.id),
            (KugouFormat::HqHash, ctx.id_hq),
            (KugouFormat::SqHash, ctx.id_sq),
        ]
        .into_iter()
        .for_each(|(f, id)| {
            if let Some(id) = id {
                map.insert(f.to_string(), id);
            }
        });

        map
    }
}

#[async_trait]
impl Engine for KugouEngine {
    async fn search<'a>(
        &self,
        info: &'a Song,
        ctx: &'a Context,
    ) -> anyhow::Result<Option<SongSearchInformation>> {
        let response = search(info, ctx).await;

        match response {
            Ok(response) => match response {
                Some(response) => Ok(Some(
                    SongSearchInformation::builder()
                        .source(ENGINE_ID.into())
                        .identifier(serde_json::to_string(&response)?)
                        .song(Some(response))
                        .build(),
                )),
                None => Ok(None),
            },
            Err(err) => Err(err),
        }
    }

    async fn retrieve<'a>(
        &self,
        identifier: &'a SerializedIdentifier,
        ctx: &'a Context,
    ) -> anyhow::Result<RetrievedSongInfo> {
        info!("Retrieving the identifier with Kugou Engine…");

        let song: Arc<Song> = Arc::new(serde_json::from_str(identifier)?);

        let format_to_fetch = if ctx.enable_flac {
            [KugouFormat::SqHash, KugouFormat::HqHash]
        } else {
            [KugouFormat::HqHash, KugouFormat::Hash]
        };

        let song_futures = format_to_fetch.into_iter().map(|format| {
            let song = song.clone();

            async move {
                let response = single(&song, format, ctx).await;
                match response {
                    Ok(response) => match response {
                        Some(response) => Ok(response),
                        None => Err(anyhow::anyhow!(
                            "unable to retrieve the format “{format}” of song"
                        )),
                    },
                    Err(err) => Err(err),
                }
            }
            .boxed()
        });

        let url = futures::future::select_ok(song_futures).await?.0;

        Ok(RetrievedSongInfo::builder()
            .url(url)
            .source(ENGINE_ID.into())
            .build())
    }
}

fn format(entry: &Json) -> anyhow::Result<Song> {
    debug!("Formatting the response from Kugou Music…");

    let valstr = |key| {
        entry[key]
            .as_str()
            .ok_or(UnableToExtractJson {
                json_pointer: key,
                expected_type: "string",
            })
            .map(|v| v.to_string())
    };

    Ok(Song::builder()
        .id(valstr("hash")?)
        .name(valstr("songname")?)
        .duration(entry["duration"].as_i64().map(|v| v * 1000))
        .artists(vec![])
        .album(Some(
            Album::builder()
                .id(valstr("album_id")?)
                .name(valstr("album_name")?)
                .build(),
        ))
        .context(Some(
            KugouSongContext {
                id: entry["hash"].as_str().map(|v| v.to_string()),
                id_hq: entry["320hash"].as_str().map(|v| v.to_string()),
                id_sq: entry["sqhash"].as_str().map(|v| v.to_string()),
            }
            .into(),
        ))
        .build())
}

/// Search and get song (with metadata) from Kugou Music.
pub async fn search(info: &Song, ctx: &Context) -> anyhow::Result<Option<Song>> {
    info!("Searching with Kugou Engine…");

    let client = build_client(ctx.proxy_uri.as_deref())?;
    let url = Url::parse_with_params(
        "http://mobilecdn.kugou.com/api/v3/search/song?page=1&pagesize=10",
        &[("keyword", &info.keyword())],
    )?;

    let response = client.get(url).send().await?;
    let data = response.json::<Json>().await?;

    debug!("Extracting data…");
    let lists = data
        .pointer("/data/info")
        .and_then(|v| v.as_array())
        .ok_or(UnableToExtractJson {
            json_pointer: "/data/info",
            expected_type: "string",
        })?;

    debug!("Finding the similar song…");
    let SimilarSongSelector { selector, .. } = SimilarSongSelector::new(info);
    let similar_song = lists
        .iter()
        .map(format)
        .filter_map(|v| v.ok())
        .find(|s| selector(&s));

    Ok(similar_song)
}

pub async fn single(
    song: &Song,
    format: KugouFormat,
    ctx: &Context,
) -> anyhow::Result<Option<String>> {
    debug!("Retriving the audio file in the format “{format}” from “{song}”…");

    let hash = extract_hash_id(song, format)?;
    let key = concat_string!(hash, "kgcloudv2");

    let album_id = song
        .album
        .as_ref()
        .map(|v| v.id.to_string())
        .unwrap_or_else(|| String::from(""));

    let client = build_client(ctx.proxy_uri.as_deref())?;
    let url = Url::parse_with_params(
        "http://trackercdn.kugou.com/i/v2/?appid=1005&pid=2&cmd=25&behavior=play",
        &[("key", &key), ("hash", &hash), ("album_id", &album_id)],
    )?;

    let response = client.get(url).send().await?;
    let data = response.json::<Json>().await?;

    Ok(data
        .pointer("/url/0")
        .and_then(|v| v.as_str())
        .map(|v| v.to_string()))
}

pub fn extract_hash_id(song: &Song, format: KugouFormat) -> anyhow::Result<String> {
    debug!("Extracting hash id from the song “{song}”…");

    if let Some(ref ctx) = song.context {
        if let Some(format) = ctx.get(format.as_ref()) {
            Ok(format.clone())
        } else {
            Err(anyhow::anyhow!("No such a format: {format}"))
        }
    } else {
        Err(anyhow::anyhow!(
            "No context: seems like not a valid Kugou song."
        ))
    }
}
