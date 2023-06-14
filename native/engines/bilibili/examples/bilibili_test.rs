#[tokio::main]
async fn main() {
    unm_test_utils::engine_example_wrapper(unm_engine_bilibili::BilibiliEngine).await;
}
