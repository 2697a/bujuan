// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerStatusBean _$ServerStatusBeanFromJson(Map<String, dynamic> json) {
  return ServerStatusBean()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?;
}

Map<String, dynamic> _$ServerStatusBeanToJson(ServerStatusBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
    };

ServerStatusListBean _$ServerStatusListBeanFromJson(Map<String, dynamic> json) {
  return ServerStatusListBean()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?;
}

Map<String, dynamic> _$ServerStatusListBeanToJson(
        ServerStatusListBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
    };
