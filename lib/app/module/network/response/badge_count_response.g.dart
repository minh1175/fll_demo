// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeCountResponse _$BadgeCountResponseFromJson(Map<String, dynamic> json) =>
    BadgeCountResponse(
      json['flg_chat_badge_on'] as int?,
      json['flg_private_chat_badge_on'] as int?,
      json['chat_badge_count'] as int?,
      json['private_chat_badge_count'] as int?,
      json['flg_other_badge_on'] as int?,
      json['other_badge_count'] as int?,
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$BadgeCountResponseToJson(BadgeCountResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'flg_chat_badge_on': instance.flg_chat_badge_on,
      'flg_private_chat_badge_on': instance.flg_private_chat_badge_on,
      'chat_badge_count': instance.chat_badge_count,
      'private_chat_badge_count': instance.private_chat_badge_count,
      'flg_other_badge_on': instance.flg_other_badge_on,
      'other_badge_count': instance.other_badge_count,
    };
