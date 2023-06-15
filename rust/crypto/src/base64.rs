pub use base64::prelude::*;

use crate::error::CryptoResult;

pub fn encode(src: &[u8]) -> String {
    BASE64_STANDARD.encode(src)
}

pub fn decode(src: &str) -> CryptoResult<Vec<u8>> {
    Ok(BASE64_STANDARD.decode(src)?)
}

pub fn encode_crypto_base64(src: &[u8]) -> String {
    BASE64_URL_SAFE.encode(src)
}

pub fn decode_crypto_base64(src: &str) -> CryptoResult<Vec<u8>> {
    Ok(BASE64_URL_SAFE.decode(src)?)
}
