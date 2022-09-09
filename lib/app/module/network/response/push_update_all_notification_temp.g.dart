// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_update_all_notification_temp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushUpdateAllNotificationTemp _$PushUpdateAllNotificationTempFromJson(
        Map<String, dynamic> json) =>
    PushUpdateAllNotificationTemp(
      push_type:
          (json['push_type'] as List<dynamic>?)?.map((e) => e as int).toList(),
      message: json['message'] as String?,
      socket_id: json['socket_id'] as int?,
      status: json['status'] as int?,
      is_private: json['is_private'] as bool? ?? false,
      flg_announce: json['flg_announce'] as int? ?? 0,
      flg_organizer_call: json['flg_organizer_call'] as int? ?? 0,
    );

Map<String, dynamic> _$PushUpdateAllNotificationTempToJson(
        PushUpdateAllNotificationTemp instance) =>
    <String, dynamic>{
      'push_type': instance.push_type,
      'message': instance.message,
      'socket_id': instance.socket_id,
      'status': instance.status,
      'is_private': instance.is_private,
      'flg_announce': instance.flg_announce,
      'flg_organizer_call': instance.flg_organizer_call,
    };
