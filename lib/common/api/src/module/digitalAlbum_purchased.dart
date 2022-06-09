part of '../module.dart';

//我的数字专辑
Handler digitalAlbum_purchased = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/api/digitalAlbum/purchased',
      {
        'limit': query!['limit'] ?? 30,
        'offset': query['offset'] ?? 0,
        'total': true,
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};
