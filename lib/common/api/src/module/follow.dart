part of '../module.dart';

// 关注与取消关注用户
Handler follow = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  query!['t'] = (query['t'] == 1 ? 'follow' : 'delfollow');
  return request('POST',
      'https://music.163.com/weapi/user/${query['t']}/${query['id']}', {},
      crypto: Crypto.weapi, cookies: cookie);
};
