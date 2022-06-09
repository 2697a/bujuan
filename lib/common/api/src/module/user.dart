part of '../module.dart';

// 用户创建的电台
Handler user_audio = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/djradio/get/byuser',
      {
        'userId': query!['uid'],
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 云盘歌曲删除
Handler user_cloud_del = (query, cookie) {
  return request(
      'POST',
      'http://music.163.com/weapi/cloud/del',
      {
        'songIds': [query!['id']]
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 云盘数据详情
Handler user_cloud_detail = (query, cookie) {
  final id = query!['id'].toString().replaceAll(' ', "").split(",");
  return request(
      'POST', 'https://music.163.com/weapi/v1/cloud/get/byids', {'songIds': id},
      crypto: Crypto.weapi, cookies: cookie);
};

// 云盘数据
Handler user_cloud = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/v1/cloud/get',
      {
        'limit': query!['limit'] ?? 30,
        'offset': query['offset'] ?? 0,
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 用户详情
Handler user_detail = (query, cookie) {
  return request(
      'POST', 'https://music.163.com/weapi/v1/user/detail/${query!['uid']}', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 用户电台节目
Handler user_dj = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/dj/program/${query!['uid']}',
      {
        'limit': query['limit'] ?? 30,
        'offset': query['offset'] ?? 0,
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 用户动态
Handler user_event = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/event/get/${query!['uid']}',
      {
        'getcounts': true,
        'limit': query['limit'] ?? 30,
        'time': query['lasttime'] ?? -1,
        'total': false
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 关注TA的人(粉丝)
Handler user_followeds = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/user/getfolloweds',
      {
        'userId': query!['uid'],
        'limit': query['limit'] ?? 30,
        'time': query['lasttime '] ?? -1,
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// TA关注的人(关注)
Handler user_follows = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/user/getfollows/${query!['uid']}',
      {
        'limit': query['limit'] ?? 30,
        'offset': query['offset'] ?? 0,
        'order': true
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 用户歌单
Handler user_playlist = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/user/playlist',
      {
        'uid': query!['uid'],
        'limit': query['limit'] ?? 30,
        'offset': query['offset'] ?? 0,
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 听歌排行
Handler user_record = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/v1/play/record',
      {
        'uid': query!['uid'],
        'type': query['type'] ?? 1 // 1: 最近一周, 0: 所有时间
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 收藏计数
Handler user_subcount = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/subcount',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 编辑用户信息
Handler user_update = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/user/profile/update',
    {
      'avatarImgId': "0",
      'birthday': query!['birthday'],
      'city': query['city'],
      'gender': query['gender'],
      'nickname': query['nickname'],
      'province': query['province'],
      'signature': query['signature']
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
