part of '../module.dart';

// 全部歌单分类
Handler playlist_catlist = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/playlist/catalogue', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 创建歌单
Handler playlist_create = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));

  return request(
      'POST',
      'https://music.163.com/weapi/playlist/create',
      {
        'name': query!['name'],
        'privacy': query['privacy'], //0 为普通歌单，10 为隐私歌单
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 歌单详情
Handler playlist_detail = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/v3/playlist/detail',
      {
        'id': query!['id'],
        'n': 100000,
        's': query['s'] ?? 8,
      },
      crypto: Crypto.linuxapi,
      cookies: cookie);
};

// 热门歌单分类
Handler playlist_hot = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/playlist/hottags', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 收藏与取消收藏歌单
Handler playlist_subscribe = (query, cookie) {
  query!['t'] = (query['t'] == 1 ? 'subscribe' : 'unsubscribe');
  return request(
      'POST',
      'https://music.163.com/weapi/playlist/${query['t']}',
      {
        'id': query['id'],
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 歌单收藏者
Handler playlist_subscribers = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/playlist/subscribers',
      {
        'id': query!['id'],
        'limit': query['limit'] ?? 20,
        'offset': query['offset'] ?? 0
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 收藏单曲到歌单 从歌单删除歌曲
Handler playlist_tracks = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/playlist/subscribers',
      {
        'op': query!['op'], // del,add
        'pid': query['pid'], // 歌单id
        'trackIds': '[' + query['tracks'] + ']' // 歌曲id
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};
