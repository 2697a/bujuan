part of '../module.dart';

// 删除动态
Handler event_del = (query, cookie) {
  final data = {
    'id': query!['evId'],
  };
  return request('POST', 'https://music.163.com/eapi/event/delete', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 转发动态
Handler event_forward = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'forwards': query!['forwards'],
    'id': query['evId'],
    'eventUserId': query['uid']
  };
  return request('POST', 'https://music.163.com/weapi/event/forward', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 动态
Handler event = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    "pagesize": query!['pagesize'] ?? 20,
    "lasttime": query['lasttime'] ?? -1
  };
  return request('POST', 'https://music.163.com/weapi/v1/event/get', data,
      crypto: Crypto.weapi, cookies: cookie);
};
