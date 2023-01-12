import 'package:dio/dio.dart';
import '../../../src/api/bean.dart';
import '../../../src/api/event/bean.dart';
import '../../../src/dio_ext.dart';
import '../../../src/netease_handler.dart';

mixin ApiEvent {
  DioMetaData eventListDioMetaData(String userId,
      {int limit = 30, int lastTime = -1}) {
    var params = {'userId': userId, 'time': lastTime, 'limit': limit};
    return DioMetaData(joinUri('/weapi/event/get/$userId'),
        data: params, options: joinOptions());
  }

  /// 获取用户动态
  /// !需要登录
  /// [lastTime] 传入上一次返回结果的 lasttime,将会返回下一页的数据,默认-1
  Future<EventListWrap> eventList(String userId,
      {int limit = 30, int lastTime = -1}) {
    return Https.dioProxy
        .postUri(eventListDioMetaData(userId, limit: limit, lastTime: lastTime))
        .then((Response value) {
      return EventListWrap.fromJson(value.data);
    });
  }

  DioMetaData eventMyListDioMetaData({int limit = 30, int lastTime = -1}) {
    var params = {'lasttime': lastTime, 'pagesize': limit};
    return DioMetaData(joinUri('/weapi/v1/event/get'),
        data: params, options: joinOptions());
  }

  /// 获取自己动态 对应网页版网易云，朋友界面里的各种动态消息 ，如分享的视频，音乐，照片等！
  /// !需要登录
  /// [lastTime] 传入上一次返回结果的 lasttime,将会返回下一页的数据,默认-1
  Future<EventListWrap2> eventMyList({int limit = 30, int lastTime = -1}) {
    return Https.dioProxy
        .postUri(eventMyListDioMetaData(limit: limit, lastTime: lastTime))
        .then((Response value) {
      return EventListWrap2.fromJson(value.data);
    });
  }

  DioMetaData eventForwardDioMetaData(String userId, String evId,
      {String forwards = ''}) {
    var params = {'eventUserId': userId, 'id': evId, 'forwards': forwards};
    return DioMetaData(joinUri('/weapi/event/forward'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 转发用户动态
  /// !需要登录
  /// [evId] 动态 id
  /// [forwards] 转发的评论
  Future<EventForwardRetWrap> eventForward(String userId, String evId,
      {String forwards = ''}) {
    return Https.dioProxy
        .postUri(eventForwardDioMetaData(userId, evId, forwards: forwards))
        .then((Response value) {
      return EventForwardRetWrap.fromJson(value.data);
    });
  }

  DioMetaData eventDeleteDioMetaData(String evId) {
    var params = {'id': evId};
    return DioMetaData(joinUri('/weapi/event/delete'),
        data: params, options: joinOptions());
  }

  /// 删除用户动态
  /// !需要登录
  /// [evId] 动态 id
  Future<ServerStatusBean> eventDelete(String evId) {
    return Https.dioProxy
        .postUri(eventDeleteDioMetaData(evId))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData shareResourceDioMetaData(String id,
      {String type = 'song', String msg = ''}) {
    var params = {'id': id, 'type': type, 'msg': msg};
    return DioMetaData(joinUri('/weapi/share/friends/resource'),
        data: params, options: joinOptions());
  }

  /// 分享歌曲、歌单、mv、电台、电台节目到动态
  /// !需要登录
  /// [id] 资源 id （歌曲，歌单，mv，电台，电台节目对应 id）
  /// [type] 资源类型，默认歌曲 song，可传 song,playlist,mv,djradio,djprogram
  /// [msg] 内容，140 字限制，支持 emoji，@用户名（/user/follows接口获取的用户名，用户名后和内容应该有空格），图片暂不支持
  Future<EventSingleWrap> shareResource(String id,
      {String type = 'song', String msg = ''}) {
    return Https.dioProxy
        .postUri(shareResourceDioMetaData(id, type: type, msg: msg))
        .then((Response value) {
      return EventSingleWrap.fromJson(value.data);
    });
  }

  DioMetaData eventCommentListDioMetaData(String threadId,
      {int offset = 0, int limit = 30, int beforeTime = 0}) {
    var params = {'limit': limit, 'offset': offset, 'beforeTime': beforeTime};
    return DioMetaData(joinUri('/weapi/v1/resource/comments/$threadId'),
        data: params, options: joinOptions());
  }

  /// 分享歌曲、歌单、mv、电台、电台节目到动态
  /// !需要登录
  /// [threadId] 资源 id （歌曲，歌单，mv，电台，电台节目对应 id）
  Future<CommentListWrap> eventCommentList(String threadId,
      {int offset = 0, int limit = 30, int beforeTime = 0}) {
    return Https.dioProxy
        .postUri(eventCommentListDioMetaData(threadId,
            offset: offset, limit: limit, beforeTime: beforeTime))
        .then((Response value) {
      return CommentListWrap.fromJson(value.data);
    });
  }

  DioMetaData topicHotListDioMetaData({int offset = 0, int limit = 20}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/act/hot'),
        data: params, options: joinOptions());
  }

  /// 获取热门话题
  Future<TopicHotListWrap> topicHotList({int offset = 0, int limit = 20}) {
    return Https.dioProxy
        .postUri(topicHotListDioMetaData(offset: offset, limit: limit))
        .then((Response value) {
      return TopicHotListWrap.fromJson(value.data);
    });
  }

  DioMetaData hotTopicDetailEventDioMetaData(String actid) {
    var params = {'actid': actid};
    return DioMetaData(joinUri('/api/act/event/hot'),
        data: params, options: joinOptions());
  }

  /// 获取话题详情热门动态
  Future<EventListWrap> hotTopicDetailEvent(String actid) {
    return Https.dioProxy
        .postUri(hotTopicDetailEventDioMetaData(actid))
        .then((Response value) {
      return EventListWrap.fromJson(value.data);
    });
  }

  DioMetaData topicDetailDioMetaData(String actid) {
    var params = {'actid': actid};
    return DioMetaData(joinUri('/api/act/detail'),
        data: params, options: joinOptions());
  }

  /// 获取话题详情
  Future<TopicDetailWrap> topicDetail(String actid) {
    return Https.dioProxy
        .postUri(topicDetailDioMetaData(actid))
        .then((Response value) {
      return TopicDetailWrap.fromJson(value.data);
    });
  }

  DioMetaData commentListDioMetaData(String id, String type,
      {int offset = 0, int limit = 20, int beforeTime = 0}) {
    String typeKey = type2key(type);
    var params = {
      'rid': id,
      'limit': limit,
      'offset': offset,
      'beforeTime': beforeTime
    };
    return DioMetaData(joinUri('/weapi/v1/resource/comments/$typeKey$id'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 评论
  /// [id] 资源id
  /// [type] 'song':歌曲 'mv':mv 'playlist':歌单 'album':专辑 'dj':电台 'video':视频
  Future<CommentListWrap> commentList(String id, String type,
      {int offset = 0, int limit = 20, int beforeTime = 0}) {
    return Https.dioProxy
        .postUri(commentListDioMetaData(id, type,
            offset: offset, limit: limit, beforeTime: beforeTime))
        .then((Response value) {
      return CommentListWrap.fromJson(value.data);
    });
  }

  DioMetaData commentListDioMetaData2(String id, String type,
      {int pageNo = 1,
      int pageSize = 20,
      bool showInner = true,
      int? sortType}) {
    String typeKey = type2key(type) + id;
    var params = {
      'threadId': typeKey,
      'pageNo': pageNo,
      'pageSize': pageSize,
      'showInner': showInner,
      'sortType': sortType
    };
    return DioMetaData(joinUri('/api/v2/resource/comments'),
        data: params,
        options: joinOptions(
            encryptType: EncryptType.EApi,
            eApiUrl: '/api/v2/resource/comments',
            cookies: {'os': 'pc'}));
  }

  /// 评论
  /// [id] 资源id
  /// [type] 'song':歌曲 'mv':mv 'playlist':歌单 'album':专辑 'dj':电台 'video':视频
  /// [sortType] 1:按推荐排序,2:按热度排序,3:按时间排序
  Future<CommentList2Wrap> commentList2(String id, String type,
      {int pageNo = 1,
      int pageSize = 20,
      bool showInner = true,
      int? sortType}) {
    return Https.dioProxy
        .postUri(commentListDioMetaData2(id, type,
            pageNo: pageNo,
            pageSize: pageSize,
            showInner: showInner,
            sortType: sortType))
        .then((Response value) {
      return CommentList2Wrap.fromJson(value.data);
    });
  }

  DioMetaData hotCommentListDioMetaData(String id, String type,
      {int offset = 0, int limit = 20, int beforeTime = 0}) {
    String typeKey = type2key(type);
    var params = {
      'rid': id,
      'limit': limit,
      'offset': offset,
      'beforeTime': beforeTime
    };
    return DioMetaData(joinUri('/weapi/v1/resource/hotcomments/$typeKey$id'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 热门评论
  /// [id] 资源id
  /// [type] 'song':歌曲 'mv':mv 'playlist':歌单 'album':专辑 'dj':电台 'video':视频
  Future<CommentListWrap> hotCommentList(String id, String type,
      {int offset = 0, int limit = 20, int beforeTime = 0}) {
    return Https.dioProxy
        .postUri(hotCommentListDioMetaData(id, type,
            offset: offset, limit: limit, beforeTime: beforeTime))
        .then((Response value) {
      return CommentListWrap.fromJson(value.data);
    });
  }

  DioMetaData hotwallCommentListDioMetaData() {
    return DioMetaData(joinUri('/api/comment/hotwall/list/get'),
        data: {}, options: joinOptions());
  }

  /// 获取云村热评
  Future<HotwallCommentListWrap> hotwallCommentList() {
    return Https.dioProxy
        .postUri(hotwallCommentListDioMetaData())
        .then((Response value) {
      return HotwallCommentListWrap.fromJson(value.data);
    });
  }

  DioMetaData userCommentsDioMetaData(String userId,
      {int beforeTime = -1, int limit = 30, bool total = true}) {
    var params = {
      'uid': userId,
      'limit': limit,
      'beforeTime': beforeTime,
      'total': total
    };
    return DioMetaData(joinUri('/api/v1/user/comments/$userId'),
        data: params, options: joinOptions());
  }

  /// 通知 - 评论
  /// !需要登录
  Future<CommentListWrap> userComments(String userId,
      {int beforeTime = -1, int limit = 30, bool total = true}) {
    return Https.dioProxy
        .postUri(userCommentsDioMetaData(userId,
            beforeTime: beforeTime, limit: limit, total: total))
        .then((Response value) {
      return CommentListWrap.fromJson(value.data);
    });
  }

  DioMetaData userCommentsHistoryDioMetaData(String userId,
      {int time = 0,
      int limit = 10,
      bool composeHotComment = true,
      bool composeReminder = true}) {
    var params = {
      'user_id': userId,
      'time': time,
      'limit': limit,
      'compose_hot_comment': composeHotComment,
      'compose_reminder': composeReminder
    };
    return DioMetaData(joinUri('/api/comment/user/comment/history'),
        data: params, options: joinOptions());
  }

  /// 通知 - 用户历史评论
  /// !需要登录
  Future<CommentHistoryWrap> userCommentsHistory(String userId,
      {int time = 0,
      int limit = 10,
      bool composeHotComment = true,
      bool composeReminder = true}) {
    return Https.dioProxy
        .postUri(userCommentsHistoryDioMetaData(userId,
            time: time,
            limit: limit,
            composeHotComment: composeHotComment,
            composeReminder: composeReminder))
        .then((Response value) {
      return CommentHistoryWrap.fromJson(value.data);
    });
  }

  DioMetaData floorCommentsDioMetaData(
      String id, String type, String parentCommentId,
      {int time = -1, int limit = 20}) {
    var params = {
      'parentCommentId': parentCommentId,
      'threadId': type2key(type) + id,
      'time': time,
      'limit': limit
    };
    return DioMetaData(joinUri('/api/resource/comment/floor/get'),
        data: params, options: joinOptions());
  }

  /// 楼层评论
  /// !需要登录
  Future<FloorCommentDetailWrap> floorComments(
      String id, String type, String parentCommentId,
      {int time = -1, int limit = 20}) {
    return Https.dioProxy
        .postUri(floorCommentsDioMetaData(id, type, parentCommentId,
            time: time, limit: limit))
        .then((Response value) {
      return FloorCommentDetailWrap.fromJson(value.data);
    });
  }

  DioMetaData forwardsDioMetaData(
      {int offset = 0, int limit = 30, bool total = true}) {
    var params = {'limit': limit, 'offset': offset, 'total': total};
    return DioMetaData(joinUri('/api/forwards/get'),
        data: params, options: joinOptions());
  }

  /// 通知 - @我
  /// !需要登录
  /// TODO 账号没有这类数据，补充数据结构  forwards
  Future<ServerStatusBean> forwards(
      {int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy
        .postUri(
            forwardsDioMetaData(offset: offset, limit: limit, total: total))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData likeCommentDioMetaData(
      String id, String commentId, String type, bool like,
      {String? threadId}) {
    String typeKey = type2key(type);
    var params = {'commentId': commentId, 'threadId': typeKey + id};
    if (type == 'event') {
      if (threadId == null) {
        return DioMetaData.error(
            ArgumentError('event type, threadId not null'));
      }
      params['threadId'] = threadId;
    }
    return DioMetaData(joinUri('/weapi/v1/comment/${like ? 'like' : 'unlike'}'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 评论点赞
  /// !需要登录
  /// [id] 资源id
  /// [commentId 评论id
  /// 注意： 动态点赞不需要传入 id 参数，需要传入动态的 threadId 参数,
  /// 如：/comment/like?type=6&cid=1419532712&threadId=A_EV_2_6559519868_32953014&t=0，
  /// threadId 可通过 /event，/user/event 接口获取
  Future<ServerStatusBean> likeComment(
      String id, String commentId, String type, bool like,
      {String? threadId}) {
    return Https.dioProxy
        .postUri(likeCommentDioMetaData(id, commentId, type, like,
            threadId: threadId))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData commentDioMetaData(String id, String type, String op,
      {String? commentId, String? threadId, String? content}) {
    String typeKey = type2key(type);
    var params = {'threadId': typeKey + id};
    if (type == 'event') {
      if (threadId == null) {
        return DioMetaData.error(
            ArgumentError('event type, threadId not null'));
      }
      params['threadId'] = threadId;
    }
    switch (op) {
      case 'add':
        if (content == null) {
          return DioMetaData.error(ArgumentError('add op, content not null'));
        }
        params['content'] = content;
        break;
      case 'delete':
        if (commentId == null) {
          return DioMetaData.error(
              ArgumentError('delete op, commentId not null'));
        }
        params['commentId'] = commentId;
        break;
      case 'reply':
        if (commentId == null) {
          return DioMetaData.error(
              ArgumentError('reply op, commentId not null'));
        }
        if (content == null) {
          return DioMetaData.error(ArgumentError('reply op, content not null'));
        }
        params['commentId'] = commentId;
        params['content'] = content;
        break;
    }
    return DioMetaData(joinUri('/weapi/resource/comments/$op'),
        data: params, options: joinOptions(cookies: {'os': 'android'}));
  }

  /// 发表/删除/回复评论
  /// [id] 资源id
  /// [op] 'add':发表  'delete':删除  'reply':回复
  /// 注意： 动态点赞不需要传入 id 参数，需要传入动态的 threadId 参数,
  /// 如：/comment/like?type=6&cid=1419532712&threadId=A_EV_2_6559519868_32953014&t=0，
  /// threadId 可通过 /event，/user/event 接口获取
  Future<CommentWrap> comment(String id, String type, String op,
      {String? commentId, String? threadId, String? content}) {
    return Https.dioProxy
        .postUri(commentDioMetaData(id, type, op,
            commentId: commentId, threadId: threadId, content: content))
        .then((Response value) {
      return CommentWrap.fromJson(value.data);
    });
  }

  DioMetaData likeResourceDioMetaData(String id, String type, bool like,
      {String? commentId, String? threadId, String? content}) {
    String typeKey = type2key(type);
    var params = {'threadId': typeKey + id};
    if (type == 'event') {
      if (threadId == null) {
        return DioMetaData.error(
            ArgumentError('event type, threadId not null'));
      }
      params['threadId'] = threadId;
    }
    return DioMetaData(joinUri('/weapi/resource/${like ? 'like' : 'unlike'}'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 点赞与取消点赞资源
  /// !需要登录
  /// [id] 资源id
  /// 注意： 动态点赞不需要传入 id 参数，需要传入动态的 threadId 参数,
  /// 如：/comment/like?type=6&cid=1419532712&threadId=A_EV_2_6559519868_32953014&t=0，
  /// threadId 可通过 /event，/user/event 接口获取
  Future<ServerStatusBean> likeResource(String id, String type, bool like,
      {String? commentId, String? threadId, String? content}) {
    return Https.dioProxy
        .postUri(likeResourceDioMetaData(id, type, like,
            commentId: commentId, threadId: threadId, content: content))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData hugCommentListDioMetaData(
    String id,
    String type,
    String userId,
    String commentId, {
    String cursor = '-1',
    int idCursor = -1,
    int pageNo = 1,
    int pageSize = 20,
  }) {
    String typeKey = type2key(type);
    var params = {
      'threadId': typeKey + id,
      'targetUserId': userId,
      'commentId': commentId,
      'cursor': cursor,
      'idCursor': idCursor,
      'pageNo': pageNo,
      'pageSize': pageSize
    };
    return DioMetaData(joinUri('/api/v2/resource/comments/hug/list'),
        data: params,
        options: joinOptions(cookies: {'os': 'ios', 'appver': '8.0.00'}));
  }

  /// 抱一抱 评论列表
  /// !需要登录
  /// [id] 资源id
  Future<HugCommentListWrap> hugCommentList(
    String id,
    String type,
    String userId,
    String commentId, {
    String cursor = '-1',
    int idCursor = -1,
    int pageNo = 1,
    int pageSize = 20,
  }) {
    return Https.dioProxy
        .postUri(hugCommentListDioMetaData(id, type, userId, commentId,
            cursor: cursor,
            idCursor: idCursor,
            pageNo: pageNo,
            pageSize: pageSize))
        .then((Response value) {
      return HugCommentListWrap.fromJson(value.data);
    });
  }

  DioMetaData hugCommentDioMetaData(
      String id, String type, String userId, String commentId) {
    String typeKey = type2key(type);
    var params = {
      'threadId': typeKey + id,
      'targetUserId': userId,
      'commentId': commentId,
    };
    return DioMetaData(joinUri('/api/v2/resource/comments/hug/listener'),
        data: params,
        options: joinOptions(cookies: {'os': 'ios', 'appver': '8.0.00'}));
  }

  /// 抱一抱 评论
  /// !需要登录
  /// [id] 资源id
  Future<ServerStatusBean> hugComment(
      String id, String type, String userId, String commentId) {
    return Https.dioProxy
        .postUri(hugCommentDioMetaData(id, type, userId, commentId))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  String type2key(String type) {
    String typeKey = 'R_SO_4_';
    switch (type) {
      case 'song':
        typeKey = 'R_SO_4_';
        break;
      case 'mv':
        typeKey = 'R_MV_5_';
        break;
      case 'playlist':
        typeKey = 'A_PL_0_';
        break;
      case 'album':
        typeKey = 'R_AL_3_';
        break;
      case 'dj':
        typeKey = 'A_DJ_1_';
        break;
      case 'video':
        typeKey = 'R_VI_62_';
        break;
      case 'event':
        typeKey = 'A_EV_2_';
        break;
    }
    return typeKey;
  }

  DioMetaData recentContactUsersDioMetaData() {
    var params = {};
    return DioMetaData(joinUri('/api/msg/recentcontact/get'),
        data: params, options: joinOptions());
  }

  /// 最近联系
  /// !需要登录
  Future<RecentContactUsersWrap> recentContactUsers() {
    return Https.dioProxy
        .postUri(recentContactUsersDioMetaData())
        .then((Response value) {
      return RecentContactUsersWrap.fromJson(value.data);
    });
  }

  DioMetaData privateMsgListUsersDioMetaData(
      {int offset = 0, int limit = 30, bool total = true}) {
    var params = {'limit': limit, 'offset': offset, 'total': total};
    return DioMetaData(joinUri('/api/msg/private/users'),
        data: params, options: joinOptions());
  }

  /// 私信会话列表
  /// !需要登录
  Future<UsersMsgListWrap> privateMsgListUsers(
      {int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy
        .postUri(privateMsgListUsersDioMetaData(
            offset: offset, limit: limit, total: total))
        .then((Response value) {
      return UsersMsgListWrap.fromJson(value.data);
    });
  }

  DioMetaData sendPrivateMsgDioMetaData(String msg, String userId,
      {String type = 'text', String playlist = ''}) {
    var params = {
      'userIds': '[$userId]',
      'id': playlist,
      'msg': msg,
      'type': type
    };
    return DioMetaData(joinUri('/weapi/msg/private/send'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 发送私信（返回与这个用户的历史信息）
  /// !需要登录
  Future<UserMsgListWrap2> sendPrivateMsg(String msg, String userId,
      {String type = 'text', String playlist = ''}) {
    return Https.dioProxy
        .postUri(sendPrivateMsgDioMetaData(msg, userId,
            type: type, playlist: playlist))
        .then((Response value) {
      return UserMsgListWrap2.fromJson(value.data);
    });
  }

  DioMetaData privateMsgListUserDioMetaData(String userId,
      {int offset = 0, int limit = 30, bool total = true}) {
    var params = {
      'userId': userId,
      'limit': limit,
      'offset': offset,
      'total': total
    };
    return DioMetaData(joinUri('/api/msg/private/history'),
        data: params, options: joinOptions());
  }

  /// 私信内容(与某个用户的私信)
  /// !需要登录
  Future<UserMsgListWrap> privateMsgListUser(String userId,
      {int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy
        .postUri(privateMsgListUserDioMetaData(userId,
            offset: offset, limit: limit, total: total))
        .then((Response value) {
      return UserMsgListWrap.fromJson(value.data);
    });
  }

  DioMetaData msgNoticesDioMetaData({int limit = 30, int lasttime = -1}) {
    var params = {'limit': limit, 'lasttime ': lasttime};
    return DioMetaData(joinUri('/api/msg/notices'),
        data: params, options: joinOptions());
  }

  /// 通知
  /// !需要登录
  /// TODO 账号没有这类数据，补充数据结构  notices
  Future<ServerStatusBean> msgNotices({int limit = 30, int lasttime = -1}) {
    return Https.dioProxy
        .postUri(msgNoticesDioMetaData(limit: limit, lasttime: lasttime))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }
}
