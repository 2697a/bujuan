//! UNM Engine: QQ
//!
//! You may need to login your QQ Music account in your browser,
//! obtain its cookie and fill the cookie to the `qq:cookie` config.
//!
//! You can configure the cookie in the `ctx.config` field.
//! You can build a `ctx.config` with [`unm_types::config::ConfigManagerBuilder`],
//! for example:
//!
//! ```
//! use unm_types::{ContextBuilder, config::ConfigManagerBuilder};
//!
//! let config = ConfigManagerBuilder::new()
//!     .set("qq:cookie", r#"uin=<your_uin>; qm_keyst=<your_qm_keyst>;"#)
//!     .build();
//!
//! let context = ContextBuilder::default()
//!     .config(config)
//!     .build();
//! ```

pub mod api;

use api::{retrieve_single, search_by_keyword};
use async_trait::async_trait;
use log::{debug, info};
use unm_engine::interface::Engine;
use unm_selector::SimilarSongSelector;
use unm_types::{Context, RetrievedSongInfo, SerializedIdentifier, Song, SongSearchInformation};

pub const ENGINE_ID: &str = "qq";

pub struct QQEngine;

#[async_trait]
impl Engine for QQEngine {
    async fn search<'a>(
        &self,
        info: &'a Song,
        ctx: &'a Context,
    ) -> anyhow::Result<Option<SongSearchInformation>> {
        info!("Searching {info} with QQ Engine…");

        let response = search_by_keyword(&info.keyword(), ctx).await?;
        let mut song_iterator = response
            .list
            .into_iter()
            .filter(|song| !song.mid.is_empty())
            .map(Song::from);

        debug!("Matching the song…");
        let SimilarSongSelector { selector, .. } = SimilarSongSelector::new(info);
        let matched = song_iterator.find(|s| selector(&s));

        Ok(matched.map::<anyhow::Result<_>, _>(|song| Ok({
            SongSearchInformation::builder()
                .source(ENGINE_ID.into())
                .identifier(
                    song.context
                        .as_ref()
                        .and_then(|ctx| ctx.get("identifier"))
                        .ok_or_else(|| anyhow::anyhow!("failed to extract 'identifier' from song context – it should not be happened!"))?
                        .clone()
                )
                .song(Some(song))
                .build()
        })).transpose()?)
    }

    async fn retrieve<'a>(
        &self,
        identifier: &'a SerializedIdentifier,
        ctx: &'a Context,
    ) -> anyhow::Result<RetrievedSongInfo> {
        info!("Retrieving {identifier} with QQ Engine…");

        let response = retrieve_single(identifier, ctx).await?;

        let url = response
            .data
            .map(|v| v.get_url())
            .ok_or_else(|| anyhow::anyhow!("no data found"))??;

        Ok(RetrievedSongInfo::builder()
            .source(ENGINE_ID.into())
            .url(url)
            .build())
    }
}

#[cfg(test)]
mod tests {
    use tokio::test;
    use unm_types::{Artist, Context};

    use super::*;

    fn get_info_1() -> Song {
        // https://music.163.com/api/song/detail?ids=[385552]
        Song::builder()
            .name("干杯".to_string())
            .artists(vec![Artist::builder().name("五月天".to_string()).build()])
            .build()
    }

    #[test]
    #[ignore]
    async fn qq_search() {
        let info = get_info_1();
        let info = QQEngine
            .search(&info, &Context::default())
            .await
            .unwrap()
            .unwrap();

        assert!(info.identifier.contains(":::"));
        assert_eq!(info.source, ENGINE_ID);
    }
}
