use std::collections::HashMap;

use serde::{Deserialize, Serialize};
use unm_types::{Album, Artist, Song};

#[derive(Debug, PartialEq)]
struct MiguAudioSource {
    format_type: MiguFormatType,
    url: String,
}

struct MergedAudioFileMap(pub HashMap<String, String>);

/// Could be one of: `LQ` (96k), `PQ` (128k),
/// `HQ` (320k), `SQ` (Flac) or `ZQ` (24-bit flac)
type MiguFormatType = String;

#[derive(Serialize, Deserialize)]
#[serde(untagged)]
pub enum MiguRateFormat {
    #[non_exhaustive]
    NormalQualityFormat {
        #[serde(rename = "formatType")]
        format_type: String,
        url: String,
    },
    #[non_exhaustive]
    HighQualityFormat {
        #[serde(rename = "formatType")]
        format_type: String,
        #[serde(rename = "iosUrl")]
        ios_url: String, // m4a, not used
        #[serde(rename = "androidUrl")]
        android_url: String, // flac
    },
}

#[derive(Serialize, Deserialize)]
#[non_exhaustive]
pub struct MiguSinger {
    id: String,
    name: String,
}

#[derive(Serialize, Deserialize)]
#[non_exhaustive]
pub struct MiguAlbum {
    id: String,
    name: String,
}

#[derive(Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
#[non_exhaustive]
pub struct MiguResponse {
    id: String,
    name: String,
    singers: Vec<MiguSinger>,
    albums: Option<Vec<MiguAlbum>>,
    rate_formats: Vec<MiguRateFormat>,
    new_rate_formats: Vec<MiguRateFormat>,
}

impl From<MiguRateFormat> for MiguAudioSource {
    fn from(value: MiguRateFormat) -> Self {
        let correct_url =
            |url: String| url.replace("ftp://218.200.160.122:21", "http://freetyst.nf.migu.cn");

        match value {
            MiguRateFormat::NormalQualityFormat {
                format_type, url, ..
            } => MiguAudioSource {
                format_type,
                url: correct_url(url),
            },
            MiguRateFormat::HighQualityFormat {
                format_type,
                android_url,
                ..
            } => MiguAudioSource {
                format_type,
                url: correct_url(android_url),
            },
        }
    }
}

impl From<MiguSinger> for Artist {
    fn from(singer: MiguSinger) -> Self {
        Self::builder().id(singer.id).name(singer.name).build()
    }
}

impl From<MiguAlbum> for Album {
    fn from(singer: MiguAlbum) -> Self {
        Self::builder().id(singer.id).name(singer.name).build()
    }
}

impl From<MiguResponse> for Song {
    fn from(response: MiguResponse) -> Self {
        log::trace!("Converting MiguResponse to Song…");

        let id = response.id;
        let name = response.name;
        let artists = response
            .singers
            .into_iter()
            .map(Artist::from)
            .collect::<Vec<Artist>>();

        // Return the first album recorded in Migu Music if
        // there are at least one albums. Otherwise, return None.
        let album = {
            let album = response.albums.and_then(|album| album.into_iter().next());
            album.map(Album::from)
        };

        let rate_format = response.rate_formats.into_iter().map(Into::into);
        let new_rate_format = response.new_rate_formats.into_iter().map(Into::into);
        let context = MergedAudioFileMap::merge(rate_format, new_rate_format);

        Self::builder()
            .id(id)
            .name(name)
            .artists(artists)
            .album(album)
            .context(Some(context.0))
            .build()
    }
}

impl MergedAudioFileMap {
    pub fn merge(
        rate_format: impl Iterator<Item = MiguAudioSource>,
        new_rate_format: impl Iterator<Item = MiguAudioSource>,
    ) -> Self {
        log::trace!("Merging rate formats…");

        let mut map = HashMap::new();

        rate_format.for_each(|source| {
            log::trace!("rate_format: {}", source.format_type);
            map.insert(source.format_type, source.url);
        });

        new_rate_format.for_each(|source| {
            log::trace!("new_rate_format: {}", source.format_type);

            if map.insert(source.format_type, source.url).is_some() {
                log::trace!("Get duplicated format type. Use new_rate_format one.");
            }
        });

        Self(map)
    }
}

#[cfg(test)]
mod tests {
    use std::collections::HashMap;

    use crate::types::{MiguAudioSource, MiguRateFormat};

    #[test]
    fn test_migu_rate_format_to_string_tuple() {
        let rate_format_nq = MiguRateFormat::NormalQualityFormat {
            format_type: "LQ".to_string(),
            url: "ftp://218.200.160.122:21/lq.mp3".to_string(),
        };
        let rate_format_hq = MiguRateFormat::HighQualityFormat {
            format_type: "HQ".to_string(),
            ios_url: "ftp://218.200.160.122:21/sq.aac".to_string(),
            android_url: "ftp://218.200.160.122:21/sq.flac".to_string(),
        };
        let rate_format_hq_nd = MiguRateFormat::HighQualityFormat {
            format_type: "HQ".to_string(),
            ios_url: "https://somewhere.tld/sq.aac".to_string(),
            android_url: "https://somewhere.tld/sq.flac".to_string(),
        };

        let nq_tuple = MiguAudioSource::from(rate_format_nq);
        let hq_tuple = MiguAudioSource::from(rate_format_hq);
        let hq_nd_tuple = MiguAudioSource::from(rate_format_hq_nd);

        assert_eq!(
            nq_tuple,
            MiguAudioSource {
                format_type: "LQ".to_string(),
                url: "http://freetyst.nf.migu.cn/lq.mp3".to_string(),
            }
        );
        assert_eq!(
            hq_tuple,
            MiguAudioSource {
                format_type: "HQ".to_string(),
                url: "http://freetyst.nf.migu.cn/sq.flac".to_string(),
            }
        );
        assert_eq!(
            hq_nd_tuple,
            MiguAudioSource {
                format_type: "HQ".to_string(),
                url: "https://somewhere.tld/sq.flac".to_string(),
            }
        );
    }

    #[test]
    fn test_merge_rate_format() {
        let rate_format = vec![
            MiguAudioSource {
                format_type: "LQ".to_string(),
                url: "http://freetyst.nf.migu.cn/lq.mp3".to_string(),
            },
            MiguAudioSource {
                format_type: "SQ".to_string(),
                url: "ftp://218.200.160.122:21/sq.flac".to_string(),
            },
        ]
        .into_iter();
        let new_rate_format = vec![
            MiguAudioSource {
                format_type: "SQ".to_string(),
                url: "http://somewhere.tld/sq2.flac".to_string(),
            },
            MiguAudioSource {
                format_type: "XQ".to_string(),
                url: "http://freetyst.nf.migu.cn/xq.flac".to_string(),
            },
        ]
        .into_iter();

        let expected = {
            let mut hm = HashMap::with_capacity(3);

            hm.insert(
                "LQ".to_string(),
                "http://freetyst.nf.migu.cn/lq.mp3".to_string(),
            );
            hm.insert(
                "SQ".to_string(),
                "http://somewhere.tld/sq2.flac".to_string(),
            );
            hm.insert(
                "XQ".to_string(),
                "http://freetyst.nf.migu.cn/xq.flac".to_string(),
            );

            hm
        };
        let merged_map = super::MergedAudioFileMap::merge(rate_format, new_rate_format);

        assert_eq!(merged_map.0, expected);
    }
}
