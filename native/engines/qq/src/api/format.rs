use concat_string::concat_string;
use unm_types::Context;

use super::extract_cookie;

#[derive(Clone, Copy)]
pub enum QQFormat {
    /// `M500`: MP3, for guest (without cookie).
    GuestMp3,
    /// `M800`: MP3, for members (with cookie).
    MemberMp3,
    /// `F000`: FLAC, for members (with cookie).
    MemberFlac,
}

impl QQFormat {
    /// Get the format ID according to the format.
    pub fn as_format_id(&self) -> &'static str {
        match self {
            QQFormat::GuestMp3 => "M500",
            QQFormat::MemberMp3 => "M800",
            QQFormat::MemberFlac => "F000",
        }
    }

    /// Get the file extension according to the format.
    fn as_extension(&self) -> &'static str {
        match self {
            QQFormat::GuestMp3 | QQFormat::MemberMp3 => ".mp3",
            QQFormat::MemberFlac => ".flac",
        }
    }

    /// Get the filename to fetch.
    pub fn to_filename(&self, filename: &str) -> String {
        concat_string!(self.as_format_id(), filename, self.as_extension())
    }

    /// Determine the mode according to the context
    pub fn from_context(ctx: &Context) -> QQFormat {
        let cookie = extract_cookie(ctx);

        if cookie.is_some() {
            if ctx.enable_flac {
                QQFormat::MemberFlac
            } else {
                QQFormat::MemberMp3
            }
        } else {
            QQFormat::GuestMp3
        }
    }
}

#[cfg(test)]
mod tests {
    use concat_string::concat_string;

    use crate::api::format::QQFormat;

    const FILE: &str = "Aod01NqoG";

    #[test]
    fn test_format_guest_mp3() {
        assert_eq!(
            QQFormat::GuestMp3.to_filename(FILE),
            concat_string!("M500", FILE, ".mp3")
        );
    }

    #[test]
    fn test_format_member_mp3() {
        assert_eq!(
            QQFormat::MemberMp3.to_filename(FILE),
            concat_string!("M800", FILE, ".mp3")
        );
    }

    #[test]
    fn test_format_member_flac() {
        assert_eq!(
            QQFormat::MemberFlac.to_filename(FILE),
            concat_string!("F000", FILE, ".flac")
        );
    }
}
