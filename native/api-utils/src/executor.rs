//! The executor-related utils.
//!
//! It provides some methods, helping you
//! construct exectutor quickly, for example:
//! [`build_full_executor`].

use std::sync::Arc;

use unm_engine::executor::Executor;

/// Build an [`Executor`] with all the official engines registered.
///
/// Currently, it includes `bilibili`, `kugou`, `pyncm`,
/// `ytdl`, `kuwo`, and `joox`.
///
/// # Example
///
/// ```
/// use unm_api_utils::executor::build_full_executor;
///
/// let executor = build_full_executor();
/// println!("{:?}", executor.list());
/// ```
pub fn build_full_executor() -> Executor {
    log::debug!("Building the executor with all the official engines registered…");

    let mut executor = Executor::new();

    macro_rules! push_engine {
        ($engine_name:ident: $engine_struct:ident) => {
            concat_idents::concat_idents!(engine_crate = unm_engine_, $engine_name {
                executor.register(engine_crate::ENGINE_ID.into(), Arc::new(engine_crate::$engine_struct));
            })
        };
    }

    push_engine!(bilibili: BilibiliEngine);
    push_engine!(kugou: KugouEngine);
    push_engine!(pyncm: PyNCMEngine);
    push_engine!(ytdl: YtDlEngine);
    push_engine!(kuwo: KuwoEngine);
    push_engine!(joox: JooxEngine);
    push_engine!(qq: QQEngine);

    executor
}
