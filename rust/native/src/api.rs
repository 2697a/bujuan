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
use unm_test_utils::{measure_async_function_time};
use unm_types::{Artist, ContextBuilder, SearchMode, Song};


#[global_allocator]
static GLOBAL: MiMalloc = MiMalloc;


#[tokio::main(flavor = "current_thread")]
pub async fn get_unblock_netease_music_url(song_name: String, artists_name: String) -> anyhow::Result<String> {
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
    let search_result = search_result.expect("should has a search result");

    let (retrieve_time_taken, retrieved_result) =
        measure_async_function_time(|| executor.retrieve(&search_result, &context).boxed()).await;
    let retrieved_result = retrieved_result.expect("can't be retrieved");

    println!(
        "[Retrieved]: {} (from {})",
        retrieved_result.url, retrieved_result.source
    );
    let url = retrieved_result.url;
    println!("Search taken {search_time_taken:?} while retrieve tooke {retrieve_time_taken:?}.");
    Ok(url)
}

