// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_read_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeReadResponse _$NoticeReadResponseFromJson(Map<String, dynamic> json) =>
    NoticeReadResponse(
      json['flg_badge_on'] as int?,
      json['badge_count'] as int?,
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$NoticeReadResponseToJson(NoticeReadResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'flg_badge_on': instance.flg_badge_on,
      'badge_count': instance.badge_count,
    };
