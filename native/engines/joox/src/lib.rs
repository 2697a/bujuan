//! UNM Engine: Joox
//!
//! You may need to register a Joox account,
//! obtain its cookie and fill the cookie to
//! the `joox:cookie` config.
//!
//! You can configure the cookie in the `ctx.config` field.
//! You can build a `ctx.config` with [`unm_types::config::ConfigManagerBuilder`],
//! for example:
//!
//! ```
//! use unm_types::{ContextBuilder, config::ConfigManagerBuilder};
//!
//! let config = ConfigManagerBuilder::new()
//!     .set("joox:cookie", r#"wmid=<your_wmid>; session_key=<your_session_key>;"#)
//!     .build();
//!
//! let context = ContextBuilder::default()
//!     .config(config)
//!     .build();
//! ```

use std::borrow::Cow;

use base64::prelude::*;
use base64::Engine as B64Engine;
use http::header::{COOKIE, ORIGIN, REFERER};
use http::HeaderValue;
use once_cell::sync::OnceCell;
use regex::Regex;
use reqwest::header::HeaderMap;
use reqwest::Url;
use unm_engine::interface::Engine;
use unm_request::build_client;
use unm_request::ext::ResponseExt;
use unm_request::json::{Json, UnableToExtractJson};
use unm_selector::SimilarSongSelector;
use unm_types::{
    Album,
    Artist,
    Context,
    RetrievedSongInfo,
    SerializedIdentifier,
    Song,
    SongSearchInformation,
};

static REPLACE_AUDIO_URL_REGEX: OnceCell<Regex> = OnceCell::new();

pub const ENGINE_ID: &str = "joox";
pub struct JooxEngine;

