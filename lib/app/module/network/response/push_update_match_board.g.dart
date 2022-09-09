// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_update_match_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushUpdateMatchBoard _$PushUpdateMatchBoardFromJson(
        Map<String, dynamic> json) =>
    PushUpdateMatchBoard(
      push_type:
          (json['push_type'] as List<dynamic>?)?.map((e) => e as int).toList(),
      message: json['message'] as String?,
      socket_id: json['socket_id'] as int?,
      status: json['status'] as int?,
      tournament_id: json['tournament_id'] as int?,
    );

Map<String, dynamic> _$PushUpdateMatchBoardToJson(
        PushUpdateMatchBoard instance) =>
    <String, dynamic>{
      'push_type': instance.push_type,
      'message': instance.message,
      'socket_id': instance.socket_id,
      'status': instance.status,
      'tournament_id': instance.tournament_id,
    };
