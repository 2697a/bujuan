part of '../module.dart';

// 相关视频
Handler related_allvideo = (query, cookie) {
  return request(
      'GET',
      'https://music.163.com/weapi/v1/discovery/recommend/songs',
      {
        'id': query!['id'],
        'type': ((RegExp(r'^\d+$')).hasMatch(query['id'])) ? 0 : 1
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 相关歌单
Handler related_playlist = (query, cookie) {
  return request(
          'POST', 'https://music.163.com/playlist?id=${query!['id']}', {},
          crypto: Crypto.weapi, ua: 'pc', cookies: cookie)
      .then((value) {
    throw 'TODO';
  });
};
