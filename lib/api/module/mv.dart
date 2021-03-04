part of '../module.dart';

// MV详情
Handler mv_detail = (query, cookie) {
  final data = {'id': query['mvid']};
  return request('POST', 'https://music.163.com/weapi/mv/detail', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 最新MV
Handler mv_first = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 30,
    'total': true,
  };
  return request('POST', 'https://music.163.com/weapi/mv/first', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 收藏与取消收藏MV
Handler mv_sub = (query, cookie) {
  query['t'] = (query['t'] == 1 ? 'sub' : 'unsub');
  final data = {
    'mvId': query['mvid'],
    'mvIds': '["' + query['mvid'] + '"]',
  };
  return request('POST', 'https://music.163.com/weapi/mv/${query['t']}', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 已收藏MV列表
Handler mv_sublist = (query, cookie) {
  final data = {
    'limit': query['limit'] ?? 30,
    'total': true,
  };
  return request('POST', 'https://music.163.com/weapi/mv/first', data,
      crypto: Crypto.weapi, cookies: cookie);
};