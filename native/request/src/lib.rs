pub mod ext;

// FIXME: separate to a crate.
pub mod json;

use std::collections::HashMap;
use std::time::Duration;

use cached::proc_macro::cached;
use http::header::{HeaderMap, HeaderValue};
use reqwest::{Client, ClientBuilder, Proxy};
use thiserror::Error;
use url::Url;

/// Build the base of [`ClientBuilder`] for UNM to reuse.
fn build_client_builder() -> ClientBuilder {
    Client::builder()
        .timeout(Duration::from_secs(10))
        .default_headers({
            let mut header_map = HeaderMap::with_capacity(4);

            header_map.insert(
                http::header::ACCEPT,
                HeaderValue::from_static("application/json, text/plain, */*"),
            );
            header_map.insert(
                http::header::ACCEPT_ENCODING,
                HeaderValue::from_static("gzip, deflate"),
            );
            header_map.insert(
                http::header::ACCEPT_LANGUAGE,
                HeaderValue::from_static("zh-CN,zh;q=0.9"),
            );
            header_map.insert(http::header::USER_AGENT, HeaderValue::from_static("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36"));

            header_map
        })
}

/// Build a client with the specified proxy.
#[cached(
    size = "10", // allow 10 entries
    time = "600", // store for 10 minutes
    time_refresh = true,
    result = true,

    // Allow using reference as parameter
    key = "String",
    convert = r#"{ proxy.unwrap_or("").to_string() }"#,
)]
pub fn build_client(proxy: Option<&str>) -> RequestModuleResult<Client> {
    let mut builder = build_client_builder();

    // Set the proxy if the user specified it.
    if let Some(proxy) = proxy {
        if !proxy.is_empty() {
            builder =
                builder.proxy(Proxy::all(proxy).map_err(RequestModuleError::ProxyConstructFailed)?);
        }
    }

    builder
        .build()
        .map_err(RequestModuleError::ConstructClientFailed)
}

/// Translate the specified host to the user-specified one.
///
/// `map` must be comprised of the `(src, tgt)` pair.
#[inline]
pub fn translate_host<'a>(map: &'a HashMap<&str, &str>, host: &'a str) -> &'a str {
    map.get(&host).unwrap_or(&host)
}

/// The [`translate_host`] wrapper for [`Url`].
pub fn translate_url(map: &HashMap<&str, &str>, url: &mut Url) -> RequestModuleResult<()> {
    let host = url.host_str();

    if let Some(host) = host {
        let new_host = translate_host(map, host).to_string();
        url.set_host(Some(&new_host))
            .map_err(RequestModuleError::InvalidHost)?;
    }

    Ok(())
}

/// Error in this module.
#[derive(Error, Debug)]
pub enum RequestModuleError {
    #[error("invalid header value: {0}")]
    InvalidHeaderValue(#[from] http::header::InvalidHeaderValue),

    #[error("invalid host: {0}")]
    InvalidHost(url::ParseError),

    #[error("failed to construct client: {0}")]
    ConstructClientFailed(reqwest::Error),

    #[error("failed to construct proxy: {0}")]
    ProxyConstructFailed(reqwest::Error),
}

/// The [`Result`] of this module.
pub type RequestModuleResult<T> = Result<T, RequestModuleError>;

#[cfg(test)]
mod tests {
    use std::collections::HashMap;

    use once_cell::sync::Lazy;

    static TRANSLATE_MAP: Lazy<HashMap<&str, &str>> = Lazy::new(|| {
        let mut map = HashMap::with_capacity(2);
        map.insert("www.cloudflare.com", "1.1.1.1");
        map.insert("www.google.com", "www.bing.com");

        map
    });

    mod translate_host {
        use super::super::translate_host;

        #[test]
        fn test_translate_host() {
            assert_eq!(
                translate_host(&super::TRANSLATE_MAP, "www.cloudflare.com"),
                "1.1.1.1"
            );
            assert_eq!(
                translate_host(&super::TRANSLATE_MAP, "www.google.com"),
                "www.bing.com"
            );
        }
    }

    mod translate_url {
        use url::Url;

        use super::super::translate_url;

        #[test]
        fn test_translate_url() {
            let mut testdata_1 = "https://www.cloudflare.com/owo".parse::<Url>().unwrap();
            let mut testdata_2 = "https://www.google.com/?search=Rickroll"
                .parse::<Url>()
                .unwrap();

            translate_url(&super::TRANSLATE_MAP, &mut testdata_1).unwrap();
            translate_url(&super::TRANSLATE_MAP, &mut testdata_2).unwrap();

            assert_eq!(testdata_1.to_string(), "https://1.1.1.1/owo");
            assert_eq!(
                testdata_2.to_string(),
                "https://www.bing.com/?search=Rickroll"
            );
        }
    }
}
