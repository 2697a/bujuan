pub fn digest<T: AsRef<[u8]>>(value: T) -> String {
    faster_hex::hex_string(md5::compute(value).as_slice())
}
