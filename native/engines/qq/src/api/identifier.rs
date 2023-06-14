use std::error::Error;
use std::fmt::Display;

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct QQResourceIdentifier<'a> {
    pub mid: &'a str,
    pub file: &'a str,
}

impl<'a> QQResourceIdentifier<'a> {
    pub fn serialize(&self) -> String {
        log::debug!("Serializing a QQResourceIdentifier to String…");
        concat_string::concat_string!(self.mid, ":::", self.file)
    }

    pub fn deserialize(serialized: &'a str) -> DeserializationResult<Self> {
        log::debug!("Deserializing “{serialized}” to QQResourceIdentifier…");

        let mut parts = serialized.splitn(2, ":::");
        let mid = parts.next().ok_or(DeserializationFailed("song"))?;
        let file = parts.next().ok_or(DeserializationFailed("file"))?;

        Ok(Self { mid, file })
    }
}

#[derive(Debug)]
pub struct DeserializationFailed(&'static str);
pub type DeserializationResult<T> = Result<T, DeserializationFailed>;

impl Display for DeserializationFailed {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "the attempt to extract “{}” from 'serialized' parameter failed",
            self.0
        )
    }
}

impl Error for DeserializationFailed {}

#[cfg(test)]
mod tests {
    use super::QQResourceIdentifier;

    #[test]
    fn test_identifier_serialization() {
        let identifier = QQResourceIdentifier {
            mid: "mid",
            file: "file",
        };

        assert_eq!(identifier.serialize(), "mid:::file");
    }

    #[test]
    fn test_identifier_deserialization() {
        let identifier = "mid113:::file113";

        assert_eq!(
            QQResourceIdentifier::deserialize(identifier).unwrap(),
            QQResourceIdentifier {
                mid: "mid113",
                file: "file113",
            }
        );
    }

    #[test]
    fn test_identifier_failed_deserialization() {
        let identifier = "mid113::file113";

        let deserialized = QQResourceIdentifier::deserialize(identifier);
        assert!(deserialized.is_err());
    }
}
