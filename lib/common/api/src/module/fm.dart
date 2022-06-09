part of '../module.dart';

// 删除动态
Handler fm_trash = (query, cookie) {
  final data = {
    'songId': query!['id'],
  };
  return request(
      'POST',
      'https://music.163.com/weapi/radio/trash/add?alg=RT&songId=${query['id']}&time=${query['time'] ?? 25}',
      data,
      crypto: Crypto.weapi,
      cookies: cookie);
};
