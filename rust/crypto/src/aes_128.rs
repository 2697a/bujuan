//! The AES-128 utilities, including the encryption and decryption methods
//! of AES-128-ECB and AES-128-CBC.

use openssl::symm::{decrypt as symm_decrypt, encrypt as symm_encrypt, Cipher};

use crate::error::CryptoResult;

pub type AesResult = CryptoResult<Vec<u8>>;

/// Decrypt data with AES-128-ECB using the given key.
pub fn decrypt_ecb(data: &[u8], key: &[u8]) -> AesResult {
    let cipher = Cipher::aes_128_ecb();
    Ok(symm_decrypt(cipher, key, None, data)?)
}

/// Encrypt data with AES-128-ECB using the given key.
pub fn encrypt_ecb(data: &[u8], key: &[u8]) -> AesResult {
    let cipher = Cipher::aes_128_ecb();
    Ok(symm_encrypt(cipher, key, None, data)?)
}

/// Decrypt data with AES-128-CBC using the given key and iv.
pub fn decrypt_cbc(data: &[u8], key: &[u8], iv: &[u8]) -> AesResult {
    let cipher = Cipher::aes_128_cbc();
    Ok(symm_decrypt(cipher, key, Some(iv), data)?)
}

/// Encrypt data with AES-128-CBC using the given key and iv.
pub fn encrypt_cbc(data: &[u8], key: &[u8], iv: &[u8]) -> AesResult {
    let cipher = Cipher::aes_128_cbc();
    Ok(symm_encrypt(cipher, key, Some(iv), data)?)
}
