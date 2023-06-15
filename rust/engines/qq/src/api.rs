//! The basic (search & get url) API of QQ Music.

pub mod format;
pub mod identifier;
pub mod typing;

use std::borrow::Cow;

use http::header::{COOKIE, ORIGIN, REFERER};
use http::{HeaderMap, HeaderValue};
use log::{debug, trace};
use once_cell::sync::Lazy;
use regex::Regex;
use reqwest::Url;
use serde::Deserialize;
use serde_json::json;
use thiserror::Error;
use unm_request::json::{Json, UnableToExtractJson};
use unm_request::{build_client, RequestModuleError};
use unm_types::Context;

use self::format::QQFormat;
use self::identifier::QQResourceIdentifier;
use self::typing::QQSongData;
use crate::api::typing::QQSingleResponseRoot;

/// Search for the specified keyword.
pub async fn search_by_keyword(keyword: &str, ctx: &Context) -> QQApiModuleResult<QQSongData> {
    debug!("Searching “{keyword}” in QQ Music…");

    let url = construct_search_url(keyword)?;
    let cookie = extract_cookie(ctx);

    let client = build_client(ctx.proxy_uri.as_deref())?;
    let mut request = client
        .get(url)
        .header(ORIGIN, HeaderValue::from_static("http://y.qq.com"))
        .header(REFERER, HeaderValue::from_static("http://y.qq.com"));

    if let Some(cookie) = cookie {
        request = request.header(COOKIE, HeaderValue::from_str(cookie)?);
    }

    let response = request
        .send()
        .await
        .map_err(QQApiModuleError::RequestFailed)?;
    let json = response
        .json::<Json>()
        .await
        .map_err(QQApiModuleError::ResponseJsonDeserializeFailed)?;

    let data = QQSongData::deserialize(json.pointer("/search/data/body/song").ok_or(
        UnableToExtractJson {
            json_pointer: "/search/data/body/song",
            expected_type: "QQSongData",
        },
    )?)
    .map_err(QQApiModuleError::JsonDeserializeFailed)?;

    Ok(data)
}

/// Retrieve the song URL of specified single.
pub async fn retrieve_single(
    identifier: &str,
    ctx: &Context,
) -> QQApiModuleResult<QQSingleResponseRoot> {
    debug!("Retrieving the song URL of “{identifier}” from QQ Music…");
    let identifier = QQResourceIdentifier::deserialize(identifier)?;
    let mode = QQFormat::from_context(ctx);
    let cookie = extract_cookie(ctx);

    let client = build_client(ctx.proxy_uri.as_deref())?;
    let url = construct_single_url(&identifier, mode, ctx)?;

    let response = client
        .get(url)
        .headers(construct_header(cookie)?)
        .send()
        .await
        .map_err(QQApiModuleError::RequestFailed)?;
    let json = response
        .json::<Json>()
        .await
        .map_err(QQApiModuleError::ResponseJsonDeserializeFailed)?;

    let data = json
        .pointer("/req_0")
        .and_then(|data| QQSingleResponseRoot::deserialize(data).ok())
        .ok_or(UnableToExtractJson {
            json_pointer: "/req_0",
            expected_type: "QQSingleResponseRoot",
        })?;

    Ok(data)
}

/// Extract the cookie `qq:cookie` from the config ([`unm_types::ConfigManager`]).
fn extract_cookie(ctx: &Context) -> Option<&str> {
    trace!("Extracting cookie from ConfigManager…");

    if let Some(ref config) = ctx.config {
        config.get_deref(Cow::Borrowed("qq:cookie"))
    } else {
        None
    }
}

fn construct_header(cookie: Option<&str>) -> QQApiModuleResult<HeaderMap> {
    trace!("Constructing header with cookie…");

    let mut hm = HeaderMap::with_capacity(3);

    hm.insert(ORIGIN, HeaderValue::from_static("http://y.qq.com"));
    hm.insert(REFERER, HeaderValue::from_static("http://y.qq.com"));

    if let Some(cookie) = cookie {
        if !cookie.is_empty() {
            hm.insert(COOKIE, HeaderValue::from_str(cookie)?);
        }
    }

    Ok(hm)
}

fn construct_search_url(keyword: &str) -> QQApiModuleResult<Url> {
    trace!("Constructing search URL with parameters…");

    let data = json!({
        "search": {
            "method": "DoSearchForQQMusicDesktop",
            "module": "music.search.SearchCgiService",
            "param": {
                "num_per_page": 5,
                "page_num": 1,
                "query": keyword,
                "search_type": 0
            }
        }
    });

    Ok(Url::parse_with_params(
        "https://u.y.qq.com/cgi-bin/musicu.fcg",
        &[("data", data.to_string())],
    )?)
}

fn construct_single_url(
    ident: &QQResourceIdentifier,
    format: QQFormat,
    ctx: &Context,
) -> QQApiModuleResult<Url> {
    trace!("Constructing single URL with parameters…");

    /// The regex that can extract the value of 'uin' from cookie.
    static REGEX_EXTRACT_COOKIE_UIN: Lazy<Regex> = Lazy::new(|| Regex::new(r"uin=(\d+)").unwrap());

    let cookie = extract_cookie(ctx).unwrap_or("");
    let uin_value = REGEX_EXTRACT_COOKIE_UIN
        .captures(cookie)
        .and_then(|v| v.get(1).map(|v| v.as_str()))
        .unwrap_or("0");

    let param = json!({
        "guid": fastrand::i32(1..10000000),
        "loginflag": 1u8,
        "filename": [
            format.to_filename(ident.file),
        ],
        "songmid": [
            &ident.mid,
        ],
        "songtype": [0u8],
        "uin": uin_value,
        "platform": "20",
    });
    let parameter = json!({
        "req_0": {
            "module": "vkey.GetVkeyServer",
            "method": "CgiGetVkey",
            "param": param,
        },
    });

    Ok(Url::parse_with_params(
        "https://u.y.qq.com/cgi-bin/musicu.fcg",
        [(
            "data",
            serde_json::to_string(&parameter).map_err(QQApiModuleError::JsonSerializeFailed)?,
        )],
    )?)
}

#[derive(Debug, Error)]
pub enum QQApiModuleError {
    #[error("failed to send request: {0}")]
    RequestFailed(reqwest::Error),

    #[error("failed to deserialize the response JSON: {0}")]
    ResponseJsonDeserializeFailed(reqwest::Error),

    #[error("invalid header value: {0}")]
    InvalidHeaderValue(#[from] http::header::InvalidHeaderValue),

    #[error("failed to construct URL: {0}")]
    ConstructUrlFailed(#[from] url::ParseError),

    #[error("failed to serialize as JSON string: {0}")]
    JsonSerializeFailed(serde_json::Error),

    #[error("failed to deserialize to a structured data: {0}")]
    JsonDeserializeFailed(serde_json::Error),

    #[error("something wrong in request module: {0}")]
    RequestModuleError(#[from] RequestModuleError),

    #[error("failed to deserialize QQResourceIdentifier: {0}")]
    QQResourceIdentifierDeserializationFailed(#[from] identifier::DeserializationFailed),

    #[error("unable to extract such a JSON pointer: {0}")]
    NoSuchField(#[from] UnableToExtractJson<'static>),
}

pub type QQApiModuleResult<T> = Result<T, QQApiModuleError>;
