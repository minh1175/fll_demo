// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationResponse _$PushNotificationResponseFromJson(
        Map<String, dynamic> json) =>
    PushNotificationResponse(
      push_type:
          (json['push_type'] as List<dynamic>?)?.map((e) => e as int).toList(),
      message: json['message'] as String?,
      socket_id: json['socket_id'] as int?,
      status: json['status'] as int?,
      is_private: json['is_private'] as bool?,
      organizer_unique_id: json['organizer_unique_id'] as String?,
      image_url: json['image_url'] as String?,
      player_thumb_url: json['player_thumb_url'] as String?,
      tournament_chat_id: json['tournament_chat_id'] as int?,
      type: json['type'] as int?,
      organizer_thumb_url: json['organizer_thumb_url'] as String?,
      post_time: json['post_time'] as String?,
      tournament_id: json['tournament_id'] as int?,
      post_unix_time: json['post_unix_time'] as int?,
      player_id: json['player_id'] as int? ?? 0,
      user_id: json['user_id'] as int? ?? 0,
      current_unix_time: json['current_unix_time'] as int?,
      image_size_rate: (json['image_size_rate'] as num?)?.toDouble(),
      player_unique_id: json['player_unique_id'] as String?,
      player_name: json['player_name'] as String?,
      organizer_name: json['organizer_name'] as String?,
      flg_announce: json['flg_announce'] as int?,
    );

Map<String, dynamic> _$PushNotificationResponseToJson(
        PushNotificationResponse instance) =>
    <String, dynamic>{
      'push_type': instance.push_type,
      'message': instance.message,
      'socket_id': instance.socket_id,
      'status': instance.status,
      'is_private': instance.is_private,
      'organizer_unique_id': instance.organizer_unique_id,
      'image_url': instance.image_url,
      'player_thumb_url': instance.player_thumb_url,
      'tournament_chat_id': instance.tournament_chat_id,
      'type': instance.type,
      'organizer_thumb_url': instance.organizer_thumb_url,
      'post_time': instance.post_time,
      'tournament_id': instance.tournament_id,
      'post_unix_time': instance.post_unix_time,
      'player_id': instance.player_id,
      'user_id': instance.user_id,
      'current_unix_time': instance.current_unix_time,
      'image_size_rate': instance.image_size_rate,
      'player_unique_id': instance.player_unique_id,
      'player_name': instance.player_name,
      'organizer_name': instance.organizer_name,
      'flg_announce': instance.flg_announce,
    };
