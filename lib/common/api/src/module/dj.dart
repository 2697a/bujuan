part of '../module.dart';

//电台banner
Handler dj_banner = (query, cookie) {
  return request(
      'POST', 'http://music.163.com/weapi/djradio/banner/get', const {},
      crypto: Crypto.weapi, cookies: cookie);
};

//dj非热门类型
Handler dj_category_excludehot = (query, cookie) {
  return request('POST',
      'http://music.163.com/weapi/djradio/category/excludehot', const {},
      crypto: Crypto.weapi, cookies: cookie);
};

//dj推荐类型
Handler dj_category_recommend = (query, cookie) {
  return request(
      'POST', 'http://music.163.com/weapi/djradio/category/recommend', const {},
      crypto: Crypto.weapi, cookies: cookie);
};

//电台分类列表
Handler dj_catelist = (query, cookie) {
  return request(
      'POST', 'http://music.163.com/weapi/djradio/category/get', const {},
      crypto: Crypto.weapi, cookies: cookie);
};

//电台详情
Handler dj_detail = (query, cookie) {
  return request(
      'POST', 'https://music.163.com/weapi/djradio/get', {'id': query!['rid']},
      crypto: Crypto.weapi, cookies: cookie);
};

//热门电台
Handler dj_hot = (query, cookie) {
  final data = {
    'cat': query!['type'],
    'cateId': query['type'],
    'type': query['type'],
    'categoryId': query['type'],
    'category': query['type'],
    'limit': query['limit'],
    'offset': query['offset']
  };
  return request('POST', 'https://music.163.com/weapi/djradio/hot/v1', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 付费电台
Handler dj_paygift = (query, cookie) {
  final data = {
    'limit': query!['limit'] ?? 30,
    ['offset']: query['offset'] ?? 0
  };
  return request('POST',
      'https://music.163.com/weapi/djradio/home/paygift/list?_nmclfl=1', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 电台节目详情
Handler dj_program_detail = (query, cookie) {
  final data = {'id': query!['id']};
  return request('POST', 'https://music.163.com/weapi/dj/program/detail', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 电台节目列表
Handler dj_program = (query, cookie) {
  final data = {
    'radioId': query!['rid'],
    'limit': query['limit'] ?? 30,
    'offset': query['offset'] ?? 0,
    'asc': toBoolean(query['asc'])
  };
  return request('POST', 'https://music.163.com/weapi/dj/program/byradio', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 精选电台分类

/*
    有声书 10001
    知识技能 453050
    商业财经 453051
    人文历史 11
    外语世界 13
    亲子宝贝 14
    创作|翻唱 2001
    音乐故事 2
    3D|电子 10002
    相声曲艺 8
    情感调频 3
    美文读物 6
    脱口秀 5
    广播剧 7
    二次元 3001
    明星做主播 1
    娱乐|影视 4
    科技科学 453052
    校园|教育 4001
    旅途|城市 12
*/
Handler dj_recommend_type = (query, cookie) {
  final data = {'cateId': query!['type']};
  return request('POST', 'https://music.163.com/weapi/djradio/recommend', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// 精选电台
Handler dj_recommend = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/djradio/recommend/v1', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 精选电台
Handler dj_sub = (query, cookie) {
  query!['t'] = (query['t'] == 1 ? 'sub' : 'unsub');
  return request('POST', 'https://music.163.com/weapi/djradio/${query['t']}',
      {'id': query['rid']},
      crypto: Crypto.weapi, cookies: cookie);
};

// 订阅电台列表
Handler dj_sublist = (query, cookie) {
  final data = {
    'limit': query!['limit'] ?? 30,
    'offset': query['offset'] ?? 0,
    'total': true
  };
  return request('POST', 'https://music.163.com/weapi/djradio/get/subed', data,
      crypto: Crypto.weapi, cookies: cookie);
};

// dj今日优选
Handler dj_today_perfered = (query, cookie) {
  final data = {'page': query!['page'] ?? 0};
  return request(
      'POST', 'http://music.163.com/weapi/djradio/home/today/perfered', data,
      crypto: Crypto.weapi, cookies: cookie);
};
