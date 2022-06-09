part of '../module.dart';

// 新碟上架
Handler top_album = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/album/new',
      {
        'area': query!['type'] ?? 'ALL', // ALL,ZH,EA,KR,JP
        'limit': query['limit'] ?? 50,
        'offset': query['offset'] ?? 0,
        'total': true
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 热门歌手
Handler top_artists = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/artist/top',
      {
        'limit': query!['limit'] ?? 50,
        'offset': query['offset'] ?? 0,
        'total': true
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

const topList = {
  0: "3779629", //云音乐新歌榜
  1: "3778678", //云音乐热歌榜
  2: "2884035", //云音乐原创榜
  3: "19723756", //云音乐飙升榜
  4: "10520166", //云音乐电音榜
  5: "180106", //UK排行榜周榜
  6: "60198", //美国Billboard周榜
  7: "21845217", //KTV嗨榜
  8: "11641012", //iTunes榜
  9: "120001", //Hit FM Top榜
  10: "60131", //日本Oricon周榜
  11: "3733003", //韩国Melon排行榜周榜
  12: "60255", //韩国Mnet排行榜周榜
  13: "46772709", //韩国Melon原声周榜
  14: "112504", //中国TOP排行榜(港台榜)
  15: "64016", //中国TOP排行榜(内地榜)
  16: "10169002", //香港电台中文歌曲龙虎榜
  17: "4395559", //华语金曲榜
  18: "1899724", //中国嘻哈榜
  19: "27135204", //法国 NRJ EuroHot 30周榜
  20: "112463", //台湾Hito排行榜
  21: "3812895", //Beatport全球电子舞曲榜
  22: "71385702", //云音乐ACG音乐榜
  23: "991319590" //云音乐嘻哈榜
};

// 排行榜
Handler top_list = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/v3/playlist/detail',
      {'id': topList[query!['idx']], 'n': 10000},
      crypto: Crypto.linuxapi, cookies: cookie);
};

// MV排行榜
Handler top_mv = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/mv/toplist',
      {
        'limit': query!['limit'] ?? 50,
        'offset': query['offset'] ?? 0,
        'total': true
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 精品歌单
Handler top_playlist_highquality = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/playlist/highquality/list',
      {
        // 全部,华语,欧美,韩语,日语,粤语,小语种,运动,ACG,影视原声,流行,摇滚,后摇,古风,民谣,轻音乐,电子,器乐,说唱,古典,爵士
        'cat': query!['cat'] ?? '全部',
        'limit': query['limit'] ?? 50,
        'lasttime': query['before'] ?? 0,
        // 歌单updateTime
        'total': true
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 分类歌单
Handler top_playlist = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/playlist/list',
      {
        // 全部,华语,欧美,日语,韩语,粤语,小语种,流行,摇滚,民谣,电子,舞曲,说唱,轻音乐,爵士,乡村,R&B/Soul,古典,民族,英伦,金属,朋克,蓝调,雷鬼,世界音乐,拉丁,另类/独立,New Age,古风,后摇,Bossa Nova,清晨,夜晚,学习,工作,午休,下午茶,地铁,驾车,运动,旅行,散步,酒吧,怀旧,清新,浪漫,性感,伤感,治愈,放松,孤独,感动,兴奋,快乐,安静,思念,影视原声,ACG,儿童,校园,游戏,70后,80后,90后,网络歌曲,KTV,经典,翻唱,吉他,钢琴,器乐,榜单,00后
        'cat': query!['cat'] ?? '全部',
        'limit': query['limit'] ?? 50,
        // 歌单updateTime
        'lasttime': query['before'] ?? 0,
        'total': true
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 新歌速递
Handler top_song = (query, cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/v1/discovery/new/songs',
      {
        'areaId': query!['type'] ?? 0, // 全部:0 华语:7 欧美:96 日本:8 韩国:16
        'total': true
      },
      crypto: Crypto.weapi,
      cookies: cookie);
};

// 歌手榜
Handler toplist_artist = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/toplist/artist',
      {'type': 1, 'limit': 100, 'offset': 0, 'total': true},
      crypto: Crypto.weapi, cookies: cookie);
};

// 所有榜单内容摘要
Handler toplist_detail = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/toplist/detail', {},
      crypto: Crypto.weapi, cookies: cookie);
};

// 所有榜单介绍
Handler toplist = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/toplist', {},
      crypto: Crypto.linuxapi, cookies: cookie);
};
