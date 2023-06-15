use axum::response::IntoResponse;
use http::header::CONTENT_TYPE;
use http::StatusCode;

pub async fn schema_v1_index() -> impl IntoResponse {
    (
        StatusCode::OK,
        [(CONTENT_TYPE, "application/json")],
        include_str!("./schema/v1/index.json"),
    )
}

pub async fn schema_v1_search() -> impl IntoResponse {
    (
        StatusCode::OK,
        [(CONTENT_TYPE, "application/json")],
        include_str!("./schema/v1/search.json"),
    )
}

pub async fn schema_v1_error() -> impl IntoResponse {
    (
        StatusCode::OK,
        [(CONTENT_TYPE, "application/json")],
        include_str!("./schema/v1/error.json"),
    )
}
