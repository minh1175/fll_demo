// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_organizer_league_score_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkOrganizerLeagueScoreResponse _$BulkOrganizerLeagueScoreResponseFromJson(
        Map<String, dynamic> json) =>
    BulkOrganizerLeagueScoreResponse(
      json['is_all_round_finish'] as bool?,
      json['flg_badge_on'] as int?,
      json['badge_count'] as int?,
      json['flg_swiss_round_decision'] as int?,
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$BulkOrganizerLeagueScoreResponseToJson(
        BulkOrganizerLeagueScoreResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'is_all_round_finish': instance.is_all_round_finish,
      'flg_badge_on': instance.flg_badge_on,
      'badge_count': instance.badge_count,
      'flg_swiss_round_decision': instance.flg_swiss_round_decision,
    };
