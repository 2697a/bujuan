part of '../module.dart';

// 评论
Handler msg_comment = (query, cookie) {
  final data = {
    'beforeTime': query!['beforeTime'] ?? "-1",
    'limit': query['limit'] ?? 30,
    'total': "true",
    'uid': query['uid']
  };
  return request('POST',
      'https://music.163.com/api/v1/user/comments/${query['uid']}', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// @我
Handler msg_forwards = (query, cookie) {
  final data = {
    'offset': query!['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': "true"
  };
  return request('POST', 'https://music.163.com/api/forwards/get', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 通知
Handler msg_notice = (query, cookie) {
  final data = {
    'offset': query!['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': "true"
  };
  return request('POST', 'https://music.163.com/api/msg/notices', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 私信内容
Handler msg_private_history = (query, cookie) {
  final data = {
    'userId': query!['uid'],
    'offset': query['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': "true"
  };
  return request('POST', 'https://music.163.com/api/msg/private/history', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 私信
Handler msg_private = (query, cookie) {
  final data = {
    'offset': query!['offset'] ?? 0,
    'limit': query['limit'] ?? 30,
    'total': "true"
  };
  return request('POST', 'https://music.163.com/api/msg/private/users', data,
      crypto: Crypto.weapi, cookies: cookie);
};
