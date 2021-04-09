part of '../module.dart';

// 红心与取消红心歌曲
Handler like_song = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  cookie.add(Cookie('appver', '2.7.1.198277'));
  final data = {
    'alg':'itembased',
    'trackId': query['id'],
    'like': query['like'] == 'false' ? false : true,
    'time':'3'
  };
  return request(
      'POST',
      'https://music.163.com/api/radio/like',
      data,
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 喜欢的歌曲(无序)
Handler likelist = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/song/like/get',
      {'uid': query['uid']},
      crypto: Crypto.weapi, cookies: cookie);
};
//302618605