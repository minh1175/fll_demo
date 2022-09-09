// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_score_input_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkScoreInputResponse _$BulkScoreInputResponseFromJson(
        Map<String, dynamic> json) =>
    BulkScoreInputResponse(
      (json['score_list'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$BulkScoreInputResponseToJson(
        BulkScoreInputResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'score_list': instance.score_list,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['round_box_no'] as int,
      json['player_thumb_left'] as String,
      json['player_thumb_right'] as String,
      json['player_name_left'] as String,
      json['player_name_right'] as String,
      json['player_id_left'] as int,
      json['player_id_right'] as int,
      json['score_left'] as int?,
      json['score_right'] as int?,
      json['pk_score_left'] as int?,
      json['pk_score_right'] as int?,
      json['win_lose_type_left'] as String,
      json['win_lose_type_right'] as String,
      json['win_certification_url'] as String?,
      json['is_check_item'] as bool? ?? true,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'round_box_no': instance.round_box_no,
      'player_thumb_left': instance.player_thumb_left,
      'player_thumb_right': instance.player_thumb_right,
      'player_name_left': instance.player_name_left,
      'player_name_right': instance.player_name_right,
      'player_id_left': instance.player_id_left,
      'player_id_right': instance.player_id_right,
      'score_left': instance.score_left,
      'score_right': instance.score_right,
      'pk_score_left': instance.pk_score_left,
      'pk_score_right': instance.pk_score_right,
      'win_lose_type_left': instance.win_lose_type_left,
      'win_lose_type_right': instance.win_lose_type_right,
      'win_certification_url': instance.win_certification_url,
      'is_check_item': instance.is_check_item,
    };
