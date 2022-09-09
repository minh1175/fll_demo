// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announce_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnounceListResponse _$AnnounceListResponseFromJson(
        Map<String, dynamic> json) =>
    AnnounceListResponse(
      json['current_unix_time'] as int?,
      (json['list'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$AnnounceListResponseToJson(
        AnnounceListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'current_unix_time': instance.current_unix_time,
      'list': instance.list,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['icon_text'] as String,
      json['user_name'] as String,
      json['thumb_url'] as String,
      json['message'] as String,
      json['image_url'] as String,
      json['notice_unix_time'] as int,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'icon_text': instance.icon_text,
      'user_name': instance.user_name,
      'thumb_url': instance.thumb_url,
      'message': instance.message,
      'image_url': instance.image_url,
      'notice_unix_time': instance.notice_unix_time,
    };
