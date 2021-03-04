part of '../module.dart';

// 红心与取消红心歌曲
Handler like_song = (query, cookie) {
  final data = {
    'trackId': query['id'],
    'like': query['like'] == 'false' ? false : true,
  };
  return request(
      'POST',
      'https://music.163.com/weapi/radio/like?alg=${query['alg'] ?? 'itembased'}&trackId=${query['id']}&time=${query['time'] ?? 25}',
      data,
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 喜欢的歌曲(无序)
Handler likelist = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/song/like/get',
      {"uid": query['uid']},
      crypto: Crypto.weapi, cookies: cookie);
};
//302618605