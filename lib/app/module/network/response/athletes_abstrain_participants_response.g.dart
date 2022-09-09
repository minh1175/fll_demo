// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'athletes_abstrain_participants_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AthletesAbstrainParticipantResponse
    _$AthletesAbstrainParticipantResponseFromJson(Map<String, dynamic> json) =>
        AthletesAbstrainParticipantResponse(
          json['explain'] as String?,
          json['is_all_round_finish'] as bool?,
          (json['player_list'] as List<dynamic>?)
                  ?.map((e) => ItemAthletes.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        )
          ..success = json['success'] as bool
          ..error_message = json['error_message'] as String;

Map<String, dynamic> _$AthletesAbstrainParticipantResponseToJson(
        AthletesAbstrainParticipantResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'explain': instance.explain,
      'is_all_round_finish': instance.is_all_round_finish,
      'player_list': instance.player_list,
    };

ItemAthletes _$ItemAthletesFromJson(Map<String, dynamic> json) => ItemAthletes(
      json['thumb_url'] as String?,
      json['player_name'] as String?,
      json['player_id'] as int?,
      json['flg_retire'] as int?,
    );

Map<String, dynamic> _$ItemAthletesToJson(ItemAthletes instance) =>
    <String, dynamic>{
      'thumb_url': instance.thumb_url,
      'player_name': instance.player_name,
      'player_id': instance.player_id,
      'flg_retire': instance.flg_retire,
    };
