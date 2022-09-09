// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retire_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetirePlayerResponse _$RetirePlayerResponseFromJson(
        Map<String, dynamic> json) =>
    RetirePlayerResponse(
      success: json['success'] as bool,
      error_message: json['error_message'] as String,
      is_complete: json['is_complete'] as bool?,
      is_all_round_finish: json['is_all_round_finish'] as bool?,
    );

Map<String, dynamic> _$RetirePlayerResponseToJson(
        RetirePlayerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'is_complete': instance.is_complete,
      'is_all_round_finish': instance.is_all_round_finish,
    };
