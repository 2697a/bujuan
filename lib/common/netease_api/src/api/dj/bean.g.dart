// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dj _$DjFromJson(Map<String, dynamic> json) {
  return Dj()
    ..id = dynamicToString(json['id'])
    ..nickName = json['nickName'] as String?
    ..avatarUrl = json['avatarUrl'] as String?
    ..userType = json['userType'] as int?
    ..rank = json['rank'] as int?
    ..lastRank = json['lastRank'] as int?
    ..score = json['score'] as int?;
}

Map<String, dynamic> _$DjToJson(Dj instance) => <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'avatarUrl': instance.avatarUrl,
      'userType': instance.userType,
      'rank': instance.rank,
      'lastRank': instance.lastRank,
      'score': instance.score,
    };

DjRadio _$DjRadioFromJson(Map<String, dynamic> json) {
  return DjRadio()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String
    ..dj = json['dj'] == null
        ? null
        : NeteaseAccountProfile.fromJson(json['dj'] as Map<String, dynamic>)
    ..picUrl = json['picUrl'] as String
    ..desc = json['desc'] as String?
    ..subCount = json['subCount'] as int
    ..commentCount = json['commentCount'] as int?
    ..programCount = json['programCount'] as int
    ..shareCount = json['shareCount'] as int?
    ..likedCount = json['likedCount'] as int?
    ..createTime = json['createTime'] as int?
    ..categoryId = json['categoryId'] as int?
    ..category = json['category'] as String?
    ..radioFeeType = json['radioFeeType'] as int
    ..feeScope = json['feeScope'] as int
    ..buyed = json['buyed'] as bool?
    ..finished = json['finished'] as bool?
    ..underShelf = json['underShelf'] as bool?
    ..purchaseCount = json['purchaseCount'] as int?
    ..price = json['price'] as int?
    ..originalPrice = json['originalPrice'] as int?
    ..lastProgramCreateTime = json['lastProgramCreateTime'] as int?
    ..lastProgramName = json['lastProgramName'] as String?
    ..lastProgramId = json['lastProgramId'] as int?
    ..composeVideo = json['composeVideo'] as bool?
    ..alg = json['alg'] as String?;
}

Map<String, dynamic> _$DjRadioToJson(DjRadio instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dj': instance.dj,
      'picUrl': instance.picUrl,
      'desc': instance.desc,
      'subCount': instance.subCount,
      'commentCount': instance.commentCount,
      'programCount': instance.programCount,
      'shareCount': instance.shareCount,
      'likedCount': instance.likedCount,
      'createTime': instance.createTime,
      'categoryId': instance.categoryId,
      'category': instance.category,
      'radioFeeType': instance.radioFeeType,
      'feeScope': instance.feeScope,
      'buyed': instance.buyed,
      'finished': instance.finished,
      'underShelf': instance.underShelf,
      'purchaseCount': instance.purchaseCount,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'lastProgramCreateTime': instance.lastProgramCreateTime,
      'lastProgramName': instance.lastProgramName,
      'lastProgramId': instance.lastProgramId,
      'composeVideo': instance.composeVideo,
      'alg': instance.alg,
    };

