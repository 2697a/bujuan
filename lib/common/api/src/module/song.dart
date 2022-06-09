part of '../module.dart';

const _keys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

// 歌曲详情
Handler song_detail = (query, cookie) {
  assert(query != null && query.isNotEmpty);
  final ids = query!['ids'].toString().split(RegExp(r'\s*,\s*'));
  assert(ids.isNotEmpty);
  return request(
      'POST',
      'https://music.163.com/weapi/v3/song/detail',
      {
        'c': '[${ids.map((id) => ('{"id": ${id}}')).join(',')}]',
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 歌曲链接
Handler song_url = (query, cookie) {
  if (!cookie.any((cookie) => cookie.name == 'MUSIC_U')) {
    String _createdSecretKey({int size = 16}) {
      StringBuffer buffer = StringBuffer();
      for (var i = 0; i < size; i++) {
        final position = math.Random().nextInt(_keys.length);
        buffer.write(_keys[position]);
      }
      return buffer.toString();
    }

    cookie = List.from(cookie)..add(Cookie('_ntes_nuid', _createdSecretKey()));
  }

  return request(
      'POST',
      'https://music.163.com/weapi/song/enhance/player/url',
      {
        'ids': '[${query!['id']}]',
        'br': int.parse(query['br'] ?? '999000'),
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};
