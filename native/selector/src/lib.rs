use unm_types::Song;

/// The "similar song selector" to pass to `.find()`.
///
/// # Example
///
/// ```
/// use unm_selector::SimilarSongSelector;
/// use unm_types::Song;
///
/// let SimilarSongSelector { selector, optional_selector } = SimilarSongSelector::new(&Song::default());
/// vec![Song::default()].iter().find(selector);
/// vec![Some(Song::default()), None].iter().find(optional_selector);
/// ```
pub struct SimilarSongSelector {
    pub selector: SSSelector,
    pub optional_selector: SSOSelector,
}

/// The type of a similar song selector which can pass to `Iterator<Item = &Song>`.
pub type SSSelector = Box<dyn Fn(&&Song) -> bool>;

/// The type of a similar song selector which can pass to `Iterator<Item = &Option<Song>>`.
pub type SSOSelector = Box<dyn Fn(&&Option<Song>) -> bool>;

impl SimilarSongSelector {
    /// Construct a "similar song selector" to pass to `.find()`.
    pub fn new(expected: &Song) -> SimilarSongSelector {
        let expected_duration = expected.duration;
        let basic_func = move |song: &&Song| {
            if let Some(expected_duration) = expected_duration {
                if let Some(song_duration) = song.duration {
                    // 第一个时长相差5s (5000ms) 之内的结果
                    i64::abs(song_duration - expected_duration) < 5000
                } else {
                    // 歌曲沒有長度，而期待有長度，則回傳 true。
                    //
                    // 最初我們是回傳 false，但一方面，不少音源都是沒有長度的，
                    // 這樣會導致這些音源不可用；另一方面，如果不是期待的音源，
                    // 使用者完全可以自行切換。有鑒於設成 false 弊大於利，我們
                    // 回傳 true。
                    true
                }
            } else {
                // 沒有期待長度，則回傳 true 直接取出任一選擇。
                true
            }
        };

        let optional_func = move |song: &&Option<Song>| {
            if let Some(s) = song {
                basic_func(&s)
            } else {
                false
            }
        };

        Self {
            selector: Box::new(basic_func),
            optional_selector: Box::new(optional_func),
        }
    }
}

#[cfg(test)]
mod tests {
    use once_cell::sync::Lazy;
    use serde_json::json;
    use unm_types::Song;

    use crate::SimilarSongSelector;

