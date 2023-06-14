//! The JSON utilities for the response UNM ecosystem received.

pub use serde_json::Value as Json;

/// Extract the JSON string from a JSONP response.
pub fn extract_jsonp(data: &str) -> String {
    // jsonp({"data": {"id": "1", "name": "test"}});
    //       ~ START HERE                        ~ END HERE

    let left_bracket_index = data.find('(').map(|idx| idx + 1);
    let right_bracket_index = data.rfind(')');

    data.chars()
        .skip(left_bracket_index.unwrap_or(0))
        .take(right_bracket_index.unwrap_or(data.len()) - left_bracket_index.unwrap_or(0))
        .collect()
}

/// Throws when the JSON is not able to extract.
#[derive(Debug)]
pub struct UnableToExtractJson<'a> {
    pub json_pointer: &'a str,
    pub expected_type: &'a str,
}

impl<'a> std::error::Error for UnableToExtractJson<'a> {}
impl<'a> std::fmt::Display for UnableToExtractJson<'a> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "unable to extract json: {} (type: {})",
            self.json_pointer, self.expected_type
        )
    }
}

#[cfg(test)]
mod extract_jsonp_test {
    use once_cell::sync::Lazy;

    use super::extract_jsonp;

    struct Testdata {
        pub src: &'static str,
        pub testdata: Vec<String>,
    }

    static TEST_DATA_SETS: Lazy<Vec<Testdata>> = Lazy::new(|| {
        vec![
            "[100,500,300,200,400]",
            r##"[{"color":"red","value":"#f00"},{"color":"green","value":"#0f0"},{"color":"blue","value":"#00f"},{"color":"cyan","value":"#0ff"},{"color":"magenta","value":"#f0f"},{"color":"yellow","value":"#ff0"},{"color":"black","value":"#000"}]"##,
            r##"{
                "color":"red",
                "value":"#f00"
            }"##]
            .into_iter()
            .map(|json| Testdata {
                src: json,
                testdata: vec![
                    format!("qq({json})"),
                    format!("qq({json});"),
                    format!("fg_1odla({json})"),
                    format!("$fkaolv({json});;;"),
                ],
            })
            .collect::<Vec<_>>()
    });

    #[test]
    fn test_extract_jsonp() {
        for test_data_set in TEST_DATA_SETS.iter() {
            for test_data in test_data_set.testdata.iter() {
                assert_eq!(extract_jsonp(test_data.as_str()), test_data_set.src);
            }
        }
    }
}
