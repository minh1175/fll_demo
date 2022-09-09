// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_teamcode_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTeamCodeResponse _$GetTeamCodeResponseFromJson(Map<String, dynamic> json) =>
    GetTeamCodeResponse(
      json['team_code'] as String?,
      json['message'] as String?,
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$GetTeamCodeResponseToJson(
        GetTeamCodeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'team_code': instance.team_code,
      'message': instance.message,
    };