    static TESTDATA: Lazy<Vec<Song>> = Lazy::new(|| {
        let testdata = json!([
            {
                "id": "1429869",
                "name": "Now We Are Free",
                "duration": 254293,
                "artists": [
                    {
                        "id": "34517",
                        "name": "Hans Zimmer"
                    },
                    {
                        "id": "64211",
                        "name": "Lisa Gerrard"
                    }
                ],
                "album": {
                    "id": "146376",
                    "name": "Gladiator (Music from the Motion Picture)"
                }
            },
            {
                "id": "453189283",
                "name": "Now We Are Free (From \"Gladiator\")",
                "duration": 249373,
                "artists": [
                    {
                        "id": "64150",
                        "name": "Leona Lewis"
                    },
                    {
                        "id": "317723",
                        "name": "Gavin Greenaway"
                    }
                ],
                "album": {
                    "id": "35120359",
                    "name": "Hans Zimmer - The Classics"
                }
            },
            {
                "id": "1429947",
                "name": "Now We Are Free [Maximus Mix]",
                "duration": 229000,
                "artists": [
                    {
                        "id": "34517",
                        "name": "Hans Zimmer"
                    },
                    {
                        "id": "64211",
                        "name": "Lisa Gerrard"
                    }
                ],
                "album": {
                    "id": "146376",
                    "name": "Gladiator (Music from the Motion Picture)"
                }
            },
            {
                "id": "26598912",
                "name": "Now We Are Free",
                "duration": 256000,
                "artists": [
                    {
                        "id": "104700",
                        "name": "Various Artists"
                    }
                ],
                "album": {
                    "id": "2532108",
                    "name": "Beautiful Voices"
                }
            },
            {
                "id": "2929007",
                "name": "Now We Are Free",
                "duration": 254840,
                "artists": [
                    {
                        "id": "64211",
                        "name": "Lisa Gerrard"
                    }
                ],
                "album": {
                    "id": "295761",
                    "name": "The Best of Lisa Gerrard"
                }
            },
            {
                "id": "32405538",
                "name": "Now We Are Free (Spaarkey remix)",
                "duration": 279000,
                "artists": [
                    {
                        "id": "780173",
                        "name": "Spaarkey"
                    },
                    {
                        "id": "34517",
                        "name": "Hans Zimmer"
                    }
                ],
                "album": {
                    "id": "3154950",
                    "name": "Now We Are Free (Spaarkey remix)"
                }
            },
            {
                "id": "26237332",
                "name": "Now We Are Free (Theme from Gladiator)",
                "duration": 254000,
                "artists": [
                    {
                        "id": "34517",
                        "name": "Hans Zimmer"
                    }
                ],
                "album": {
                    "id": "2430544",
                    "name": "Absolute Romance"
                }
            },
            {
                "id": "19033177",
                "name": "Now We Are Free",
                "duration": 263888,
                "artists": [
                    {
                        "id": "62881",
                        "name": "Kelly Sweet"
                    }
                ],
                "album": {
                    "id": "1743395",
                    "name": "We Are One"
                }
            },
            {
                "id": "564675816",
                "name": "Now We Are Free",
                "duration": 259853,
                "artists": [
                    {
                        "id": "129532",
                        "name": "Movie Sounds Unlimited"
                    }
                ],
                "album": {
                    "id": "39132686",
                    "name": "Classics of the Future: The Music of Hans Zimmer"
                }
            },
            {
                "id": "567359126",
                "name": "Now We Are Free",
                "duration": 260693,
                "artists": [
                    {
                        "id": "12465813",
                        "name": "Ushuaia"
                    }
                ],
                "album": {
                    "id": "39337459",
                    "name": "Wellbeing Yoga & Meditation"
                }
            },
            {
                "id": "27021116",
                "name": "Now We Are Free",
                "duration": 258000,
                "artists": [
                    {
                        "id": "34517",
                        "name": "Hans Zimmer"
                    }
                ],
                "album": {
                    "id": "2577407",
                    "name": "Songbird"
                }
            },
            {
                "id": "447079329",
                "name": "Now We Are Free",
                "duration": 249417,
                "artists": [
                    {
                        "id": "64150",
                        "name": "Leona Lewis"
                    }
                ],
                "album": {
                    "id": "35051383",
                    "name": "Now We Are Free"
                }
            },
            {
                "id": "1447022560",
                "name": "Now We Are Free",
                "duration": 287529,
                "artists": [
                    {
                        "id": "317723",
                        "name": "Gavin Greenaway"
                    },
                    {
                        "id": "12505840",
                        "name": "The Lyndhurst Orchestra"
                    },
                    {
                        "id": "34517",
                        "name": "Hans Zimmer"
                    },
                    {
                        "id": "64211",
                        "name": "Lisa Gerrard"
                    }
                ],
                "album": {
                    "id": "89252573",
                    "name": "Gladiator: 20th Anniversary Edition"
                }
            },
            {
                "id": "1496965756",
                "name": "Now We Are Free (Gladiator 2021 Remix)",
                "duration": 188929,
                "artists": [
                    {
                        "id": "37533291",
                        "name": "Gladiator"
                    }
                ],
                "album": {
                    "id": "98576983",
                    "name": "Now We Are Free (Gladiator 2021 Remixes)"
                }
            },
            {
                "id": "564256334",
                "name": "Now We Are Free",
                "duration": 257544,
                "artists": [
                    {
                        "id": "13064228",
                        "name": "The Academy Allstars"
                    }
                ],
                "album": {
                    "id": "39104498",
                    "name": "The Sound of Cinema"
                }
            },
            {
                "id": "1896824339",
                "name": "Now We Are Free",
                "duration": 287529,
                "artists": [
                    {
                        "id": "317723",
                        "name": "Gavin Greenaway"
                    },
                    {
                        "id": "12505840",
                        "name": "The Lyndhurst Orchestra"
                    },
                    {
                        "id": "34517",
                        "name": "Hans Zimmer"
                    },
                    {
                        "id": "64211",
                        "name": "Lisa Gerrard"
                    }
                ],
                "album": {
                    "id": "136410538",
                    "name": "The World of Hans Zimmer"
                }
            },
            {
                "id": "1447023330",
                "name": "Now We Are Free",
                "duration": 230582,
                "artists": [
                    {
                        "id": "317723",
                        "name": "Gavin Greenaway"
                    },
                    {
                        "id": "12505840",
                        "name": "The Lyndhurst Orchestra"
                    },
                    {
                        "id": "34517",
                        "name": "Hans Zimmer"
                    },
                    {
                        "id": "64211",
                        "name": "Lisa Gerrard"
                    }
                ],
                "album": {
                    "id": "89252573",
                    "name": "Gladiator: 20th Anniversary Edition"
                }
            },
            {
                "id": "27761734",
                "name": "Now We Are Free",
                "duration": 263684,
                "artists": [
                    {
                        "id": "93190",
                        "name": "Gregorian"
                    }
                ],
                "album": {
                    "id": "2672555",
                    "name": "Masters of Chant: Chapter 9"
                }
            },
            {
                "id": "465833378",
                "name": "Now We are Free",
                "duration": 365557,
                "artists": [
                    {
                        "id": "101368",
                        "name": "2Cellos"
                    }
                ],
                "album": {
                    "id": "35274045",
                    "name": "Score"
                }
            },
            {
                "id": "1839148084",
                "name": "Now We Are Free",
                "duration": 230582,
                "artists": [
                    {
                        "id": "34517",
                        "name": "Hans Zimmer"
                    },
                    {
                        "id": "317723",
                        "name": "Gavin Greenaway"
                    },
                    {
                        "id": "12505840",
                        "name": "The Lyndhurst Orchestra"
                    },
                    {
                        "id": "64211",
                        "name": "Lisa Gerrard"
                    }
                ],
                "album": {
                    "id": "126343333",
                    "name": "Hans Zimmer: A Selection"
                }
            }
        ]);
        serde_json::from_value::<Vec<unm_types::Song>>(testdata).unwrap()
    });

