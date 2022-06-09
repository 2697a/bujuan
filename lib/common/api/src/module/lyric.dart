part of '../module.dart';

// 歌词
Handler lyric = (query, cookie) {
  final data = {'id': query!['id']};
  return request(
      'POST', 'https://music.163.com/weapi/song/lyric?lv=-1&kv=-1&tv=-1', data,
      crypto: Crypto.linuxapi, cookies: cookie, ua: 'pc');
};
