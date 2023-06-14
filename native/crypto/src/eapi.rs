use concat_string::concat_string;
use regex::Regex;
use serde::Serialize;

use crate::aes_128;
use crate::aes_128::AesResult;
use crate::error::CryptoResult;

const EAPI_KEY: &[u8; 16] = b"e82ckenh8dichen8";

pub fn decrypt(data: &[u8]) -> AesResult {
    aes_128::decrypt_ecb(data, EAPI_KEY)
}

pub fn encrypt(data: &[u8]) -> AesResult {
    aes_128::encrypt_ecb(data, EAPI_KEY)
}

pub struct EncryptRequestResponse {
    pub url: String,
    pub body: String,
}

pub fn encrypt_request<T: Serialize>(
    url: &str,
    object: &T,
) -> CryptoResult<EncryptRequestResponse> {
    let serialized: String = serde_json::to_string(object)?;
    let message = concat_string!("deprecate", url, "md5", serialized, "please");
    let digest = md5::compute(message.into_bytes());
    let data = concat_string!(
        url,
        "-36cd479b6b5-",
        serialized,
        "-36cd479b6b5-",
        faster_hex::hex_string(digest.as_slice())
    );

    Ok(EncryptRequestResponse {
        url: Regex::new("\\w*api")
            .unwrap()
            .replace(url, "eapi")
            .to_string(),
        // Since there is no special chars in the uppercase hex string,
        // we don't need to use something like serde_qs to serialize it.
        body: concat_string!(
            "params=",
            faster_hex::hex_string(encrypt(data.as_bytes())?.as_slice()).to_uppercase()
        ),
    })
}
