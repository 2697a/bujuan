part of '../module.dart';

Handler album_newest = (Map? query, List<Cookie> cookie) {
  return request('POST', "https://music.163.com/api/discovery/newAlbum", {},
      cookies: cookie, crypto: Crypto.weapi);
};

Handler album_sublist = (query, cookie) => request(
    'POST',
    'https://music.163.com/weapi/album/sublist',
    {
      'limit': query!['limit'] ?? 25,
      'offset': query['offset'] ?? 0,
      'total': true
    },
    crypto: Crypto.weapi,
    cookies: cookie);

//专辑内容
Handler album = (Map? query, List<Cookie> cookie) {
  return request(
      'POST', "https://music.163.com/weapi/v1/album/${query!['id']}", {},
      cookies: cookie, crypto: Crypto.weapi);
};
