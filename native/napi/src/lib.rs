pub mod executor;
pub mod types;

use mimalloc::MiMalloc;
use napi::bindgen_prelude::*;
use napi_derive::napi;

#[global_allocator]
static GLOBAL: MiMalloc = MiMalloc;

/// The available logging output.
#[non_exhaustive]
#[napi]
pub enum LoggingType {
  /// Output to the console.
  ///
  /// Output all messages including 'trace' by default.
  /// You can change this by setting the `RUST_LOG` environment variable.
  ///
  /// Available values are `error`, `warn`, `info`, `debug`, and `trace`.
  /// For more information, see <https://docs.rs/log/latest/log/enum.LevelFilter.html#variants>
  ConsoleEnv,
}

/// Enable to log to the specified output.
///
/// @see {@link LoggingType}
#[napi]
pub fn enable_logging(log_type: LoggingType) -> Result<()> {
  match log_type {
    LoggingType::ConsoleEnv => simple_logger::init_with_env().map_err(|e| {
      napi::Error::new(
        Status::GenericFailure,
        format!("Unable to initialize logger: {e}"),
      )
    }),
  }
}
