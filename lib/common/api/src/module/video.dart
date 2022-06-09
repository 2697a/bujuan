part of '../module.dart';

// 视频详情
Handler video_detail = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/v1/video/detail',
    {
      'id': query!['id'],
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 视频链接
Handler video_group = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/videotimeline/videogroup/get',
    {
      'groupId': query!['id'],
      'offset': query['offset'] ?? 0,
      'needUrl': true,
      'resolution': query['res'] ?? 1080
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 收藏与取消收藏视频
Handler video_sub = (query, cookie) {
  query!['t'] = (query['t'] == 1 ? 'sub' : 'unsub');
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/video/${query['t']}',
    {
      'id': query['id'],
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};

// 视频链接
Handler video_url = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/playurl',
    {
      'ids': '["' + query!['id'] + '"]',
      'resolution': query['res'] ?? 1080,
    },
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
