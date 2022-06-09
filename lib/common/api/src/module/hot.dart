part of '../module.dart';

//热门话题
Handler hot_topic = (query, cookie) {
  final data = {'limit': query!['limit'] ?? 20, 'offset': query['offset'] ?? 0};
  return request('POST', 'http://music.163.com/weapi/act/hot', data,
      crypto: Crypto.weapi, cookies: cookie);
};
