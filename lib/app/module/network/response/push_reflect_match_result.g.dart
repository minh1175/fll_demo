// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_reflect_match_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushReflectMatchResult _$PushReflectMatchResultFromJson(
        Map<String, dynamic> json) =>
    PushReflectMatchResult(
      push_type:
          (json['push_type'] as List<dynamic>?)?.map((e) => e as int).toList(),
      message: json['message'] as String?,
      socket_id: json['socket_id'] as int?,
      status: json['status'] as int?,
      tournament_id: json['tournament_id'] as int?,
      round_box_no: json['round_box_no'] as int?,
    );

Map<String, dynamic> _$PushReflectMatchResultToJson(
        PushReflectMatchResult instance) =>
    <String, dynamic>{
      'push_type': instance.push_type,
      'message': instance.message,
      'socket_id': instance.socket_id,
      'status': instance.status,
      'tournament_id': instance.tournament_id,
      'round_box_no': instance.round_box_no,
    };
