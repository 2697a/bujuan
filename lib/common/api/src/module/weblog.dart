part of '../module.dart';

// 操作记录
Handler weblog = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/feedback/weblog',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
