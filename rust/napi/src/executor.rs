use napi::bindgen_prelude::*;
use napi_derive::napi;
use std::borrow::Cow;
use unm_engine::executor::Executor;

use crate::types::{Context, RetrievedSongInfo, Song, SongSearchInformation};

#[napi(js_name = "Executor")]
pub struct JsExecutor {
  executor: Executor,
}

#[napi]
impl JsExecutor {
  #[napi(constructor)]
  pub fn new() -> Self {
    Self::default()
  }

  #[napi]
  pub fn list(&self) -> Vec<&str> {
    self.executor.list()
  }

  #[napi]
  pub async fn search(
    &self,
    engines: Vec<String>,
    song: Song,
    ctx: Context,
  ) -> Result<SongSearchInformation> {
    let engines = engines
      .into_iter()
      .map(|engine| engine.into())
      .collect::<Vec<Cow<'static, str>>>();

    self
      .executor
      .search(&engines, &song.into(), &ctx.into())
      .await
      .map(|v| v.into())
      .map_err(|e| Error::new(Status::GenericFailure, format!("Unable to search: {e:?}")))
  }

  #[napi]
  pub async fn retrieve(
    &self,
    song: SongSearchInformation,
    ctx: Context,
  ) -> Result<RetrievedSongInfo> {
    self
      .executor
      .retrieve(&song.into(), &ctx.into())
      .await
      .map(|v| v.into())
      .map_err(|e| Error::new(Status::GenericFailure, format!("Unable to retrieve: {e:?}")))
  }
}

impl Default for JsExecutor {
  fn default() -> Self {
    Self {
      executor: unm_api_utils::executor::build_full_executor(),
    }
  }
}
