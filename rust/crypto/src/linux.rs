use concat_string::concat_string;
use serde::Serialize;
use url::Url;

use crate::aes_128;
use crate::error::CryptoResult;

const LINUX_API_KEY: &[u8; 16] = b"rFgB&h#%2?^eDg:Q";

#[derive(Serialize)]
struct LinuxApiResponse<'a, T: Serialize> {
    method: &'static str,
    // Nothing than ourselves use this field. We can safely
    // use reference so we can reduce the memory usage.
    url: &'a str,
    params: T,
}

pub fn decrypt(data: &[u8]) -> CryptoResult<Vec<u8>> {
    aes_128::decrypt_ecb(data, LINUX_API_KEY)
}

pub fn encrypt(data: &[u8]) -> CryptoResult<Vec<u8>> {
    aes_128::encrypt_ecb(data, LINUX_API_KEY)
}

pub struct EncryptRequestResponse {
    pub url: String,
    pub body: String,
}

pub fn encrypt_request<T: Serialize>(
    url: &str,
    object: &T,
) -> CryptoResult<EncryptRequestResponse> {
    let response_url = Url::parse(url).and_then(|url| url.join("/api/linux/forward"))?;
    let response = LinuxApiResponse {
        method: "POST",
        url,
        params: object,
    };
    let serialized = serde_json::to_string(&response)?;

    Ok(EncryptRequestResponse {
        url: response_url.to_string(),
        body: concat_string!(
            "eparams=",
            faster_hex::hex_string(encrypt(serialized.as_bytes())?.as_slice()).to_uppercase()
        ),
    })
}
