part of '../module.dart';

// 私人FM
Handler personal_fm = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/v1/radio/get', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 推荐电台
Handler personalized_djprogram = (query, cookie) {
  return request(
      'POST', 'https://music.163.com/weapi/personalized/djprogram', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 推荐电台
Handler personalized_mv = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/personalized/mv', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 推荐新歌
Handler personalized_newsong = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/personalized/newsong', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 独家放送
Handler personalized_privatecontent = (query, cookie) {
  return request(
      'POST', 'https://music.163.com/weapi/personalized/privatecontent', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 推荐歌单
Handler personalized = (query, cookie) {
  return request(
      'POST', 'https://music.163.com/weapi/personalized/playlist', {},
      crypto: Crypto.weapi, cookies: cookie);
};
