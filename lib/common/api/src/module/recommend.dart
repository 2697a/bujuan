part of '../module.dart';

// 推荐节目
Handler program_recommend = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/program/recommend/v1',
      {
        'cateId': query!['type'],
        'limit': query['limit'] ?? 10,
        'offset': query['offset'] ?? 0
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 每日推荐歌单
Handler recommend_resource = (query, cookie) {
  return request(
      'POST', 'https://music.163.com/weapi/v1/discovery/recommend/resource', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 每日推荐歌曲
Handler recommend_songs = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/v1/discovery/recommend/songs',
      {'limit': 20, 'offset': 0, 'total': true},
      crypto: Crypto.weapi,
      cookies: cookie);
};
