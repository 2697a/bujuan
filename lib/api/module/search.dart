part of '../module.dart';

// 热门搜索
Handler search_hot = (query, cookie) {
  return request(
      'POST', 'https://music.163.com/weapi/search/hot', {'type': 1111},
      crypto: Crypto.weapi, cookies: cookie, ua: 'mobile');
};
// 热门搜索
Handler search_hot_details = (query, cookie) {
  return request(
      'POST', 'https://music.163.com/weapi/hotsearchlist/get', {'type': 1111},
      crypto: Crypto.weapi, cookies: cookie, ua: 'mobile');
};
// 多类型搜索
Handler search_multimatch = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/search/suggest/multimatch',
      {
        'type': query['type'] ?? 1,
        's': query['keywords'] ?? '',
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 搜索建议
Handler search_suggest = (query, cookie) {
  final type = query['type'] == 'mobile' ? 'keyword' : 'web';
  return request('POST', 'https://music.163.com/weapi/search/suggest/$type',
      {'s': query['keywords'] ?? ''},
      crypto: Crypto.weapi, cookies: cookie);
};

//搜索

Handler search = (query, cookie) {
  final data = {
    's': query['keywords'],
    // 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
    'type': query['type'] ?? 1,
    'limit': query['limit'] ?? 30,
    'offset': query['offset'] ?? 0
  };
  return request('POST', 'https://music.163.com/weapi/search/get', data,
      crypto: Crypto.weapi, cookies: cookie);
};
