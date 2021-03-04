part of '../module.dart';

//歌手专辑
Handler artist_album = (Map query, List<Cookie> cookie) {
  return request(
      'POST',
      "https://music.163.com/weapi/artist/albums/${query['id']}",
      {
        'limit': query['limit'] ?? 30,
        'offset': query['offset'] ?? 0,
        'total': true
      },
      cookies: cookie,
      crypto: Crypto.weapi);
};

//歌手介绍
Handler artist_desc = (query, cookie) => request('POST',
    'https://music.163.com/weapi/artist/introduction', {'id': query['id']},
    crypto: Crypto.weapi, cookies: cookie);

//歌手分类
/* 
    categoryCode 取值
    入驻歌手 5001
    华语男歌手 1001
    华语女歌手 1002
    华语组合/乐队 1003
    欧美男歌手 2001
    欧美女歌手 2002
    欧美组合/乐队 2003
    日本男歌手 6001
    日本女歌手 6002
    日本组合/乐队 6003
    韩国男歌手 7001
    韩国女歌手 7002
    韩国组合/乐队 7003
    其他男歌手 4001
    其他女歌手 4002
    其他组合/乐队 4003

    initial 取值 a-z/A-Z
*/
Handler artist_list = (Map query, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/artist/list',
      {
        'categoryCode': query['cat'] ?? '1001',
        'initial':
            (query['initial'] as String)?.toUpperCase()?.codeUnitAt(0) ?? '',
        'offset': query['offset'] ?? 0,
        'limit': query['limit'] ?? 30,
        'total': true
      },
      cookies: cookie,
      crypto: Crypto.weapi);
};

//歌手相关MV
Handler artist_mv = (query, cookie) => request(
    'POST',
    'https://music.163.com/weapi/artist/mvs',
    {
      'artistId': query['id'],
      'limit': query['limit'] ?? 30,
      'offset': query['offset'] ?? 0,
      'total': true
    },
    crypto: Crypto.weapi,
    cookies: cookie);

//收藏与取消收藏歌手
Handler artist_sub = (query, cookie) {
  query['t'] = (query['t'] == 1) ? 'sub' : 'unsub';
  return request('POST', 'https://music.163.com/weapi/artist/${query['t']}',
      {'artistId': query['id'], 'artistIds': '[${query['id']}]'},
      crypto: Crypto.weapi, cookies: cookie);
};

//关注歌手列表
Handler artist_sublist = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/artist/sublist',
      {
        'limit': query['limit'] ?? 120,
        'offset': query['offset'] ?? 0,
        'total': true
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

//歌手单曲
Handler artists = (query, cookie) => request(
    'POST', 'https://music.163.com/weapi/v1/artist/${query['id']}', {},
    crypto: Crypto.weapi, cookies: cookie);
