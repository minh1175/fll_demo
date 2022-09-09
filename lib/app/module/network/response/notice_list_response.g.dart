// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeListResponse _$NoticeListResponseFromJson(Map<String, dynamic> json) =>
    NoticeListResponse(
      json['flg_badge_on'] as int?,
      json['badge_count'] as int?,
      json['current_unix_time'] as int?,
      (json['list'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$NoticeListResponseToJson(NoticeListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'flg_badge_on': instance.flg_badge_on,
      'badge_count': instance.badge_count,
      'current_unix_time': instance.current_unix_time,
      'list': instance.list,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['tournament_round_id'] as int?,
      json['notice_type'] as int?,
      json['title'] as String?,
      json['message'] as String?,
      json['thumb_url'] as String?,
      json['flg_unread'] as int?,
      json['notice_unix_time'] as int?,
      json['notice_time'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'tournament_round_id': instance.tournament_round_id,
      'notice_type': instance.notice_type,
      'title': instance.title,
      'message': instance.message,
      'thumb_url': instance.thumb_url,
      'flg_unread': instance.flg_unread,
      'notice_unix_time': instance.notice_unix_time,
      'notice_time': instance.notice_time,
    };
