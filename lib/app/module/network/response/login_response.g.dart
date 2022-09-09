// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool,
      error_message: json['error_message'] as String,
      is_new_regist: json['is_new_regist'] as bool? ?? false,
      user_id: json['user_id'] as int?,
      player_id: json['player_id'] as int?,
      player_name: json['player_name'] as String?,
      thumb_url: json['thumb_url'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'is_new_regist': instance.is_new_regist,
      'user_id': instance.user_id,
      'player_id': instance.player_id,
      'player_name': instance.player_name,
      'thumb_url': instance.thumb_url,
    };
