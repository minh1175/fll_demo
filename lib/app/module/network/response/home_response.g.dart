// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      success: json['success'] as bool,
      error_message: json['error_message'] as String,
      game_thumb_list: (json['game_thumb_list'] as List<dynamic>?)
              ?.map((e) => ItemGame.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      web_url: json['web_url'] as String?,
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'game_thumb_list': instance.game_thumb_list,
      'web_url': instance.web_url,
    };

ItemGame _$ItemGameFromJson(Map<String, dynamic> json) => ItemGame(
      game_title_id: json['game_title_id'] as int?,
      thumb_url: json['thumb_url'] as String?,
    );

Map<String, dynamic> _$ItemGameToJson(ItemGame instance) => <String, dynamic>{
      'game_title_id': instance.game_title_id,
      'thumb_url': instance.thumb_url,
    };
