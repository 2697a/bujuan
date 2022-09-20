part of '../module.dart';

Handler banner = (query, cookie) {
  final type = const {
        0: 'pc',
        1: 'android',
        2: 'iphone',
        3: 'ipad'
      }[query!['type'] ?? 0] ??
      'pc';
  return request(
      'POST', 'https://music.163.com/api/v2/banner/get', {'clientType': type},
      crypto: Crypto.linuxapi, cookies: cookie);
};
