use std::collections::HashMap;

use napi::bindgen_prelude::*;
use napi_derive::napi;
use unm_types::{config::ConfigManager, ContextBuilder};

/// The search mode.
#[napi]
pub enum SearchMode {
  /// Return the first response.
  ///
  /// For example, `["a", "b", "c"]` and `"c"` returns the fast,
  /// we return `"c"`.
  ///
  /// This is the default mode.
  FastFirst,
  /// Return according to the order of the response.
  ///
  /// For example, even if `["a", "b", "c"]` and `"c"` returns the fast,
  /// we still wait for `"a"` and return `"a"`. If `"a"` has no result,
  /// we return `"b"`.
  OrderFirst,
}

/// [napi-rs] The metadata of the artist of a song.
#[napi(object)]
pub struct Artist {
  /// The identifier of this artist.
  pub id: String,
  /// The name of this artist.
  pub name: String,
}

/// [napi-rs] The metadata of the album of a song.
#[napi(object)]
pub struct Album {
  /// The identifier of this artist.
  pub id: String,
  /// The name of this album.
  pub name: String,
}

/// [napi-rs] The metadata of a song.
#[napi(object)]
pub struct Song {
  /// The identifier of this song.
  pub id: String,
  /// The name of this song.
  pub name: String,
  /// The duration of this song.
  pub duration: Option<i64>,
  /// The artist of this song.
  pub artists: Vec<Artist>,
  /// The album of this song.
  pub album: Option<Album>,
  /// The context of this song.
  ///
  /// For example, the URI identifier of this song.
  pub context: Option<HashMap<String, String>>,
}

/// [napi-rs] The song identifier with the engine information.
#[napi(object)]
pub struct SongSearchInformation {
  /// The retrieve source of this song, for example: `bilibili`.
  pub source: String,
  /// The serialized identifier of this song.
  pub identifier: String,
  /// The details of this song.
  pub song: Option<Song>,
  /// The pre-retrieve result of this search.
  pub pre_retrieve_result: Option<RetrievedSongInfo>,
}

/// [napi-rs] The information of the song retrieved with `retrieve()`.
#[napi(object)]
pub struct RetrievedSongInfo {
  /// The retrieve source of this song, for example: `bilibili`.
  pub source: String,
  /// The URL of this song.
  pub url: String,
}

/// [napi-rs] The context.
#[napi(object)]
pub struct Context {
  /// The proxy URI
  pub proxy_uri: Option<String>,

  /// Whether to enable FLAC support.
  pub enable_flac: Option<bool>,

  /// The search mode for waiting the response.
  pub search_mode: Option<SearchMode>,

  /// The config for engines.
  pub config: Option<HashMap<String, String>>,
}

impl From<SearchMode> for unm_types::SearchMode {
  fn from(mode: SearchMode) -> Self {
    match mode {
      SearchMode::FastFirst => Self::FastFirst,
      SearchMode::OrderFirst => Self::OrderFirst,
    }
  }
}

impl From<Artist> for unm_types::Artist {
  fn from(artist: Artist) -> Self {
    Self::builder().id(artist.id).name(artist.name).build()
  }
}

impl From<unm_types::Artist> for Artist {
  fn from(artist: unm_types::Artist) -> Self {
    Self {
      id: artist.id,
      name: artist.name,
    }
  }
}

impl From<Album> for unm_types::Album {
  fn from(album: Album) -> Self {
    Self::builder().id(album.id).name(album.name).build()
  }
}

impl From<unm_types::Album> for Album {
  fn from(album: unm_types::Album) -> Self {
    Self {
      id: album.id,
      name: album.name,
    }
  }
}

impl From<Song> for unm_types::Song {
  fn from(song: Song) -> Self {
    Self::builder()
      .id(song.id)
      .name(song.name)
      .duration(song.duration)
      .artists(song.artists.into_iter().map(Into::into).collect())
      .album(song.album.map(Into::into))
      .context(song.context)
      .build()
  }
}

impl From<unm_types::Song> for Song {
  fn from(song: unm_types::Song) -> Self {
    Self {
      id: song.id,
      name: song.name,
      duration: song.duration,
      artists: song.artists.into_iter().map(Into::into).collect(),
      album: song.album.map(Into::into),
      context: song.context,
    }
  }
}

impl From<unm_types::SongSearchInformation> for SongSearchInformation {
  fn from(song_information: unm_types::SongSearchInformation) -> Self {
    Self {
      source: song_information.source.to_string(),
      identifier: song_information.identifier,
      song: song_information.song.map(Into::into),
      pre_retrieve_result: song_information.pre_retrieve_result.map(Into::into),
    }
  }
}

impl From<SongSearchInformation> for unm_types::SongSearchInformation {
  fn from(song_information: SongSearchInformation) -> Self {
    Self::builder()
      .source(song_information.source.into())
      .identifier(song_information.identifier)
      .song(song_information.song.map(Into::into))
      .pre_retrieve_result(song_information.pre_retrieve_result.map(Into::into))
      .build()
  }
}

impl From<unm_types::RetrievedSongInfo> for RetrievedSongInfo {
  fn from(song_information: unm_types::RetrievedSongInfo) -> Self {
    Self {
      source: song_information.source.to_string(),
      url: song_information.url,
    }
  }
}

impl From<RetrievedSongInfo> for unm_types::RetrievedSongInfo {
  fn from(song_information: RetrievedSongInfo) -> Self {
    Self::builder()
      .source(song_information.source.into())
      .url(song_information.url)
      .build()
  }
}

impl From<Context> for unm_types::Context {
  fn from(context: Context) -> Self {
    let config = context
      .config
      .map(|c| c.into_iter().map(|(k, v)| (k.into(), v)).collect());

    ContextBuilder::default()
      .proxy_uri(context.proxy_uri.map(Into::into))
      .enable_flac(context.enable_flac.unwrap_or(false))
      .search_mode(
        context
          .search_mode
          .map(Into::into)
          .unwrap_or(unm_types::SearchMode::FastFirst),
      )
      .config(config.map(ConfigManager::new))
      .build()
      .unwrap()
  }
}
