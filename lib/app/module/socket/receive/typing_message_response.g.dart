// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typing_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypingMessageResponse _$TypingMessageResponseFromJson(
        Map<String, dynamic> json) =>
    TypingMessageResponse(
      push_type:
          (json['push_type'] as List<dynamic>?)?.map((e) => e as int).toList(),
      message: json['message'] as String?,
      socket_id: json['socket_id'] as int?,
      status: json['status'] as int?,
      display_name: json['display_name'] as String?,
      display_thumbnail: json['display_thumbnail'] as String?,
      post_current_time: json['post_current_time'] as String?,
      tournament_id: json['tournament_id'] as String?,
      tournament_round_id: json['tournament_round_id'] as String?,
    );

Map<String, dynamic> _$TypingMessageResponseToJson(
        TypingMessageResponse instance) =>
    <String, dynamic>{
      'push_type': instance.push_type,
      'message': instance.message,
      'socket_id': instance.socket_id,
      'status': instance.status,
      'display_name': instance.display_name,
      'display_thumbnail': instance.display_thumbnail,
      'post_current_time': instance.post_current_time,
      'tournament_id': instance.tournament_id,
      'tournament_round_id': instance.tournament_round_id,
    };
