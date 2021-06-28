part of '../module.dart';

//专辑评论
Handler comment_album = (query, cookies) {
  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offst': query['offset'] ?? 0
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/R_AL_3_${query['id']}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//电台评论
Handler comment_dj = (query, cookies) {
  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offst': query['offset'] ?? 0
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/A_DJ_1_${query['id']}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//动态评论
Handler comment_events = (query, cookies) {
  final data = {'limit': query['limit'] ?? 20, 'offst': query['offset'] ?? 0};
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/${query['threadId']}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//热门评论
Handler comment_hot = (query, cookies) {
  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_' //  视频
  }[query['type']];

  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offst': query['offset'] ?? 0
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/hotcomments/${query['type']}${query['id']}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

// 点赞与取消点赞评论
Handler comment_like = (query, cookies) {
  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_' //  视频
  }[query['type']];

  final data = {
    'threadId': query['type'] + query['id'],
    'commentId': query['cid']
  };
  if (query['type'] == 'A_EV_2_') {
    data['threadId'] = query['threadId'];
  }
  return request(
      'POST', ' https://music.163.com/weapi/v1/comment/${query['t']}', data,
      crypto: Crypto.weapi, cookies: cookies);
};

//歌曲评论
Handler comment_music = (query, cookies) {
  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 15,
    'offset': query['offset'] ?? 0,
    'beforeTime': query['before'] ?? 0
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/R_SO_4_${query['id']}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//评论(新)
Handler comment_new = (query, cookies) {
  cookies.add(Cookie('os', 'pc'));
  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'A_EV_2_' //  动态
  }[query['type']];
  final threadId = '${query['type']}${query['id']}';
  final pageSize = query['pageSize'] ?? 20;
  final pageNo = query['pageNo'] ?? 1;
  final sortType = query['sortType'] ?? 2;
  final data = {
    'threadId': threadId,
    'pageNo': pageNo,
    'showInner': query['showInner'] ?? true,
    'pageSize': pageSize,
    'cursor': sortType == 3 ? query['cursor'] ?? '0' : '${(pageNo - 1) * pageSize}',
    'sortType': sortType, //1:按推荐排序,2:按热度排序,3:按时间排序
  };
  return request('POST', 'https://music.163.com/api/v2/resource/comments', data,
      crypto: Crypto.weapi, cookies: cookies);
};

//楼层评论
Handler comment_floor = (query, cookies) {
  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'A_EV_2_' //  动态
  }[query['type']];
  final data = {
    'parentCommentId': query['parentCommentId'],
    'threadId': '${query['type']}${query['id']}',
    'time': query['time'] ?? -1,
    'limit': query['limit'] ?? 20,
  };
  log('$data');
  var request2 = request('POST', 'https://music.163.com/api/resource/comment/floor/get', data,
      crypto: Crypto.weapi, cookies: cookies);
  return request2;
};
//mv评论
Handler comment_mv = (query, cookies) {
  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 30,
    'offset': query['offset'] ?? 0
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/R_MV_5_${query['id']}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//歌单评论
Handler comment_playlist = (query, cookies) {
  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/A_PL_0_${query['id']}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//视频评论
Handler comment_video = (query, cookies) {
  final data = {
    'rid': query['id'],
    'limit': query['limit'] ?? 20,
    'offset': query['offset'] ?? 0
  };
  return request(
      'POST',
      'https://music.163.com/weapi/v1/resource/comments/R_VI_62_${query['id']}',
      data,
      crypto: Crypto.weapi,
      cookies: cookies);
};

//发送与删除评论
Handler comment = (query, cookies) {
  query['t'] = (query['t'] == 1 ? 'add' : 'delete');
  query['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'A_EV_2_' //  动态
  }[query['type']];

  final data = {
    'threadId': query['type'] + query['id'],
  };
  if (query['type'] == 'A_EV_2_') {
    data['threadId'] = query['threadId'];
  }

  if (query['t'] == 'add')
    data['content'] = query['content'];
  else if (query['t'] == 'delete') data['commentId'] = query['commentId'];
  return request('POST',
      'https://music.163.com/weapi/resource/comments/${query['t']}', data,
      crypto: Crypto.weapi, cookies: cookies);
};
