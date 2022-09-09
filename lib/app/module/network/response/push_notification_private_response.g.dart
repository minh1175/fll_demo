// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_private_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationPrivateResponse _$PushNotificationPrivateResponseFromJson(
        Map<String, dynamic> json) =>
    PushNotificationPrivateResponse(
      push_type:
          (json['push_type'] as List<dynamic>?)?.map((e) => e as int).toList(),
      message: json['message'] as String?,
      socket_id: json['socket_id'] as int?,
      status: json['status'] as int?,
      is_private: json['is_private'] as bool?,
      type: json['type'] as int?,
      image_url: json['image_url'] as String?,
      image_size_rate: (json['image_size_rate'] as num?)?.toDouble(),
      post_time: json['post_time'] as String?,
      post_unix_time: json['post_unix_time'] as int?,
      player_id: json['player_id'] as int?,
      player_unique_id: json['player_unique_id'] as String?,
      player_name: json['player_name'] as String?,
      player_thumb_url: json['player_thumb_url'] as String?,
      tournament_private_chat_id: json['tournament_private_chat_id'] as int?,
      tournament_id: json['tournament_id'] as int?,
      tournament_round_id: json['tournament_round_id'] as int?,
      user_id: json['user_id'] as int?,
      flg_organizer_call: json['flg_organizer_call'] as int?,
    )..current_unix_time = json['current_unix_time'] as int?;

Map<String, dynamic> _$PushNotificationPrivateResponseToJson(
        PushNotificationPrivateResponse instance) =>
    <String, dynamic>{
      'push_type': instance.push_type,
      'message': instance.message,
      'socket_id': instance.socket_id,
      'status': instance.status,
      'is_private': instance.is_private,
      'type': instance.type,
      'image_url': instance.image_url,
      'image_size_rate': instance.image_size_rate,
      'post_time': instance.post_time,
      'post_unix_time': instance.post_unix_time,
      'current_unix_time': instance.current_unix_time,
      'player_id': instance.player_id,
      'player_unique_id': instance.player_unique_id,
      'player_name': instance.player_name,
      'player_thumb_url': instance.player_thumb_url,
      'tournament_private_chat_id': instance.tournament_private_chat_id,
      'tournament_id': instance.tournament_id,
      'tournament_round_id': instance.tournament_round_id,
      'user_id': instance.user_id,
      'flg_organizer_call': instance.flg_organizer_call,
    };