#[async_trait::async_trait]
impl Engine for JooxEngine {
    async fn search<'a>(
        &self,
        song: &'a Song,
        ctx: &'a Context,
    ) -> anyhow::Result<Option<SongSearchInformation>> {
        log::debug!("Searching “{song}” with Joox Engine…");

        let keyword = fit(song);
        let joox_cookie = get_cookie(ctx);

        let client = build_client(ctx.proxy_uri.as_deref())?;
        let url = Url::parse_with_params(
            "http://api-jooxtt.sanook.com/web-fcgi-bin/web_search",
            &[
                ("country", "hk"),
                ("lang", "zh_TW"),
                ("sin", "0"),
                ("ein", "30"),
                ("search_input", keyword.as_str()),
            ],
        )?;

        let response = client
            .get(url)
            .headers(construct_header(joox_cookie)?)
            .send()
            .await?;

        log::debug!("Deserializing the response of “{song}”…");
        let json_string = response.text().await?.replace('\'', "\"");
        let json = serde_json::from_str::<Json>(&json_string)?;

        log::debug!("Converting the Joox response to Vec<Song>…");
        let empty = Vec::new();
        let mut song_iterator = json["itemlist"]
            .as_array()
            .unwrap_or(&empty)
            .iter()
            .map(format)
            .filter_map(|v| match v {
                Ok(v) => Some(v),
                Err(e) => {
                    log::warn!("Failed to parse an item: {e}. Ignoring.");
                    None
                }
            });

        log::debug!("Selecting the similar song…");
        let SimilarSongSelector { selector, .. } = SimilarSongSelector::new(song);
        let matched = song_iterator.find(|s| selector(&s));

        Ok(matched.map(|matched| {
            SongSearchInformation::builder()
                .source(ENGINE_ID.into())
                .identifier(matched.id.clone())
                .song(Some(matched))
                .build()
        }))
    }

    /// Retrieve the audio URL of the specified `identifier`.
    async fn retrieve<'a>(
        &self,
        identifier: &'a SerializedIdentifier,
        ctx: &'a Context,
    ) -> anyhow::Result<RetrievedSongInfo> {
        log::debug!("Retrieving with Joox Engine…");

        let replace_audio_url_regex = REPLACE_AUDIO_URL_REGEX
            .get_or_init(|| Regex::new(r#"M\d00([\w]+).mp3"#).expect("should be constructable"));
        let joox_cookie = get_cookie(ctx);

        let client = build_client(ctx.proxy_uri.as_deref())?;
        let url = Url::parse_with_params(
            "http://api.joox.com/web-fcgi-bin/web_get_songinfo",
            &[
                ("country", "hk"),
                ("lang", "zh_cn"),
                ("from_type", "-1"),
                ("channel_id", "-1"),
                ("song_id", identifier),
                ("_", &get_timestamp().to_string()),
            ],
        )?;

        let response = client
            .get(url)
            .headers(construct_header(joox_cookie)?)
            .send()
            .await?;
        let json = response.jsonp::<Json>().await?;

        let raw_audio_url = ["r320Url", "r192Url", "mp3Url", "m4aUrl"]
            .into_iter()
            .filter_map(|k| json[k].as_str())
            .next();
        let audio_url = raw_audio_url.map(|u| replace_audio_url_regex.replace(u, "M800$1.mp3"));

        if let Some(url) = audio_url {
            Ok(RetrievedSongInfo::builder()
                .source(ENGINE_ID.into())
                .url(url.to_string())
                .build())
        } else {
            Err(anyhow::anyhow!("No audio URL found."))
        }
    }
}

fn get_cookie(context: &Context) -> Option<&str> {
    if let Some(ref config) = context.config {
        config.get_deref(Cow::Borrowed("joox:cookie"))
    } else {
        None
    }
}

fn construct_header(cookie: Option<&str>) -> anyhow::Result<HeaderMap> {
    log::debug!("Constructing the header for Joox…");

    let mut hm = HeaderMap::new();

    hm.insert(ORIGIN, HeaderValue::from_static("http://www.joox.com"));
    hm.insert(REFERER, HeaderValue::from_static("http://www.joox.com"));

    if let Some(cookie) = cookie {
        hm.insert(COOKIE, HeaderValue::from_str(cookie)?);
    }

    Ok(hm)
}

fn fit(song: &Song) -> String {
    log::debug!("Fitting the keyword {song}…");
    let is_japanese_character = |c| matches!(c, '\u{0800}'..='\u{4e00}');

    if song.name.chars().any(is_japanese_character) {
        log::debug!("Has Japanese characters, return only the name…");
        song.name.clone()
    } else {
        log::debug!("No Japanese characters, return keyword…");
        song.keyword()
    }
}

fn format(item: &Json) -> anyhow::Result<Song> {
    log::debug!("Formatting a Joox song item…");

    let valstr = |data: &Json, json_pointer| {
        data.as_str()
            .map(ToString::to_string)
            .ok_or(UnableToExtractJson {
                json_pointer,
                expected_type: "str",
            })
    };

    let vali64 = |data: &Json, json_pointer| {
        data.as_i64().ok_or(UnableToExtractJson {
            json_pointer,
            expected_type: "i64",
        })
    };

    let b64_opt_decode = |data: Option<&str>| -> anyhow::Result<String> {
        if let Some(data) = data {
            let bytes = &BASE64_STANDARD.decode(data).unwrap()[..];
            Ok(String::from_utf8_lossy(bytes).to_string())
        } else {
            Ok("".to_string())
        }
    };

    let artists = item["singer_list"]
        .as_array()
        .unwrap_or(&vec![])
        .iter()
        .map(|singer| -> anyhow::Result<Artist> {
            Ok(Artist::builder()
                .id(vali64(&singer["id"], "/singer_list/?/id")?.to_string())
                .name(b64_opt_decode(singer["name"].as_str())?)
                .build())
        })
        .filter_map(|v| match v {
            Ok(v) => Some(v),
            Err(e) => {
                log::warn!("Failed to parse the artist: {e}. Ignoring.");
                None
            }
        })
        .collect::<Vec<Artist>>();

    Ok(Song::builder()
        .id(valstr(&item["songid"], "/songid")?)
        .name(b64_opt_decode(item["info1"].as_str())?)
        .duration(Some(vali64(&item["playtime"], "/playtime")? * 1000))
        .album(Some(
            Album::builder()
                .id(valstr(&item["albummid"], "/albummid")?)
                .name(b64_opt_decode(item["info3"].as_str())?)
                .build(),
        ))
        .artists(artists)
        .build())
}

fn get_timestamp() -> u128 {
    use std::time::SystemTime;

    SystemTime::now()
        .duration_since(SystemTime::UNIX_EPOCH)
        .map(|v| v.as_millis())
        .unwrap_or(0)
}
