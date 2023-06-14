use std::borrow::Cow;

use serde::{Deserialize, Serialize};
use tracing::instrument;
use tracing::log::trace;

use super::get_unm_executor;

/// The string with the engines to use.
///
/// If the inner value is `None`, we use all the supported engines.
///
/// # Example
///
/// ```
/// use unm_rest_api::executor::engine::ApiEngineList;
///
/// // Specify engines explicitly
/// ApiEngineList(Some(vec![
///     "bilibili",
///     "kugou",
///     "kuwo"
/// ]))
///
/// // Use the default engines set
/// ApiEngineList(None)
/// ```
#[derive(Default, Debug, Deserialize, Serialize)]
pub struct ApiEnginesList(Option<Vec<String>>);

impl ApiEnginesList {
    #[instrument]
    pub fn get_engines_list(&self) -> Vec<Cow<'static, str>> {
        trace!("Getting the engines list to request…");

        if let Some(ref engines) = self.0 {
            engines
                .iter()
                .map(|s| s.clone().into())
                .collect::<Vec<Cow<'_, str>>>()
        } else {
            get_unm_executor()
                .list()
                .into_iter()
                .map(Into::into)
                .collect::<Vec<Cow<'_, str>>>()
        }
    }
}