DjProgram _$DjProgramFromJson(Map<String, dynamic> json) {
  return DjProgram()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..programDesc = json['programDesc'] as String?
    ..coverUrl = json['coverUrl'] as String?
    ..blurCoverUrl = json['blurCoverUrl'] as String?
    ..description = json['description'] as String?
    ..alg = json['alg'] as String?
    ..commentThreadId = json['commentThreadId'] as String?
    ..mainTrackId = json['mainTrackId'] as int?
    ..pubStatus = json['pubStatus'] as int?
    ..bdAuditStatus = json['bdAuditStatus'] as int
    ..serialNum = json['serialNum'] as int?
    ..duration = json['duration'] as int?
    ..auditStatus = json['auditStatus'] as int?
    ..score = json['score'] as int?
    ..createTime = json['createTime'] as int?
    ..feeScope = json['feeScope'] as int?
    ..listenerCount = json['listenerCount'] as int?
    ..subscribedCount = json['subscribedCount'] as int?
    ..programFeeType = json['programFeeType'] as int?
    ..trackCount = json['trackCount'] as int?
    ..smallLanguageAuditStatus = json['smallLanguageAuditStatus'] as int?
    ..shareCount = json['shareCount'] as int?
    ..likedCount = json['likedCount'] as int?
    ..commentCount = json['commentCount'] as int?
    ..buyed = json['buyed'] as bool?
    ..isPublish = json['isPublish'] as bool
    ..subscribed = json['subscribed'] as bool?
    ..canReward = json['canReward'] as bool?
    ..reward = json['reward'] as bool?
    ..radio = DjRadio.fromJson(json['radio'] as Map<String, dynamic>)
    ..mainSong = Song.fromJson(json['mainSong'] as Map<String, dynamic>)
    ..dj = NeteaseAccountProfile.fromJson(json['dj'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DjProgramToJson(DjProgram instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'programDesc': instance.programDesc,
      'coverUrl': instance.coverUrl,
      'blurCoverUrl': instance.blurCoverUrl,
      'description': instance.description,
      'alg': instance.alg,
      'commentThreadId': instance.commentThreadId,
      'mainTrackId': instance.mainTrackId,
      'pubStatus': instance.pubStatus,
      'bdAuditStatus': instance.bdAuditStatus,
      'serialNum': instance.serialNum,
      'duration': instance.duration,
      'auditStatus': instance.auditStatus,
      'score': instance.score,
      'createTime': instance.createTime,
      'feeScope': instance.feeScope,
      'listenerCount': instance.listenerCount,
      'subscribedCount': instance.subscribedCount,
      'programFeeType': instance.programFeeType,
      'trackCount': instance.trackCount,
      'smallLanguageAuditStatus': instance.smallLanguageAuditStatus,
      'shareCount': instance.shareCount,
      'likedCount': instance.likedCount,
      'commentCount': instance.commentCount,
      'buyed': instance.buyed,
      'isPublish': instance.isPublish,
      'subscribed': instance.subscribed,
      'canReward': instance.canReward,
      'reward': instance.reward,
      'radio': instance.radio,
      'mainSong': instance.mainSong,
      'dj': instance.dj,
    };

DjRadioCategory _$DjRadioCategoryFromJson(Map<String, dynamic> json) {
  return DjRadioCategory()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String
    ..picMacUrl = json['picMacUrl'] as String
    ..picWebUrl = json['picWebUrl'] as String
    ..picUWPUrl = json['picUWPUrl'] as String
    ..picIPadUrl = json['picIPadUrl'] as String
    ..picPCBlackUrl = json['picPCBlackUrl'] as String
    ..picPCWhiteUrl = json['picPCWhiteUrl'] as String
    ..pic56x56Url = json['pic56x56Url'] as String
    ..pic84x84IdUrl = json['pic84x84IdUrl'] as String
    ..pic96x96Url = json['pic96x96Url'] as String;
}

Map<String, dynamic> _$DjRadioCategoryToJson(DjRadioCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picMacUrl': instance.picMacUrl,
      'picWebUrl': instance.picWebUrl,
      'picUWPUrl': instance.picUWPUrl,
      'picIPadUrl': instance.picIPadUrl,
      'picPCBlackUrl': instance.picPCBlackUrl,
      'picPCWhiteUrl': instance.picPCWhiteUrl,
      'pic56x56Url': instance.pic56x56Url,
      'pic84x84IdUrl': instance.pic84x84IdUrl,
      'pic96x96Url': instance.pic96x96Url,
    };

DjRadioCategory2 _$DjRadioCategory2FromJson(Map<String, dynamic> json) {
  return DjRadioCategory2()
    ..categoryId = dynamicToString(json['categoryId'])
    ..categoryName = json['categoryName'] as String
    ..radios = (json['radios'] as List<dynamic>)
        .map((e) => DjRadio.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DjRadioCategory2ToJson(DjRadioCategory2 instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'radios': instance.radios,
    };

DjRadioCategoryWrap _$DjRadioCategoryWrapFromJson(Map<String, dynamic> json) {
  return DjRadioCategoryWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..categories = (json['categories'] as List<dynamic>)
        .map((e) => DjRadioCategory.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DjRadioCategoryWrapToJson(
        DjRadioCategoryWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'categories': instance.categories,
    };

DjRadioCategoryWrap2 _$DjRadioCategoryWrap2FromJson(Map<String, dynamic> json) {
  return DjRadioCategoryWrap2()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = (json['data'] as List<dynamic>)
        .map((e) => DjRadioCategory2.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DjRadioCategoryWrap2ToJson(
        DjRadioCategoryWrap2 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

DjRadioCategoryWrap3 _$DjRadioCategoryWrap3FromJson(Map<String, dynamic> json) {
  return DjRadioCategoryWrap3()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = (json['data'] as List<dynamic>)
        .map((e) => DjRadioCategory.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DjRadioCategoryWrap3ToJson(
        DjRadioCategoryWrap3 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

DjRadioListWrap _$DjRadioListWrapFromJson(Map<String, dynamic> json) {
  return DjRadioListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..djRadios = (json['djRadios'] as List<dynamic>)
        .map((e) => DjRadio.fromJson(e as Map<String, dynamic>))
        .toList()
    ..name = json['name'] as String?
    ..subCount = json['subCount'] as int?;
}

Map<String, dynamic> _$DjRadioListWrapToJson(DjRadioListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'djRadios': instance.djRadios,
      'name': instance.name,
      'subCount': instance.subCount,
    };

DjRadioListWrap2 _$DjRadioListWrap2FromJson(Map<String, dynamic> json) {
  return DjRadioListWrap2()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = (json['data'] as List<dynamic>)
        .map((e) => DjRadio.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DjRadioListWrap2ToJson(DjRadioListWrap2 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

DjTopListListWrap _$DjTopListListWrapFromJson(Map<String, dynamic> json) {
  return DjTopListListWrap()
    ..list = (json['list'] as List<dynamic>)
        .map((e) => Dj.fromJson(e as Map<String, dynamic>))
        .toList()
    ..total = json['total'] as int?
    ..updateTime = json['updateTime'] as int?;
}

Map<String, dynamic> _$DjTopListListWrapToJson(DjTopListListWrap instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'updateTime': instance.updateTime,
    };

DjTopListListWrapX _$DjTopListListWrapXFromJson(Map<String, dynamic> json) {
  return DjTopListListWrapX()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = DjTopListListWrap.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DjTopListListWrapXToJson(DjTopListListWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

DjRadioTopListItem _$DjRadioTopListItemFromJson(Map<String, dynamic> json) {
  return DjRadioTopListItem()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..picUrl = json['picUrl'] as String?
    ..creatorName = json['creatorName'] as String?
    ..rank = json['rank'] as int?
    ..lastRank = json['lastRank'] as int?
    ..score = json['score'] as int?
    ..rcmdText = json['rcmdText'] as String?
    ..radioFeeType = json['radioFeeType'] as int?
    ..feeScope = json['feeScope'] as int?
    ..programCount = json['programCount'] as int?
    ..originalPrice = json['originalPrice'] as int?
    ..alg = json['alg'] as String?
    ..lastProgramName = json['lastProgramName'] as String?;
}

Map<String, dynamic> _$DjRadioTopListItemToJson(DjRadioTopListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'creatorName': instance.creatorName,
      'rank': instance.rank,
      'lastRank': instance.lastRank,
      'score': instance.score,
      'rcmdText': instance.rcmdText,
      'radioFeeType': instance.radioFeeType,
      'feeScope': instance.feeScope,
      'programCount': instance.programCount,
      'originalPrice': instance.originalPrice,
      'alg': instance.alg,
      'lastProgramName': instance.lastProgramName,
    };

DjRadioTopListListWrap _$DjRadioTopListListWrapFromJson(
    Map<String, dynamic> json) {
  return DjRadioTopListListWrap()
    ..list = (json['list'] as List<dynamic>)
        .map((e) => DjRadioTopListItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..total = json['total'] as int?
    ..updateTime = json['updateTime'] as int?;
}

Map<String, dynamic> _$DjRadioTopListListWrapToJson(
        DjRadioTopListListWrap instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'updateTime': instance.updateTime,
    };

DjRadioTopListListWrapX _$DjRadioTopListListWrapXFromJson(
    Map<String, dynamic> json) {
  return DjRadioTopListListWrapX()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data =
        DjRadioTopListListWrap.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DjRadioTopListListWrapXToJson(
        DjRadioTopListListWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

DjRadioDetail _$DjRadioDetailFromJson(Map<String, dynamic> json) {
  return DjRadioDetail()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data = DjRadio.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DjRadioDetailToJson(DjRadioDetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

DjRadioTopListListWrapX2 _$DjRadioTopListListWrapX2FromJson(
    Map<String, dynamic> json) {
  return DjRadioTopListListWrapX2()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..toplist = (json['toplist'] as List<dynamic>)
        .map((e) => DjRadio.fromJson(e as Map<String, dynamic>))
        .toList()
    ..updateTime = json['updateTime'] as int?;
}

Map<String, dynamic> _$DjRadioTopListListWrapX2ToJson(
        DjRadioTopListListWrapX2 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'toplist': instance.toplist,
      'updateTime': instance.updateTime,
    };

DjProgramListWrap _$DjProgramListWrapFromJson(Map<String, dynamic> json) {
  return DjProgramListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..programs = (json['programs'] as List<dynamic>)
        .map((e) => DjProgram.fromJson(e as Map<String, dynamic>))
        .toList()
    ..name = json['name'] as String?;
}

Map<String, dynamic> _$DjProgramListWrapToJson(DjProgramListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'programs': instance.programs,
      'name': instance.name,
    };

DjProgramTopListItem _$DjProgramTopListItemFromJson(Map<String, dynamic> json) {
  return DjProgramTopListItem()
    ..program = DjProgram.fromJson(json['program'] as Map<String, dynamic>)
    ..rank = json['rank'] as int?
    ..lastRank = json['lastRank'] as int?
    ..score = json['score'] as int?
    ..programFeeType = json['programFeeType'] as int?;
}

Map<String, dynamic> _$DjProgramTopListItemToJson(
        DjProgramTopListItem instance) =>
    <String, dynamic>{
      'program': instance.program,
      'rank': instance.rank,
      'lastRank': instance.lastRank,
      'score': instance.score,
      'programFeeType': instance.programFeeType,
    };

DjProgramTopListListWrap2 _$DjProgramTopListListWrap2FromJson(
    Map<String, dynamic> json) {
  return DjProgramTopListListWrap2()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..toplist = (json['toplist'] as List<dynamic>)
        .map((e) => DjProgramTopListItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..updateTime = json['updateTime'] as int?;
}

Map<String, dynamic> _$DjProgramTopListListWrap2ToJson(
        DjProgramTopListListWrap2 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'toplist': instance.toplist,
      'updateTime': instance.updateTime,
    };

PersonalizedDjProgramItem _$PersonalizedDjProgramItemFromJson(
    Map<String, dynamic> json) {
  return PersonalizedDjProgramItem()
    ..id = dynamicToString(json['id'])
    ..name = json['name'] as String?
    ..copywriter = json['copywriter'] as String?
    ..picUrl = json['picUrl'] as String?
    ..canDislike = json['canDislike'] as bool?
    ..type = json['type'] as int?
    ..program = DjProgram.fromJson(json['program'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PersonalizedDjProgramItemToJson(
        PersonalizedDjProgramItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'copywriter': instance.copywriter,
      'picUrl': instance.picUrl,
      'canDislike': instance.canDislike,
      'type': instance.type,
      'program': instance.program,
    };

DjProgramTopListListWrap _$DjProgramTopListListWrapFromJson(
    Map<String, dynamic> json) {
  return DjProgramTopListListWrap()
    ..list = (json['list'] as List<dynamic>)
        .map((e) => DjProgramTopListItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..total = json['total'] as int?
    ..updateTime = json['updateTime'] as int?;
}

Map<String, dynamic> _$DjProgramTopListListWrapToJson(
        DjProgramTopListListWrap instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'updateTime': instance.updateTime,
    };

DjProgramTopListListWrapX _$DjProgramTopListListWrapXFromJson(
    Map<String, dynamic> json) {
  return DjProgramTopListListWrapX()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..data =
        DjProgramTopListListWrap.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DjProgramTopListListWrapXToJson(
        DjProgramTopListListWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

PersonalizedDjProgramListWrap _$PersonalizedDjProgramListWrapFromJson(
    Map<String, dynamic> json) {
  return PersonalizedDjProgramListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..category = json['category'] as int?
    ..result = (json['result'] as List<dynamic>)
        .map((e) =>
            PersonalizedDjProgramItem.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$PersonalizedDjProgramListWrapToJson(
        PersonalizedDjProgramListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'category': instance.category,
      'result': instance.result,
    };

DjProgramDetail _$DjProgramDetailFromJson(Map<String, dynamic> json) {
  return DjProgramDetail()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..program = DjProgram.fromJson(json['program'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DjProgramDetailToJson(DjProgramDetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'program': instance.program,
    };
