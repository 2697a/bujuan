use std::borrow::Cow;

use futures::FutureExt;
use mimalloc::MiMalloc;
use unm_test_utils::{measure_async_function_time, set_logger};
use unm_types::{Artist, ContextBuilder, SearchMode, Song};

#[global_allocator]
static GLOBAL: MiMalloc = MiMalloc;

#[tokio::main]
async fn main() {
    set_logger();
    // the trait bound `DartCObject: From<impl futures::Future<Output = String>>` is not satisfied
    let song = Song::builder()
        .name("青花瓷".to_string())
        .artists(vec![Artist::builder().name("周杰伦".to_string()).build()])
        .build();

    let context = ContextBuilder::default()
        .enable_flac(std::env::var("ENABLE_FLAC").unwrap_or_else(|_| "".into()) == "true")
        .search_mode(match std::env::var("SEARCH_MODE") {
            // Ok(v) if v == "fast_first" => SearchMode::FastFirst,
            Ok(v) if v == "order_first" => SearchMode::OrderFirst,
            _ => SearchMode::FastFirst,
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
        measure_async_function_time(|| executor.search(&engines_to_use, &song, &context).boxed())
            .await;
    let search_result = search_result.expect("should has a search result");

    let (retrieve_time_taken, retrieved_result) =
        measure_async_function_time(|| executor.retrieve(&search_result, &context).boxed()).await;
    let retrieved_result = retrieved_result.expect("can't be retrieved");

    println!(
        "[Retrieved] 周杰伦 - 青花瓷: {} (from {})",
        retrieved_result.url, retrieved_result.source
    );
    println!("Search taken {search_time_taken:?} while retrieve tooke {retrieve_time_taken:?}.");
}
