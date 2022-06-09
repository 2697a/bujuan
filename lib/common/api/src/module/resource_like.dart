part of '../module.dart';

// 点赞与取消点赞资源
Handler resource_like = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  query!['t'] = (query['t'] == 1 ? 'like' : 'unlike');
  query['type'] = const {
    1: 'R_MV_5_', //  MV
    4: 'A_DJ_1_', //  电台
    5: 'R_VI_62_', //  视频
    6: 'A_EV_2_'
  }[query['type']];

  final data = {'threadId': '${query['type']}${query['id']}'};
  if (query['type'] == 'A_EV_2_') {
    data['threadId'] = query['threadId'];
  }

  return request(
      'POST', 'https://music.163.com/weapi/v1/discovery/recommend/songs', data,
      crypto: Crypto.weapi, cookies: cookie);
};
