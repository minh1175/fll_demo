// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_finish_half_way_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentFinishHalfWayResponse _$TournamentFinishHalfWayResponseFromJson(
        Map<String, dynamic> json) =>
    TournamentFinishHalfWayResponse(
      json['is_complete'] as bool,
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$TournamentFinishHalfWayResponseToJson(
        TournamentFinishHalfWayResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'is_complete': instance.is_complete,
    };
