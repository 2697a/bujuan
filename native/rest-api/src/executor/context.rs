use serde::Deserialize;
use tracing::debug;
use unm_types::{Context, SearchMode};

#[derive(Default, Deserialize)]
pub struct ApiContext {
    /// Should we search FLAC audio file?
    pub enable_flac: Option<bool>,

    /// What mode to search?
    ///
    /// It can be `fast_first` or `order_first`.
    /// By default, it is `fast_first`.
    pub search_mode: Option<SearchMode>,
}

impl ApiContext {
    /// Construct an user-customized context based on the `default_context`.
    ///
    /// You would need to clone your default context to here.
    pub fn construct_context(&self, mut default_context: Context) -> Context {
        debug!("Constructing the ApiContext…");

        macro_rules! move_value {
            ($key:ident) => {
                if let Some(v) = self.$key {
                    default_context.$key = v;
                }
            };
        }

        move_value!(enable_flac);
        move_value!(search_mode);

        default_context
    }
}
