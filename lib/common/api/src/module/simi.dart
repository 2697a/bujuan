part of '../module.dart';

// 相似歌手
Handler simi_artist = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/discovery/simiArtist',
      {
        'artistid': query!['id'],
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

Handler simi_mv = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/discovery/simiMv',
      {
        'mvid': query!['mvid'],
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

Handler simi_playlist = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/discovery/simiPlaylist',
      {
        'playlistid': query!['playlistid'],
        'limit': query['limit'] ?? 50,
        'offset': query['offset'] ?? 0
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

Handler simi_song = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/discovery/simiSong',
      {
        'songid': query!['id'],
        'limit': query['limit'] ?? 50,
        'offset': query['offset'] ?? 0
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

Handler simi_user = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/discovery/simiUser',
      {
        'songid': query!['id'],
        'limit': query['limit'] ?? 50,
        'offset': query['offset'] ?? 0
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};
