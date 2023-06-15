pub mod typing;

use cached::proc_macro::once;
use concat_string::concat_string;
use http::header::{COOKIE, REFERER};
use http::HeaderValue;
use reqwest::header::HeaderMap;
use reqwest::Url;
use unm_request::build_client;
use unm_types::Context;

use self::typing::{GetPlayUrlResponse, MusicID, SearchResponse};

pub fn genenate_kw_token() -> String {
    log::debug!("Generating kw_token…");
    let charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    random_string::generate(11, charset)
}

#[once(time = "3600" /* 1hr */, result = true)]
pub fn construct_header() -> anyhow::Result<HeaderMap> {
    log::debug!("Constructing header to pass to Kuwo Music…");
    let token = genenate_kw_token();
    let mut hm = HeaderMap::with_capacity(3);

    hm.insert(
        COOKIE,
        HeaderValue::from_str(&concat_string!("kw_token=", token))?,
    );
    hm.insert(REFERER, HeaderValue::from_static("http://www.kuwo.cn/"));
    hm.insert("csrf", HeaderValue::from_str(&token)?);

    Ok(hm)
}

pub async fn search_music_by_keyword(
    keyword: &str,
    page_number: i32,
    entries_per_page: i32,
    ctx: &Context,
) -> anyhow::Result<SearchResponse> {
    log::debug!("Searching music in Kuwo by keyword “{keyword}”… [Page {page_number}, {entries_per_page} entries]");

    let client = build_client(ctx.proxy_uri.as_deref())?;
    let url = Url::parse_with_params(
        "http://www.kuwo.cn/api/www/search/searchMusicBykeyWord",
        &[
            ("key", keyword),
            ("pn", &page_number.to_string()),
            ("rn", &entries_per_page.to_string()),
            ("httpsStatus", "1"),
        ],
    )?;

    let response = client.get(url).headers(construct_header()?).send().await?;
    let json = response.json::<SearchResponse>().await?;

    Ok(json)
}

pub async fn get_music(mid: MusicID, ctx: &Context) -> anyhow::Result<GetPlayUrlResponse> {
    log::debug!("Fetch the music with MID “{mid}” from Kuwo Music…");

    let client = build_client(ctx.proxy_uri.as_deref())?;
    let url = Url::parse_with_params(
        "http://www.kuwo.cn/api/v1/www/music/playUrl",
        &[
            ("mid", mid.to_string().as_str()),
            ("type", "music"),
            ("httpsStatus", "1"),
        ],
    )?;

    let response = client.get(url).headers(construct_header()?).send().await?;
    let json = response.json::<GetPlayUrlResponse>().await?;

    Ok(json)
}

#[cfg(test)]
mod tests {
    use concat_string::concat_string;
    use http::header::{COOKIE, REFERER};

    use super::construct_header;

    #[test]
    fn construct_header_test() {
        let h = construct_header().expect("should be able to construct header");
        let getstr = |k: &str| {
            h.get(k)
                .expect("should has cookie")
                .to_str()
                .expect("should able to convert to string")
        };

        let token = getstr(COOKIE.as_str()).replace("kw_token=", "");

        assert_eq!(getstr(COOKIE.as_str()), concat_string!("kw_token=", token));
        assert_eq!(getstr(REFERER.as_str()), "http://www.kuwo.cn/");
        assert_eq!(getstr("csrf"), token);
    }
}
