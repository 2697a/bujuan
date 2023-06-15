use std::borrow::Cow;

use openssl::error::ErrorStack;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum CryptoError {
    #[error("Failed in OpenSSL: {0}")]
    OpenSSLFail(#[from] ErrorStack),
    #[error("Failed to XOR this ID char (u32) {0} with this key char (u32) {1}")]
    UriEncryptXorFail(u32, u32),
    #[error("Error in serde_json: {0}")]
    SerdeError(#[from] serde_json::error::Error),
    #[error("Failed to parse URI: {0}")]
    UriParseError(#[from] url::ParseError),
    #[error("Failed to decode from base64: {0}")]
    Base64DecodeError(#[from] base64::DecodeError),
    #[error("Failed to read the specified char in the index ({0}) of string ({1})")]
    UnexpectedIndex(usize, Cow<'static, str>),
}

pub type CryptoResult<T> = Result<T, CryptoError>;
