// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'already_read_msg_socket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlreadyReadMessageSocketResponse _$AlreadyReadMessageSocketResponseFromJson(
        Map<String, dynamic> json) =>
    AlreadyReadMessageSocketResponse(
      push_type:
          (json['push_type'] as List<dynamic>?)?.map((e) => e as int).toList(),
      message: json['message'] as String?,
      socket_id: json['socket_id'] as int?,
      status: json['status'] as int?,
      user_id: json['user_id'] as int?,
      thumbnail: json['thumbnail'] as String?,
      tournament_id: json['tournament_id'] as int?,
      already_read_chat_id: json['already_read_chat_id'] as int?,
      tournament_round_id: json['tournament_round_id'] as int?,
      already_read_private_chat_id:
          json['already_read_private_chat_id'] as int?,
    );

Map<String, dynamic> _$AlreadyReadMessageSocketResponseToJson(
        AlreadyReadMessageSocketResponse instance) =>
    <String, dynamic>{
      'push_type': instance.push_type,
      'message': instance.message,
      'socket_id': instance.socket_id,
      'status': instance.status,
      'user_id': instance.user_id,
      'thumbnail': instance.thumbnail,
      'tournament_id': instance.tournament_id,
      'already_read_chat_id': instance.already_read_chat_id,
      'tournament_round_id': instance.tournament_round_id,
      'already_read_private_chat_id': instance.already_read_private_chat_id,
    };