    #[test]
    fn selector_without_duration_test() {
        let to_compare = Song::builder().name("Now We Are Free".into()).build();

        let SimilarSongSelector { selector, .. } = SimilarSongSelector::new(&to_compare);

        assert_eq!(
            TESTDATA.iter().find(selector).map(|v| v.duration),
            Some(Some(254293i64))
        );
    }

    #[test]
    fn selector_with_duration_test() {
        let to_compare = Song::builder()
            .name("Now We Are Free".into())
            .duration(Some(287529))
            .build();

        let SimilarSongSelector { selector, .. } = SimilarSongSelector::new(&to_compare);

        assert_eq!(
            TESTDATA.iter().find(selector).map(|v| v.duration),
            Some(Some(287529i64))
        );
    }

    #[test]
    fn optional_selector_without_duration_test() {
        let to_compare = Song::builder().name("Now We Are Free".into()).build();

        let SimilarSongSelector {
            optional_selector, ..
        } = SimilarSongSelector::new(&to_compare);

        let testdata = TESTDATA
            .clone()
            .into_iter()
            .map(Some)
            .collect::<Vec<Option<Song>>>();

        assert_eq!(
            testdata
                .iter()
                .find(optional_selector)
                .map(|v| v.as_ref().map(|v| v.duration)),
            Some(Some(Some(254293i64)))
        );
    }

    #[test]
    fn optional_selector_with_duration_test() {
        let to_compare = Song::builder()
            .name("Now We Are Free".into())
            .duration(Some(287529))
            .build();

        let SimilarSongSelector {
            optional_selector, ..
        } = SimilarSongSelector::new(&to_compare);

        let testdata = TESTDATA
            .clone()
            .into_iter()
            .map(Some)
            .collect::<Vec<Option<Song>>>();

        assert_eq!(
            testdata
                .iter()
                .find(optional_selector)
                .map(|v| v.as_ref().map(|v| v.duration)),
            Some(Some(Some(287529i64)))
        );
    }
}
