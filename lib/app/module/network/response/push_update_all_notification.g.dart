// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_update_all_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushUpdateAllNotification _$PushUpdateAllNotificationFromJson(
        Map<String, dynamic> json) =>
    PushUpdateAllNotification(
      type: json['type'] as int?,
      flg_badge_update: json['flg_badge_update'] as int?,
    )
      ..push_type =
          (json['push_type'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..message = json['message'] as String?
      ..socket_id = json['socket_id'] as int?
      ..status = json['status'] as int?;

Map<String, dynamic> _$PushUpdateAllNotificationToJson(
        PushUpdateAllNotification instance) =>
    <String, dynamic>{
      'push_type': instance.push_type,
      'message': instance.message,
      'socket_id': instance.socket_id,
      'status': instance.status,
      'type': instance.type,
      'flg_badge_update': instance.flg_badge_update,
    };
