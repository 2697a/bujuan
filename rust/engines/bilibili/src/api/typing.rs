use serde::Deserialize;
use unm_types::{Artist, Song};

pub type SearchResult = BilibiliApiResponse<BilibiliSearchApiData>;
pub type TrackResult = BilibiliApiResponse<BilibiliTrackApiData>;

#[derive(Debug, Clone, Deserialize)]
#[non_exhaustive]
pub struct BilibiliSearchApiData {
    pub result: Vec<BilibiliSearchResult>,
}

#[derive(Debug, Clone, Deserialize)]
#[non_exhaustive]
pub struct BilibiliTrackApiData {
    pub cdns: Vec<String>,
}

#[derive(Debug, Clone, Deserialize)]
#[non_exhaustive]
pub struct BilibiliApiResponse<T> {
    pub data: T,
}

#[derive(Debug, Clone, Deserialize)]
#[non_exhaustive]
pub struct BilibiliSearchResult {
    /// The song ID.
    pub id: i64,

    /// The song name.
    pub title: String,

    /// The artist ID.
    pub mid: i64,

    /// The artist name.
    pub author: String,
}

impl From<BilibiliSearchResult> for Song {
    fn from(result: BilibiliSearchResult) -> Self {
        log::trace!("Converting BilibiliSearchResult to Song…");

        Song::builder()
            .id(result.id.to_string())
            .name(result.title)
            .artists(vec![Artist::builder()
                .id(result.mid.to_string())
                .name(result.author)
                .build()])
            .build()
    }
}

impl BilibiliTrackApiData {
    pub fn get_music_url(&self) -> Option<String> {
        log::debug!("Getting the URL from BilibiliTrackApiData…");

        self.cdns.get(0).map(|s| s.replace("https", "http"))
    }
}
