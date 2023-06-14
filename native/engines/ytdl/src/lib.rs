//! UNM Engine: ytdl
//!
//! It can fetch audio from YouTube with
//! the specified `youtube-dl`-like command.
//!
//! The default is `yt-dlp`. You can configure it by configuring
//! `ytdl:exe` in the ctx.config field. You can build `ctx.config` with
//! [`unm_types::config::ConfigManagerBuilder`], for example:
//!
//! ```
//! use unm_types::{ContextBuilder, config::ConfigManagerBuilder};
//!
//! let config = ConfigManagerBuilder::new()
//!     .set("ytdl:exe", "youtube-dl")
//!     .build();
//!
//! let context = ContextBuilder::default()
//!     .config(config)
//!     .build();
//! ```

use std::borrow::Cow;

use concat_string::concat_string;
use log::{debug, info};
use serde::Deserialize;
use unm_engine::interface::Engine;
use unm_types::config::ConfigManager;
use unm_types::{
    Artist,
    Context,
    RetrievedSongInfo,
    SerializedIdentifier,
    Song,
    SongSearchInformation,
};

pub const DEFAULT_EXECUTABLE: &str = "yt-dlp";
pub const ENGINE_ID: &str = "ytdl";

/// The response that the `youtube-dl` instance will return.
#[derive(Deserialize)]
#[non_exhaustive]
struct YtDlResponse {
    /// The YouTube video ID.
    id: String,
    /// The YouTube video title.
    title: String,
    /// The audio URL.
    url: String,
    /// The duration of this audio (sec).
    duration: i32,
    /// The uploader's YouTube channel ID.
    uploader_id: String,
    /// The uploader's YouTube channel name.
    uploader: String,
}

/// The search and track engine powered by the `youtube-dl`-like command.
pub struct YtDlEngine;

#[async_trait::async_trait]
impl Engine for YtDlEngine {
    async fn search<'a>(
        &self,
        info: &'a Song,
        ctx: &'a Context,
    ) -> anyhow::Result<Option<SongSearchInformation>> {
        let exe = decide_ytdl_exe(&ctx.config);

        info!("Searching for {info} with {exe}…");

        let response = fetch_from_youtube(exe, &info.keyword(), ctx.proxy_uri.as_deref()).await?;

        // We return the URL we got from youtube-dl as the song identifier,
        // so we can return the URL in retrieve() easily.
        if let Some(response) = response {
            let url = response.url.to_string();
            let song = Song::from(response);
            Ok(Some(
                SongSearchInformation::builder()
                    .source(ENGINE_ID.into())
                    .identifier(url)
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
        _: &'a Context,
    ) -> anyhow::Result<RetrievedSongInfo> {
        info!("Retrieving {identifier}…");

        // We just return the identifier as the URL of song.
        Ok(RetrievedSongInfo::builder()
            .source(ENGINE_ID.into())
            .url(identifier.to_string())
            .build())
    }
}

fn decide_ytdl_exe(config: &Option<ConfigManager>) -> &str {
    debug!("Deciding the executable to use in `ytdl` engine…");

    config
        .as_ref()
        .map(|c| c.get_or_default(Cow::Borrowed("ytdl:exe"), DEFAULT_EXECUTABLE))
        .unwrap_or(DEFAULT_EXECUTABLE)
}

/// Get the response from `<exe>`.
///
/// The `<exe>` should be a `youtube-dl`-like command,
/// such as `yt-dlp` or `youtube-dl`.
///
/// ```plain
/// <exe> -f bestaudio --dump-json [--proxy <proxy>] "ytsearch1:<keyword> official lyric audio music"
///     -f bestaudio    choose the best quality of the audio
///     --dump-json     dump the information as JSON without downloading it
///     --proxy URL     Use the specified HTTP/HTTPS/SOCKS proxy.
///                     To enable SOCKS proxy, specify a proper
///                     scheme. For example
///                     socks5://user:pass@127.0.0.1:1080/. Pass in
///                     an empty string (--proxy "") for direct
///                     connection
/// ```
async fn fetch_from_youtube(
    exe: &str,
    keyword: &str,
    proxy: Option<&str>,
) -> anyhow::Result<Option<YtDlResponse>> {
    info!("Calling external application “{exe}”!");

    let mut cmd = tokio::process::Command::new(exe);

    debug!("Receiving the search result from {exe}…");

    // <cmd> -f bestaudio --dumpjson
    cmd.args(["-f", "bestaudio", "--dump-json"]);

    // --proxy <proxy>
    if let Some(proxy) = proxy {
        cmd.args(["--proxy", proxy]);
    }

    // search query
    cmd.arg(concat_string!(
        "ytsearch1:",
        keyword,
        " official lyric audio music"
    ));

    // (Windows only) Don't show the `yt-dlp` window
    #[cfg(target_os = "windows")]
    {
        // Hide the window. See https://docs.microsoft.com/en-us/windows/win32/procthread/process-creation-flags#CREATE_NO_WINDOW
        cmd.creation_flags(winapi::um::winbase::CREATE_NO_WINDOW);
    }

    let child = cmd.kill_on_drop(true).output().await?;

    if child.status.success() {
        let response = String::from_utf8_lossy(&child.stdout);

        Ok(if response.is_empty() {
            None
        } else {
            debug!("Serializing the search result…");
            let json = serde_json::from_str::<'_, YtDlResponse>(&response)?;
            Some(json)
        })
    } else {
        log::error!("Failed to run `{exe}`.");
        log::error!("Code: {code:?}", code = child.status.code());
        log::error!("Stderr: {}", String::from_utf8_lossy(&child.stderr));

        Err(anyhow::anyhow!("Failed to run `{exe}`."))
    }
}

impl From<YtDlResponse> for Song {
    fn from(res: YtDlResponse) -> Self {
        debug!("Formatting response…");

        Song::builder()
            .id(res.id)
            .name(res.title)
            .artists(vec![Artist::builder()
                .id(res.uploader_id)
                .name(res.uploader)
                .build()])
            .duration(Some(res.duration as i64 * 1000))
            .build()
    }
}

#[cfg(test)]
mod tests {
    use unm_types::config::ConfigManagerBuilder;

    #[test]
    fn test_decide_ytdl_exe() {
        use super::*;

        assert_eq!(decide_ytdl_exe(&None), DEFAULT_EXECUTABLE);

        let config = ConfigManagerBuilder::new().build();
        assert_eq!(decide_ytdl_exe(&Some(config)), DEFAULT_EXECUTABLE);

        let config = ConfigManagerBuilder::new()
            .set("ytdl:exe", "youtube-dl".to_string())
            .build();
        assert_eq!(decide_ytdl_exe(&Some(config)), "youtube-dl");
    }
}
