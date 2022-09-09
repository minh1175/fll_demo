// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSettingResponse _$GetSettingResponseFromJson(Map<String, dynamic> json) =>
    GetSettingResponse(
      (json['list'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$GetSettingResponseToJson(GetSettingResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'list': instance.list,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['group'] as String?,
      (json['content'] as List<dynamic>?)
          ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'group': instance.group,
      'content': instance.content,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      json['title'] as String?,
      json['comment'] as String?,
      json['flg_on'] as int?,
      json['key'] as String?,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'title': instance.title,
      'comment': instance.comment,
      'flg_on': instance.flg_on,
      'key': instance.key,
    };
