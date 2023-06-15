//! The utilities for working on WEAPI requests.
//!
//! It is originally from <https://github.com/Binaryify/NeteaseCloudMusicApi/blob/master/util/crypto.js>.
//! Thanks to Binaryify!

use once_cell::sync::OnceCell;
use openssl::pkey::Public;
use openssl::rand::rand_bytes;
use openssl::rsa::{Padding, Rsa};
use serde::Serialize;
use serde_json::Value;
use smallvec::SmallVec;

use crate::base64::encode;
use crate::error::{CryptoError, CryptoResult};

const BASE62_CHARSET: &str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
const WEAPI_PRESET_KEY: &[u8] = b"0CoJUm6Qyw8W8jud";
const WEAPI_IV: &[u8] = b"0102030405060708";
const WEAPI_PUBKEY: &[u8] = b"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgtQn2JZ34ZC28NWYpAUd98iZ37BUrX/aKzmFbt7clFSs6sXqHauqKWqdtLkF2KexO40H1YTX8z2lSgBBOAxLsvaklV8k4cBFK9snQXE9/DDaFt6Rr7iVZMldczhC0JNgTz+SHXT6CBHuX3e9SdB1Ua44oncaTWz7OBGLbCiK45wIDAQAB\n-----END PUBLIC KEY-----";

static WEAPI_RSA_INSTANCE: OnceCell<Rsa<Public>> = OnceCell::new();

/// Generate random bytes with [`rand_bytes`], and store them in a [`SmallVec`].
///
/// # Example
///
/// ```
/// use unm_crypto::weapi::gen_random_bytes;
///
/// let random_bytes = gen_random_bytes::<16>();
/// assert_eq!(random_bytes.unwrap().len(), 16);
///
/// let random_bytes = gen_random_bytes::<32>();
/// assert_eq!(random_bytes.unwrap().len(), 32);
/// ```
pub fn gen_random_bytes<const LEN: usize>() -> CryptoResult<[u8; LEN]> {
    let mut bytes = [0; LEN];

    rand_bytes(bytes.as_mut_slice())?;

    Ok(bytes)
}

/// Generate the WEAPI secret key.
///
/// # Example
///
/// ```
/// use unm_crypto::weapi::gen_weapi_secret_key;
///
/// let secret_key = gen_weapi_secret_key().unwrap();
/// assert_eq!(secret_key.len(), 16);
/// ```
pub fn gen_weapi_secret_key() -> CryptoResult<[u8; 16]> {
    let bytes = gen_random_bytes::<16>()?;
    let b62_char_at = |n| {
        BASE62_CHARSET.chars().nth(n % 62).unwrap_or({
            log::error!(
                "{}. Fill 'a' instead.",
                CryptoError::UnexpectedIndex(n, BASE62_CHARSET.into())
            );
            'a'
        })
    };

    let result = bytes
        .into_iter()
        .enumerate()
        .fold([0; 16], |mut acc, (i, n)| {
            acc[i] = u8::try_from(b62_char_at(n as usize)).unwrap_or_else(|e| {
                log::error!("[char2u8] Out of range: {e}. Return 0 instead.");
                0
            });
            acc
        });

    Ok(result)
}

fn get_weapi_rsa_instance() -> CryptoResult<&'static Rsa<Public>> {
    Ok(WEAPI_RSA_INSTANCE.get_or_try_init(|| Rsa::public_key_from_pem(WEAPI_PUBKEY))?)
}

/// Encrypts data using WEAPI's key, returning the number of encrypted bytes.
pub fn encrypt_with_weapi_rsa(data: &[u8], to: &mut [u8; 128]) -> CryptoResult<usize> {
    let mut padded_data = SmallVec::<[u8; 128]>::new_const();

    padded_data.resize(128 - data.len(), 0);
    padded_data.extend_from_slice(data);

    Ok(get_weapi_rsa_instance()?.public_encrypt(padded_data.as_slice(), to, Padding::NONE)?)
}

pub fn construct_weapi_payload<S: Serialize>(object: &S) -> CryptoResult<Value> {
    let json_payload = serde_json::to_string(object)?;
    let mut secret_key = gen_weapi_secret_key()?;
    let mut buf = [0; 128];

    let aes_128_b64 = |data, key| -> CryptoResult<String> {
        Ok(encode(&crate::aes_128::encrypt_cbc(data, key, WEAPI_IV)?))
    };

    // Reverse the secret key since it is the requirement of `enc_sec_key` (?)
    secret_key.reverse();

    /* Params */
    let params_inside = aes_128_b64(json_payload.as_bytes(), WEAPI_PRESET_KEY)?;
    let params = aes_128_b64(params_inside.as_bytes(), &secret_key)?;

    /* encSecKey */
    encrypt_with_weapi_rsa(secret_key.as_slice(), &mut buf)?;
    let enc_sec_key = faster_hex::hex_string(buf.as_slice());

    Ok(serde_json::json!({
        "params": params,
        "encSecKey": enc_sec_key,
    }))
}

#[cfg(test)]
mod tests {
    use super::encrypt_with_weapi_rsa;
    use crate::base64::encode;

    #[test]
    fn encrypt_with_weapi_rsa_test() {
        // > c.rsaEncrypt(
        //    Buffer.from("a1b2c3d4"),
        //    '-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgtQn2JZ34ZC28NWYpAUd98iZ37BUrX/aKzmFbt7clFSs6sXqHauqKWqdtLkF2KexO40H1YTX8z2lSgBBOAxLsvaklV8k4cBFK9snQXE9/DDaFt6Rr7iVZMldczhC0JNgTz+SHXT6CBHuX3e9SdB1Ua44oncaTWz7OBGLbCiK45wIDAQAB\n-----END PUBLIC KEY-----'
        //   ).toString("base64")
        let mut buf = [0; 128];

        let encrypted_bytes = encrypt_with_weapi_rsa(b"a1b2c3d4", &mut buf).unwrap();
        assert_eq!(encrypted_bytes, 128);

        let encrypted_base64 = encode(&buf);
        assert_eq!(
            encrypted_base64,
            r#"nknIprgQgDE2Ana3dka2qYhwE4ch/My68kTk0pGZmtkeWCTslpn9Co32as7sd5fyitf5lyXwMff/g/kDzaz6IVA/tMAtbbzkgWPDMivRy5b8z1Ypd7UV7r6aM6OgNT1bFjPo4jEAkmUl6UxCBAsrsMaaYqmW6rZl0BdJdb0/Tq0="#
        );
    }
}
