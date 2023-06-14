// This is the entry point of your Rust library.
// When adding new code to your project, note that only items used
// here will be transformed to their Dart equivalents.

// A plain enum without any fields. This is similar to Dart- or C-style enums.
// flutter_rust_bridge is capable of generating code for enums with fields
// (@freezed classes in Dart and tagged unions in C).
use std::borrow::Cow;
use anyhow;
use futures::FutureExt;
use mimalloc::MiMalloc;
use unm_test_utils::{measure_async_function_time, set_logger};
use unm_types::{Artist, ContextBuilder, SearchMode, Song};


#[global_allocator]
static GLOBAL: MiMalloc = MiMalloc;

pub enum Platform {
    Unknown,
    Android,
    Ios,
    Windows,
    Unix,
    MacIntel,
    MacApple,
    Wasm,
}

// A function definition in Rust. Similar to Dart, the return type must always be named
// and is never inferred.
pub fn platform() -> Platform {
    // This is a macro, a special expression that expands into code. In Rust, all macros
    // end with an exclamation mark and can be invoked with all kinds of brackets (parentheses,
    // brackets and curly braces). However, certain conventions exist, for example the
    // vector macro is almost always invoked as vec![..].
    //
    // The cfg!() macro returns a boolean value based on the current compiler configuration.
    // When attached to expressions (#[cfg(..)] form), they show or hide the expression at compile time.
    // Here, however, they evaluate to runtime values, which may or may not be optimized out
    // by the compiler. A variety of configurations are demonstrated here which cover most of
    // the modern oeprating systems. Try running the Flutter application on different machines
    // and see if it matches your expected OS.
    //
    // Furthermore, in Rust, the last expression in a function is the return value and does
    // not have the trailing semicolon. This entire if-else chain forms a single expression.

    if cfg!(windows) {
        Platform::Windows
    } else if cfg!(target_os = "android") {
        Platform::Android
    } else if cfg!(target_os = "ios") {
        Platform::Ios
    } else if cfg!(all(target_os = "macos", target_arch = "aarch64")) {
        Platform::MacApple
    } else if cfg!(target_os = "macos") {
        Platform::MacIntel
    } else if cfg!(target_family = "wasm") {
        Platform::Wasm
    } else if cfg!(unix) {
        Platform::Unix
    } else {
        Platform::Unknown
    }
}

// The convention for Rust identifiers is the snake_case,
// and they are automatically converted to camelCase on the Dart side.
pub fn rust_release_mode() -> bool {
    cfg!(not(debug_assertions))
}

#[tokio::main(flavor = "current_thread")]
pub async fn aaa(song_name:String,artists_name:String) -> anyhow::Result<String> {
    set_logger();
    let song = Song::builder()
        .name(song_name.to_string())
        .artists(vec![Artist::builder().name(artists_name.to_string()).build()])
        .build();

    let context = ContextBuilder::default()
        .enable_flac(std::env::var("ENABLE_FLAC").unwrap_or_else(|_| "".into()) == "true")
        .search_mode(match std::env::var("SEARCH_MODE") {
            Ok(v) if v == "order_first" => SearchMode::OrderFirst,
            Ok(v) if v == "fast_first" => SearchMode::FastFirst,
            _ => SearchMode::OrderFirst,
        })
        .build()
        .unwrap();
    let executor = unm_api_utils::executor::build_full_executor();
    let engines_to_use = std::env::var("ENGINES")
        .unwrap_or_else(|_| executor.list().join(" "))
        .split_whitespace()
        .map(|v| Cow::Owned(v.to_string()))
        .collect::<Vec<Cow<'static, str>>>();

    let (search_time_taken, search_result) =
        measure_async_function_time(|| executor.search(&engines_to_use, &song, &context).boxed()).await;
    let search_result = search_result.expect("wulalallala");

    let (retrieve_time_taken, retrieved_result) =
        measure_async_function_time(|| executor.retrieve(&search_result, &context).boxed()).await;
    let retrieved_result = retrieved_result.expect("can't be retrieved");

    println!(
        "[Retrieved] 周杰伦 - 青花瓷: {} (from {})",
        retrieved_result.url, retrieved_result.source
    );
    let url = retrieved_result.url;
    println!("Search taken {search_time_taken:?} while retrieve tooke {retrieve_time_taken:?}.");
    Ok(url)
}

