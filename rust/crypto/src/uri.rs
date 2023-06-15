use concat_string::concat_string;

use crate::base64::encode_crypto_base64;
use crate::error::{CryptoError, CryptoResult};

const URI_KEY: &[u8] = b"3go8&$8*3*3h0k(2)2";

fn id_xor_key(id: &str, key: &[u8]) -> CryptoResult<String> {
    let mut xor_id = String::from("");
    let id_c = id.chars();
    let key_n = key.len();

    for (pos, c) in id_c.enumerate() {
        let c_id = c as u32;
        let c_key = key[pos % key_n] as u32;

        xor_id.push(
            std::char::from_u32(c_id ^ c_key).ok_or(CryptoError::UriEncryptXorFail(c_id, c_key))?,
        );
    }

    Ok(xor_id)
}

pub fn retrieve(id: &str) -> CryptoResult<String> {
    let id = id.trim();
    let result = id_xor_key(id, URI_KEY)?;
    let result = md5::compute(result).0;
    let result = encode_crypto_base64(&result);

    Ok(concat_string!("http://p1.music.126.net/", result, "/", id))
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn id_xor_key_test() {
        assert_eq!(id_xor_key("123", URI_KEY).unwrap(), "\x02U\\");
        assert_eq!(id_xor_key("245521", URI_KEY).unwrap(), "\x01SZ\r\x14\x15");
        assert_eq!(id_xor_key("2455211111124132323232321324232121324242w41ednojvelrnfedmoklr3edwks", URI_KEY).unwrap(), "\x01SZ\r\x14\x15\t\x1B\x02\x1B\x02Z\x04Z\x1B\x00\x1A\x00\x00U\\\n\x15\x16\t\x19\x01\x1E\x01[\x02Z\x1A\x03\x1A\x00\x07U[\nQ\x10\tOWD\\\x02F\x0ED@GTV\x03\x02WMHJ\x19VND\x03C");
    }

    #[test]
    fn retrieve_test() {
        assert_eq!(
            retrieve("123").unwrap(),
            "http://p1.music.126.net/fiDUXbkl-S6up_TY-bXlAg==/123"
        );
        assert_eq!(
            retrieve("245521").unwrap(),
            "http://p1.music.126.net/hLB1MmNj4GvJsQlHT6_9zw==/245521"
        );
        assert_eq!(
            retrieve("2455211111124132323232321324232121324242w41ednojvelrnfedmoklr3edwks").unwrap(),
            "http://p1.music.126.net/tnnX_W4izRAIh4UMPqlbCQ==/2455211111124132323232321324232121324242w41ednojvelrnfedmoklr3edwks"
        );
    }
}
