// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentThread _$CommentThreadFromJson(Map<String, dynamic> json) {
  return CommentThread()
    ..id = dynamicToString(json['id'])
    ..resourceType = json['resourceType'] as int?
    ..commentCount = json['commentCount'] as int?
    ..likedCount = json['likedCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..hotCount = json['hotCount'] as int?
    ..resourceId = json['resourceId'] as int?
    ..resourceOwnerId = json['resourceOwnerId'] as int?
    ..resourceTitle = json['resourceTitle'] as String?;
}

Map<String, dynamic> _$CommentThreadToJson(CommentThread instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resourceType': instance.resourceType,
      'commentCount': instance.commentCount,
      'likedCount': instance.likedCount,
      'shareCount': instance.shareCount,
      'hotCount': instance.hotCount,
      'resourceId': instance.resourceId,
      'resourceOwnerId': instance.resourceOwnerId,
      'resourceTitle': instance.resourceTitle,
    };

EventItemInfo _$EventItemInfoFromJson(Map<String, dynamic> json) {
  return EventItemInfo()
    ..threadId = json['threadId'] as String
    ..resourceId = json['resourceId'] as int?
    ..resourceType = json['resourceType'] as int?
    ..liked = json['liked'] as bool?
    ..commentCount = json['commentCount'] as int?
    ..likedCount = json['likedCount'] as int?
    ..shareCount = json['shareCount'] as int?
    ..commentThread =
        CommentThread.fromJson(json['commentThread'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventItemInfoToJson(EventItemInfo instance) =>
    <String, dynamic>{
      'threadId': instance.threadId,
      'resourceId': instance.resourceId,
      'resourceType': instance.resourceType,
      'liked': instance.liked,
      'commentCount': instance.commentCount,
      'likedCount': instance.likedCount,
      'shareCount': instance.shareCount,
      'commentThread': instance.commentThread,
    };

EventItem _$EventItemFromJson(Map<String, dynamic> json) {
  return EventItem()
    ..id = dynamicToString(json['id'])
    ..actName = json['actName'] as String?
    ..json = json['json'] as String?
    ..type = json['type'] as int?
    ..actId = json['actId'] as int?
    ..eventTime = json['eventTime'] as int?
    ..expireTime = json['expireTime'] as int?
    ..showTime = json['showTime'] as int?
    ..forwardCount = json['forwardCount'] as int?
    ..sic = json['sic'] as int?
    ..insiteForwardCount = json['insiteForwardCount'] as int
    ..topEvent = json['topEvent'] as bool?
    ..user =
        NeteaseAccountProfile.fromJson(json['user'] as Map<String, dynamic>)
    ..info = EventItemInfo.fromJson(json['info'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventItemToJson(EventItem instance) => <String, dynamic>{
      'id': instance.id,
      'actName': instance.actName,
      'json': instance.json,
      'type': instance.type,
      'actId': instance.actId,
      'eventTime': instance.eventTime,
      'expireTime': instance.expireTime,
      'showTime': instance.showTime,
      'forwardCount': instance.forwardCount,
      'sic': instance.sic,
      'insiteForwardCount': instance.insiteForwardCount,
      'topEvent': instance.topEvent,
      'user': instance.user,
      'info': instance.info,
    };

EventListWrap _$EventListWrapFromJson(Map<String, dynamic> json) {
  return EventListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..events = (json['events'] as List<dynamic>?)
        ?.map((e) => EventItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..lasttime = json['lasttime'] as int?;
}

Map<String, dynamic> _$EventListWrapToJson(EventListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'events': instance.events,
      'lasttime': instance.lasttime,
    };

EventListWrap2 _$EventListWrap2FromJson(Map<String, dynamic> json) {
  return EventListWrap2()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..event = (json['event'] as List<dynamic>?)
        ?.map((e) => EventItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..lasttime = json['lasttime'] as int?;
}

Map<String, dynamic> _$EventListWrap2ToJson(EventListWrap2 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'event': instance.event,
      'lasttime': instance.lasttime,
    };

EventSingleWrap _$EventSingleWrapFromJson(Map<String, dynamic> json) {
  return EventSingleWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..event = EventItem.fromJson(json['event'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventSingleWrapToJson(EventSingleWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'event': instance.event,
    };

CommentItemBase _$CommentItemBaseFromJson(Map<String, dynamic> json) {
  return CommentItemBase()
    ..commentId = dynamicToString(json['commentId'])
    ..parentCommentId = dynamicToString(json['parentCommentId'])
    ..user = NeteaseUserInfo.fromJson(json['user'] as Map<String, dynamic>)
    ..beReplied = (json['beReplied'] as List<dynamic>?)
        ?.map((e) => BeRepliedCommentItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..content = json['content'] as String?
    ..time = json['time'] as int?
    ..timeStr = json['timeStr'] as String?
    ..likedCount = json['likedCount'] as int?
    ..replyCount = json['replyCount'] as int?
    ..liked = json['liked'] as bool?
    ..status = json['status'] as int?
    ..commentLocationType = json['commentLocationType'] as int?;
}

Map<String, dynamic> _$CommentItemBaseToJson(CommentItemBase instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'parentCommentId': instance.parentCommentId,
      'user': instance.user,
      'beReplied': instance.beReplied,
      'content': instance.content,
      'time': instance.time,
      'timeStr': instance.timeStr,
      'likedCount': instance.likedCount,
      'replyCount': instance.replyCount,
      'liked': instance.liked,
      'status': instance.status,
      'commentLocationType': instance.commentLocationType,
    };

CommentItem _$CommentItemFromJson(Map<String, dynamic> json) {
  return CommentItem()
    ..commentId = dynamicToString(json['commentId'])
    ..parentCommentId = dynamicToString(json['parentCommentId'])
    ..user = NeteaseUserInfo.fromJson(json['user'] as Map<String, dynamic>)
    ..content = json['content'] as String?
    ..time = json['time'] as int?
    ..likedCount = json['likedCount'] as int?
    ..replyCount = json['replyCount'] as int?
    ..liked = json['liked'] as bool?
    ..status = json['status'] as int?
    ..commentLocationType = json['commentLocationType'] as int?
    ..beReplied = (json['beReplied'] as List<dynamic>?)
        ?.map((e) => BeRepliedCommentItem.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CommentItemToJson(CommentItem instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'parentCommentId': instance.parentCommentId,
      'user': instance.user,
      'content': instance.content,
      'time': instance.time,
      'likedCount': instance.likedCount,
      'replyCount': instance.replyCount,
      'liked': instance.liked,
      'status': instance.status,
      'commentLocationType': instance.commentLocationType,
      'beReplied': instance.beReplied,
    };

BeRepliedCommentItem _$BeRepliedCommentItemFromJson(Map<String, dynamic> json) {
  return BeRepliedCommentItem()
    ..commentId = dynamicToString(json['commentId'])
    ..parentCommentId = dynamicToString(json['parentCommentId'])
    ..user = NeteaseUserInfo.fromJson(json['user'] as Map<String, dynamic>)
    ..beReplied = (json['beReplied'] as List<dynamic>?)
        ?.map((e) => BeRepliedCommentItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..content = json['content'] as String?
    ..time = json['time'] as int?
    ..likedCount = json['likedCount'] as int?
    ..liked = json['liked'] as bool?
    ..status = json['status'] as int?
    ..commentLocationType = json['commentLocationType'] as int?
    ..beRepliedCommentId = dynamicToString(json['beRepliedCommentId']);
}

Map<String, dynamic> _$BeRepliedCommentItemToJson(
        BeRepliedCommentItem instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'parentCommentId': instance.parentCommentId,
      'user': instance.user,
      'beReplied': instance.beReplied,
      'content': instance.content,
      'time': instance.time,
      'likedCount': instance.likedCount,
      'liked': instance.liked,
      'status': instance.status,
      'commentLocationType': instance.commentLocationType,
      'beRepliedCommentId': instance.beRepliedCommentId,
    };

CommentListWrap _$CommentListWrapFromJson(Map<String, dynamic> json) {
  return CommentListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..moreHot = json['moreHot'] as bool?
    ..cnum = json['cnum'] as int?
    ..isMusician = json['isMusician'] as bool?
    ..userId = dynamicToString(json['userId'])
    ..topComments = (json['topComments'] as List<dynamic>?)
        ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..hotComments = (json['hotComments'] as List<dynamic>?)
        ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..comments = (json['comments'] as List<dynamic>?)
        ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CommentListWrapToJson(CommentListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'moreHot': instance.moreHot,
      'cnum': instance.cnum,
      'isMusician': instance.isMusician,
      'userId': instance.userId,
      'topComments': instance.topComments,
      'hotComments': instance.hotComments,
      'comments': instance.comments,
    };

CommentHistoryData _$CommentHistoryDataFromJson(Map<String, dynamic> json) {
  return CommentHistoryData()
    ..hasMore = json['hasMore'] as bool?
    ..reminder = json['reminder'] as bool?
    ..commentCount = json['commentCount'] as int?
    ..hotComments = (json['hotComments'] as List<dynamic>?)
        ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..comments = (json['comments'] as List<dynamic>?)
        ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CommentHistoryDataToJson(CommentHistoryData instance) =>
    <String, dynamic>{
      'hasMore': instance.hasMore,
      'reminder': instance.reminder,
      'commentCount': instance.commentCount,
      'hotComments': instance.hotComments,
      'comments': instance.comments,
    };

CommentHistoryWrap _$CommentHistoryWrapFromJson(Map<String, dynamic> json) {
  return CommentHistoryWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = CommentHistoryData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommentHistoryWrapToJson(CommentHistoryWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

CommentList2DataSortType _$CommentList2DataSortTypeFromJson(
    Map<String, dynamic> json) {
  return CommentList2DataSortType()
    ..sortType = json['sortType'] as int?
    ..sortTypeName = json['sortTypeName'] as String?
    ..target = json['target'] as String?;
}

Map<String, dynamic> _$CommentList2DataSortTypeToJson(
        CommentList2DataSortType instance) =>
    <String, dynamic>{
      'sortType': instance.sortType,
      'sortTypeName': instance.sortTypeName,
      'target': instance.target,
    };

CommentList2Data _$CommentList2DataFromJson(Map<String, dynamic> json) {
  return CommentList2Data()
    ..hasMore = json['hasMore'] as bool?
    ..cursor = json['cursor'] as String?
    ..totalCount = json['totalCount'] as int?
    ..sortType = json['sortType'] as int?
    ..sortTypeList = (json['sortTypeList'] as List<dynamic>?)
        ?.map(
            (e) => CommentList2DataSortType.fromJson(e as Map<String, dynamic>))
        .toList()
    ..comments = (json['comments'] as List<dynamic>?)
        ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..currentComment = json['currentComment'] == null
        ? null
        : CommentItem.fromJson(json['currentComment'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommentList2DataToJson(CommentList2Data instance) =>
    <String, dynamic>{
      'hasMore': instance.hasMore,
      'cursor': instance.cursor,
      'totalCount': instance.totalCount,
      'sortType': instance.sortType,
      'sortTypeList': instance.sortTypeList,
      'comments': instance.comments,
      'currentComment': instance.currentComment,
    };

CommentList2Wrap _$CommentList2WrapFromJson(Map<String, dynamic> json) {
  return CommentList2Wrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = CommentList2Data.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommentList2WrapToJson(CommentList2Wrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

HugComment _$HugCommentFromJson(Map<String, dynamic> json) {
  return HugComment()
    ..user = NeteaseUserInfo.fromJson(json['user'] as Map<String, dynamic>)
    ..hugContent = json['hugContent'] as String?;
}

Map<String, dynamic> _$HugCommentToJson(HugComment instance) =>
    <String, dynamic>{
      'user': instance.user,
      'hugContent': instance.hugContent,
    };

HugCommentListData _$HugCommentListDataFromJson(Map<String, dynamic> json) {
  return HugCommentListData()
    ..hasMore = json['hasMore'] as bool?
    ..cursor = json['cursor'] as String?
    ..idCursor = json['idCursor'] as int?
    ..hugTotalCounts = json['hugTotalCounts'] as int?
    ..hugComments = (json['hugComments'] as List<dynamic>?)
        ?.map((e) => HugComment.fromJson(e as Map<String, dynamic>))
        .toList()
    ..currentComment =
        CommentItem.fromJson(json['currentComment'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HugCommentListDataToJson(HugCommentListData instance) =>
    <String, dynamic>{
      'hasMore': instance.hasMore,
      'cursor': instance.cursor,
      'idCursor': instance.idCursor,
      'hugTotalCounts': instance.hugTotalCounts,
      'hugComments': instance.hugComments,
      'currentComment': instance.currentComment,
    };

HugCommentListWrap _$HugCommentListWrapFromJson(Map<String, dynamic> json) {
  return HugCommentListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = HugCommentListData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HugCommentListWrapToJson(HugCommentListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

FloorCommentDetail _$FloorCommentDetailFromJson(Map<String, dynamic> json) {
  return FloorCommentDetail()
    ..comments = (json['comments'] as List<dynamic>?)
        ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..hasMore = json['hasMore'] as bool?
    ..totalCount = json['totalCount'] as int?
    ..time = json['time'] as int?
    ..ownerComment =
        CommentItem.fromJson(json['ownerComment'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FloorCommentDetailToJson(FloorCommentDetail instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'hasMore': instance.hasMore,
      'totalCount': instance.totalCount,
      'time': instance.time,
      'ownerComment': instance.ownerComment,
    };

FloorCommentDetailWrap _$FloorCommentDetailWrapFromJson(
    Map<String, dynamic> json) {
  return FloorCommentDetailWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = FloorCommentDetail.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FloorCommentDetailWrapToJson(
        FloorCommentDetailWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

EventForwardRet _$EventForwardRetFromJson(Map<String, dynamic> json) {
  return EventForwardRet()
    ..msg = json['msg'] as String?
    ..eventId = json['eventId'] as int
    ..eventTime = json['eventTime'] as int?;
}

Map<String, dynamic> _$EventForwardRetToJson(EventForwardRet instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'eventId': instance.eventId,
      'eventTime': instance.eventTime,
    };

EventForwardRetWrap _$EventForwardRetWrapFromJson(Map<String, dynamic> json) {
  return EventForwardRetWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = json['data'] == null
        ? null
        : EventForwardRet.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventForwardRetWrapToJson(
        EventForwardRetWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

TopicContent _$TopicContentFromJson(Map<String, dynamic> json) {
  return TopicContent()
    ..id = dynamicToString(json['id'])
    ..type = json['type'] as int?
    ..content = json['content'] as String?;
}

Map<String, dynamic> _$TopicContentToJson(TopicContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'content': instance.content,
    };

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic()
    ..id = dynamicToString(json['id'])
    ..userId = dynamicToString(json['userId'])
    ..content = (json['content'] as List<dynamic>?)
        ?.map((e) => TopicContent.fromJson(e as Map<String, dynamic>))
        .toList()
    ..title = json['title'] as String?
    ..wxTitle = json['wxTitle'] as String?
    ..mainTitle = json['mainTitle'] as String?
    ..startText = json['startText'] as String?
    ..summary = json['summary'] as String?
    ..adInfo = json['adInfo'] as String
    ..recomdTitle = json['recomdTitle'] as String?
    ..recomdContent = json['recomdContent'] as String?
    ..addTime = json['addTime'] as int
    ..pubTime = json['pubTime'] as int?
    ..updateTime = json['updateTime'] as int?
    ..cover = json['cover'] as int?
    ..headPic = json['headPic'] as int?
    ..status = json['status'] as int?
    ..seriesId = json['seriesId'] as int?
    ..categoryId = json['categoryId'] as int?
    ..hotScore = (json['hotScore'] as num?)?.toDouble()
    ..auditor = json['auditor'] as String?
    ..auditTime = json['auditTime'] as int?
    ..auditStatus = json['auditStatus'] as int?
    ..delReason = json['delReason'] as String?
    ..number = json['number'] as int?
    ..readCount = json['readCount'] as int?
    ..rectanglePic = json['rectanglePic'] as int?
    ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..reward = json['reward'] as bool?
    ..fromBackend = json['fromBackend'] as bool?
    ..showRelated = json['showRelated'] as bool?
    ..showComment = json['showComment'] as bool?
    ..pubImmidiatly = json['pubImmidiatly'] as bool?;
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'content': instance.content,
      'title': instance.title,
      'wxTitle': instance.wxTitle,
      'mainTitle': instance.mainTitle,
      'startText': instance.startText,
      'summary': instance.summary,
      'adInfo': instance.adInfo,
      'recomdTitle': instance.recomdTitle,
      'recomdContent': instance.recomdContent,
      'addTime': instance.addTime,
      'pubTime': instance.pubTime,
      'updateTime': instance.updateTime,
      'cover': instance.cover,
      'headPic': instance.headPic,
      'status': instance.status,
      'seriesId': instance.seriesId,
      'categoryId': instance.categoryId,
      'hotScore': instance.hotScore,
      'auditor': instance.auditor,
      'auditTime': instance.auditTime,
      'auditStatus': instance.auditStatus,
      'delReason': instance.delReason,
      'number': instance.number,
      'readCount': instance.readCount,
      'rectanglePic': instance.rectanglePic,
      'tags': instance.tags,
      'reward': instance.reward,
      'fromBackend': instance.fromBackend,
      'showRelated': instance.showRelated,
      'showComment': instance.showComment,
      'pubImmidiatly': instance.pubImmidiatly,
    };

TopicItem2 _$TopicItem2FromJson(Map<String, dynamic> json) {
  return TopicItem2()
    ..id = dynamicToString(json['id'])
    ..topic = Topic.fromJson(json['topic'] as Map<String, dynamic>)
    ..creator =
        NeteaseUserInfo.fromJson(json['creator'] as Map<String, dynamic>)
    ..number = json['number'] as int?
    ..shareCount = json['shareCount'] as int?
    ..commentCount = json['commentCount'] as int?
    ..likedCount = json['likedCount'] as int?
    ..readCount = json['readCount'] as int?
    ..rewardCount = json['rewardCount'] as int?
    ..rewardMoney = (json['rewardMoney'] as num?)?.toDouble()
    ..rectanglePicUrl = json['rectanglePicUrl'] as String?
    ..coverUrl = json['coverUrl'] as String?
    ..seriesId = json['seriesId'] as int?
    ..categoryId = json['categoryId'] as int?
    ..categoryName = json['categoryName'] as String?
    ..url = json['url'] as String?
    ..wxTitle = json['wxTitle'] as String?
    ..mainTitle = json['mainTitle'] as String?
    ..title = json['title'] as String?
    ..summary = json['summary'] as String?
    ..shareContent = json['shareContent'] as String?
    ..recmdTitle = json['recmdTitle'] as String?
    ..recmdContent = json['recmdContent'] as String?
    ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..addTime = json['addTime'] as int
    ..commentThreadId = json['commentThreadId'] as String?
    ..showRelated = json['showRelated'] as bool?
    ..showComment = json['showComment'] as bool?
    ..reward = json['reward'] as bool?
    ..liked = json['liked'] as bool?;
}

Map<String, dynamic> _$TopicItem2ToJson(TopicItem2 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'creator': instance.creator,
      'number': instance.number,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'likedCount': instance.likedCount,
      'readCount': instance.readCount,
      'rewardCount': instance.rewardCount,
      'rewardMoney': instance.rewardMoney,
      'rectanglePicUrl': instance.rectanglePicUrl,
      'coverUrl': instance.coverUrl,
      'seriesId': instance.seriesId,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'url': instance.url,
      'wxTitle': instance.wxTitle,
      'mainTitle': instance.mainTitle,
      'title': instance.title,
      'summary': instance.summary,
      'shareContent': instance.shareContent,
      'recmdTitle': instance.recmdTitle,
      'recmdContent': instance.recmdContent,
      'tags': instance.tags,
      'addTime': instance.addTime,
      'commentThreadId': instance.commentThreadId,
      'showRelated': instance.showRelated,
      'showComment': instance.showComment,
      'reward': instance.reward,
      'liked': instance.liked,
    };

TopicItem _$TopicItemFromJson(Map<String, dynamic> json) {
  return TopicItem()
    ..actId = dynamicToString(json['actId'])
    ..title = json['title'] as String?
    ..text = (json['text'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..reason = json['reason'] as String?
    ..participateCount = json['participateCount'] as int?
    ..isDefaultImg = json['isDefaultImg'] as bool
    ..alg = json['alg'] as String?
    ..startTime = json['startTime'] as int?
    ..endTime = json['endTime'] as int?
    ..resourceType = json['resourceType'] as int?
    ..videoType = json['videoType'] as int?
    ..topicType = json['topicType'] as int?
    ..meetingBeginTime = json['meetingBeginTime'] as int?
    ..meetingEndTime = json['meetingEndTime'] as int?
    ..coverPCLongUrl = json['coverPCLongUrl'] as String?
    ..sharePicUrl = json['sharePicUrl'] as String?
    ..coverPCUrl = json['coverPCUrl'] as String?
    ..coverMobileUrl = json['coverMobileUrl'] as String?
    ..coverPCListUrl = json['coverPCListUrl'] as String?;
}

Map<String, dynamic> _$TopicItemToJson(TopicItem instance) => <String, dynamic>{
      'actId': instance.actId,
      'title': instance.title,
      'text': instance.text,
      'reason': instance.reason,
      'participateCount': instance.participateCount,
      'isDefaultImg': instance.isDefaultImg,
      'alg': instance.alg,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'resourceType': instance.resourceType,
      'videoType': instance.videoType,
      'topicType': instance.topicType,
      'meetingBeginTime': instance.meetingBeginTime,
      'meetingEndTime': instance.meetingEndTime,
      'coverPCLongUrl': instance.coverPCLongUrl,
      'sharePicUrl': instance.sharePicUrl,
      'coverPCUrl': instance.coverPCUrl,
      'coverMobileUrl': instance.coverMobileUrl,
      'coverPCListUrl': instance.coverPCListUrl,
    };

TopicHotListWrap _$TopicHotListWrapFromJson(Map<String, dynamic> json) {
  return TopicHotListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..hot = (json['hot'] as List<dynamic>?)
        ?.map((e) => TopicItem.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$TopicHotListWrapToJson(TopicHotListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'hot': instance.hot,
    };

TopicDetailWrap _$TopicDetailWrapFromJson(Map<String, dynamic> json) {
  return TopicDetailWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..act = TopicItem.fromJson(json['act'] as Map<String, dynamic>)
    ..needBeginNotify = json['needBeginNotify'] as bool?;
}

Map<String, dynamic> _$TopicDetailWrapToJson(TopicDetailWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'act': instance.act,
      'needBeginNotify': instance.needBeginNotify,
    };

SimpleResourceInfo _$SimpleResourceInfoFromJson(Map<String, dynamic> json) {
  return SimpleResourceInfo()
    ..songId = dynamicToString(json['songId'])
    ..threadId = json['threadId'] as String?
    ..songCoverUrl = json['songCoverUrl'] as String?
    ..name = json['name'] as String?
    ..song = Song.fromJson(json['song'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SimpleResourceInfoToJson(SimpleResourceInfo instance) =>
    <String, dynamic>{
      'songId': instance.songId,
      'threadId': instance.threadId,
      'songCoverUrl': instance.songCoverUrl,
      'name': instance.name,
      'song': instance.song,
    };

HotwallCommentItem _$HotwallCommentItemFromJson(Map<String, dynamic> json) {
  return HotwallCommentItem()
    ..id = dynamicToString(json['id'])
    ..threadId = json['threadId'] as String?
    ..content = json['content'] as String?
    ..time = json['time'] as int?
    ..liked = json['liked'] as bool?
    ..likedCount = json['likedCount'] as int?
    ..replyCount = json['replyCount'] as int?
    ..simpleUserInfo = NeteaseSimpleUserInfo.fromJson(
        json['simpleUserInfo'] as Map<String, dynamic>)
    ..simpleResourceInfo = SimpleResourceInfo.fromJson(
        json['simpleResourceInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HotwallCommentItemToJson(HotwallCommentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'threadId': instance.threadId,
      'content': instance.content,
      'time': instance.time,
      'liked': instance.liked,
      'likedCount': instance.likedCount,
      'replyCount': instance.replyCount,
      'simpleUserInfo': instance.simpleUserInfo,
      'simpleResourceInfo': instance.simpleResourceInfo,
    };

HotwallCommentListWrap _$HotwallCommentListWrapFromJson(
    Map<String, dynamic> json) {
  return HotwallCommentListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = (json['data'] as List<dynamic>?)
        ?.map((e) => HotwallCommentItem.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$HotwallCommentListWrapToJson(
        HotwallCommentListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

CommentSimple _$CommentSimpleFromJson(Map<String, dynamic> json) {
  return CommentSimple()
    ..commentId = dynamicToString(json['commentId'])
    ..content = json['content'] as String?
    ..threadId = json['threadId'] as String?
    ..userId = dynamicToString(json['userId'])
    ..userName = json['userName'] as String?;
}

Map<String, dynamic> _$CommentSimpleToJson(CommentSimple instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'content': instance.content,
      'threadId': instance.threadId,
      'userId': instance.userId,
      'userName': instance.userName,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment()
    ..commentId = dynamicToString(json['commentId'])
    ..user = NeteaseUserInfo.fromJson(json['user'] as Map<String, dynamic>)
    ..beRepliedUser = json['beRepliedUser'] == null
        ? null
        : NeteaseUserInfo.fromJson(
            json['beRepliedUser'] as Map<String, dynamic>)
    ..expressionUrl = json['expressionUrl'] as String?
    ..commentLocationType = json['commentLocationType'] as int?
    ..time = json['time'] as int?
    ..content = json['content'] as String?;
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'commentId': instance.commentId,
      'user': instance.user,
      'beRepliedUser': instance.beRepliedUser,
      'expressionUrl': instance.expressionUrl,
      'commentLocationType': instance.commentLocationType,
      'time': instance.time,
      'content': instance.content,
    };

CommentWrap _$CommentWrapFromJson(Map<String, dynamic> json) {
  return CommentWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..comment = json['comment'] == null
        ? null
        : Comment.fromJson(json['comment'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommentWrapToJson(CommentWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'comment': instance.comment,
    };

MsgPromotion _$MsgPromotionFromJson(Map<String, dynamic> json) {
  return MsgPromotion()
    ..id = dynamicToString(json['id'])
    ..title = json['title'] as String?
    ..coverUrl = json['coverUrl'] as String?
    ..text = json['text'] as String?
    ..url = json['url'] as String?
    ..addTime = json['addTime'] as int;
}

Map<String, dynamic> _$MsgPromotionToJson(MsgPromotion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'coverUrl': instance.coverUrl,
      'text': instance.text,
      'url': instance.url,
      'addTime': instance.addTime,
    };

MsgGeneral _$MsgGeneralFromJson(Map<String, dynamic> json) {
  return MsgGeneral()
    ..title = json['title'] as String?
    ..subTitle = json['subTitle'] as String?
    ..tag = json['tag'] as String?
    ..subTag = json['subTag'] as String?
    ..noticeMsg = json['noticeMsg'] as String?
    ..inboxBriefContent = json['inboxBriefContent'] as String
    ..webUrl = json['webUrl'] as String?
    ..nativeUrl = json['nativeUrl'] as String?
    ..cover = json['cover'] as String?
    ..resName = json['resName'] as String?
    ..channel = json['channel'] as int?
    ..subType = json['subType'] as int?
    ..canPlay = json['canPlay'] as bool?;
}

Map<String, dynamic> _$MsgGeneralToJson(MsgGeneral instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'tag': instance.tag,
      'subTag': instance.subTag,
      'noticeMsg': instance.noticeMsg,
      'inboxBriefContent': instance.inboxBriefContent,
      'webUrl': instance.webUrl,
      'nativeUrl': instance.nativeUrl,
      'cover': instance.cover,
      'resName': instance.resName,
      'channel': instance.channel,
      'subType': instance.subType,
      'canPlay': instance.canPlay,
    };

MsgContent _$MsgContentFromJson(Map<String, dynamic> json) {
  return MsgContent()
    ..msg = json['msg'] as String?
    ..title = json['title'] as String?
    ..pushMsg = json['pushMsg'] as String?
    ..type = json['type'] as int?
    ..resType = json['resType'] as int?
    ..newPub = json['newPub'] as bool?
    ..promotionUrl = json['promotionUrl'] == null
        ? null
        : MsgPromotion.fromJson(json['promotionUrl'] as Map<String, dynamic>)
    ..generalMsg = json['generalMsg'] == null
        ? null
        : MsgGeneral.fromJson(json['generalMsg'] as Map<String, dynamic>)
    ..mv = json['mv'] == null
        ? null
        : Mv3.fromJson(json['mv'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MsgContentToJson(MsgContent instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'title': instance.title,
      'pushMsg': instance.pushMsg,
      'type': instance.type,
      'resType': instance.resType,
      'newPub': instance.newPub,
      'promotionUrl': instance.promotionUrl,
      'generalMsg': instance.generalMsg,
      'mv': instance.mv,
    };

Msg _$MsgFromJson(Map<String, dynamic> json) {
  return Msg()
    ..fromUser =
        NeteaseUserInfo.fromJson(json['fromUser'] as Map<String, dynamic>)
    ..toUser = NeteaseUserInfo.fromJson(json['toUser'] as Map<String, dynamic>)
    ..lastMsg = json['lastMsg'] as String?
    ..noticeAccountFlag = json['noticeAccountFlag'] as bool?
    ..lastMsgTime = json['lastMsgTime'] as int?
    ..newMsgCount = json['newMsgCount'] as int?;
}

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'fromUser': instance.fromUser,
      'toUser': instance.toUser,
      'lastMsg': instance.lastMsg,
      'noticeAccountFlag': instance.noticeAccountFlag,
      'lastMsgTime': instance.lastMsgTime,
      'newMsgCount': instance.newMsgCount,
    };

Msg2 _$Msg2FromJson(Map<String, dynamic> json) {
  return Msg2()
    ..id = dynamicToString(json['id'])
    ..fromUser =
        NeteaseUserInfo.fromJson(json['fromUser'] as Map<String, dynamic>)
    ..toUser = NeteaseUserInfo.fromJson(json['toUser'] as Map<String, dynamic>)
    ..msg = json['msg'] as String?
    ..time = json['time'] as int?
    ..batchId = json['batchId'] as int?;
}

Map<String, dynamic> _$Msg2ToJson(Msg2 instance) => <String, dynamic>{
      'id': instance.id,
      'fromUser': instance.fromUser,
      'toUser': instance.toUser,
      'msg': instance.msg,
      'time': instance.time,
      'batchId': instance.batchId,
    };

UsersMsgListWrap _$UsersMsgListWrapFromJson(Map<String, dynamic> json) {
  return UsersMsgListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..msgs = (json['msgs'] as List<dynamic>?)
        ?.map((e) => Msg.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UsersMsgListWrapToJson(UsersMsgListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'msgs': instance.msgs,
    };

RecentContactUsersData _$RecentContactUsersDataFromJson(
    Map<String, dynamic> json) {
  return RecentContactUsersData()
    ..follow = (json['follow'] as List<dynamic>?)
        ?.map((e) => NeteaseAccountProfile.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$RecentContactUsersDataToJson(
        RecentContactUsersData instance) =>
    <String, dynamic>{
      'follow': instance.follow,
    };

RecentContactUsersWrap _$RecentContactUsersWrapFromJson(
    Map<String, dynamic> json) {
  return RecentContactUsersWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data =
        RecentContactUsersData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RecentContactUsersWrapToJson(
        RecentContactUsersWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

UserMsgListWrap _$UserMsgListWrapFromJson(Map<String, dynamic> json) {
  return UserMsgListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..msgs = (json['msgs'] as List<dynamic>?)
        ?.map((e) => Msg2.fromJson(e as Map<String, dynamic>))
        .toList()
    ..isArtist = json['isArtist'] as bool
    ..isSubed = json['isSubed'] as bool
    ..more = json['more'] as bool?;
}

Map<String, dynamic> _$UserMsgListWrapToJson(UserMsgListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'msgs': instance.msgs,
      'isArtist': instance.isArtist,
      'isSubed': instance.isSubed,
      'more': instance.more,
    };

UserMsgListWrap2 _$UserMsgListWrap2FromJson(Map<String, dynamic> json) {
  return UserMsgListWrap2()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..id = dynamicToString(json['id'])
    ..newMsgs = (json['newMsgs'] as List<dynamic>?)
        ?.map((e) => Msg2.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserMsgListWrap2ToJson(UserMsgListWrap2 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'id': instance.id,
      'newMsgs': instance.newMsgs,
    };

Cover _$CoverFromJson(Map<String, dynamic> json) {
  return Cover()
    ..width = json['width'] as int?
    ..height = json['height'] as int?
    ..url = json['url'] as String?;
}

Map<String, dynamic> _$CoverToJson(Cover instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };

Talk _$TalkFromJson(Map<String, dynamic> json) {
  return Talk()
    ..talkId = dynamicToString(json['talkId'])
    ..talkName = json['talkName'] as String?
    ..talkDes = json['talkDes'] as String?
    ..shareCover = Cover.fromJson(json['shareCover'] as Map<String, dynamic>)
    ..showCover = Cover.fromJson(json['showCover'] as Map<String, dynamic>)
    ..status = json['status'] as int?
    ..mlogCount = json['mlogCount'] as int?
    ..follows = json['follows'] as int?
    ..participations = json['participations'] as int?
    ..showParticipations = json['showParticipations'] as int?
    ..isFollow = json['isFollow'] as bool
    ..alg = json['alg'] as String?;
}

Map<String, dynamic> _$TalkToJson(Talk instance) => <String, dynamic>{
      'talkId': instance.talkId,
      'talkName': instance.talkName,
      'talkDes': instance.talkDes,
      'shareCover': instance.shareCover,
      'showCover': instance.showCover,
      'status': instance.status,
      'mlogCount': instance.mlogCount,
      'follows': instance.follows,
      'participations': instance.participations,
      'showParticipations': instance.showParticipations,
      'isFollow': instance.isFollow,
      'alg': instance.alg,
    };

MyLogBaseData _$MyLogBaseDataFromJson(Map<String, dynamic> json) {
  return MyLogBaseData()
    ..id = dynamicToString(json['id'])
    ..pubTime = json['pubTime'] as int?
    ..type = json['type'] as int?
    ..coverUrl = json['coverUrl'] as String?
    ..coverWidth = json['coverWidth'] as int?
    ..coverHeight = json['coverHeight'] as int?
    ..coverColor = json['coverColor'] as int?
    ..talk = json['talk'] == null
        ? null
        : Talk.fromJson(json['talk'] as Map<String, dynamic>)
    ..text = json['text'] as String?;
}

Map<String, dynamic> _$MyLogBaseDataToJson(MyLogBaseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pubTime': instance.pubTime,
      'type': instance.type,
      'coverUrl': instance.coverUrl,
      'coverWidth': instance.coverWidth,
      'coverHeight': instance.coverHeight,
      'coverColor': instance.coverColor,
      'talk': instance.talk,
      'text': instance.text,
    };

MyLogResourceExt _$MyLogResourceExtFromJson(Map<String, dynamic> json) {
  return MyLogResourceExt()
    ..likedCount = json['likedCount'] as int?
    ..commentCount = json['commentCount'] as int?;
}

Map<String, dynamic> _$MyLogResourceExtToJson(MyLogResourceExt instance) =>
    <String, dynamic>{
      'likedCount': instance.likedCount,
      'commentCount': instance.commentCount,
    };

MyLogResource _$MyLogResourceFromJson(Map<String, dynamic> json) {
  return MyLogResource()
    ..mlogBaseData =
        MyLogBaseData.fromJson(json['mlogBaseData'] as Map<String, dynamic>)
    ..mlogExtVO =
        MyLogResourceExt.fromJson(json['mlogExtVO'] as Map<String, dynamic>)
    ..userProfile = json['userProfile'] == null
        ? null
        : NeteaseAccountProfile.fromJson(
            json['userProfile'] as Map<String, dynamic>)
    ..status = json['status'] as int?
    ..shareUrl = json['shareUrl'] as String?;
}

Map<String, dynamic> _$MyLogResourceToJson(MyLogResource instance) =>
    <String, dynamic>{
      'mlogBaseData': instance.mlogBaseData,
      'mlogExtVO': instance.mlogExtVO,
      'userProfile': instance.userProfile,
      'status': instance.status,
      'shareUrl': instance.shareUrl,
    };

MyLog _$MyLogFromJson(Map<String, dynamic> json) {
  return MyLog()
    ..id = dynamicToString(json['id'])
    ..type = json['type'] as int?
    ..resource =
        MyLogResource.fromJson(json['resource'] as Map<String, dynamic>)
    ..alg = json['alg'] as String?
    ..reason = json['reason'] as String?
    ..matchField = json['matchField'] as int?
    ..matchFieldContent = json['matchFieldContent'] as String?
    ..sameCity = json['sameCity'] as bool?;
}

Map<String, dynamic> _$MyLogToJson(MyLog instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'resource': instance.resource,
      'alg': instance.alg,
      'reason': instance.reason,
      'matchField': instance.matchField,
      'matchFieldContent': instance.matchFieldContent,
      'sameCity': instance.sameCity,
    };

MyLogMyLikeData _$MyLogMyLikeDataFromJson(Map<String, dynamic> json) {
  return MyLogMyLikeData()
    ..feeds = (json['feeds'] as List<dynamic>?)
        ?.map((e) => MyLogResource.fromJson(e as Map<String, dynamic>))
        .toList()
    ..time = json['time'] as int?
    ..more = json['more'] as bool?;
}

Map<String, dynamic> _$MyLogMyLikeDataToJson(MyLogMyLikeData instance) =>
    <String, dynamic>{
      'feeds': instance.feeds,
      'time': instance.time,
      'more': instance.more,
    };

MyLogMyLikeWrap _$MyLogMyLikeWrapFromJson(Map<String, dynamic> json) {
  return MyLogMyLikeWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = MyLogMyLikeData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MyLogMyLikeWrapToJson(MyLogMyLikeWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };
