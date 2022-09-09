// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerListResponse _$PlayerListResponseFromJson(Map<String, dynamic> json) =>
    PlayerListResponse(
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$PlayerListResponseToJson(PlayerListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'list': instance.list,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      json['user_id'] as int?,
      json['player_thumb_url'] as String?,
      json['player_name'] as String?,
      json['last_access_time'] as String?,
      json['player_web_url'] as String?,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'player_thumb_url': instance.player_thumb_url,
      'player_name': instance.player_name,
      'last_access_time': instance.last_access_time,
      'player_web_url': instance.player_web_url,
    };
