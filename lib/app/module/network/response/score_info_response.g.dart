// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreInfoResponse _$ScoreInfoResponseFromJson(Map<String, dynamic> json) =>
    ScoreInfoResponse(
      success: json['success'] as bool,
      error_message: json['error_message'] as String,
      round_box_no: json['round_box_no'] as int?,
      game_type: json['game_type'] as int?,
      battle_type: json['battle_type'] as String?,
      battle_type_text: json['battle_type_text'] as String?,
      is_all_round_finish: json['is_all_round_finish'] as bool?,
      score_list: (json['score_list'] as List<dynamic>?)
              ?.map((e) => ScoreItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      score_title: json['score_title'] as String?,
      option_score_title: json['option_score_title'] as String?,
      option_score_explain: json['option_score_explain'] as String?,
      score_history_url: json['score_history_url'] as String?,
      flg_swiss_round_decision: json['flg_swiss_round_decision'] as int?,
    );

Map<String, dynamic> _$ScoreInfoResponseToJson(ScoreInfoResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'round_box_no': instance.round_box_no,
      'game_type': instance.game_type,
      'battle_type': instance.battle_type,
      'battle_type_text': instance.battle_type_text,
      'is_all_round_finish': instance.is_all_round_finish,
      'score_list': instance.score_list,
      'score_title': instance.score_title,
      'option_score_title': instance.option_score_title,
      'option_score_explain': instance.option_score_explain,
      'score_history_url': instance.score_history_url,
      'flg_swiss_round_decision': instance.flg_swiss_round_decision,
    };

ScoreItem _$ScoreItemFromJson(Map<String, dynamic> json) => ScoreItem(
      json['battle_no'] as int?,
      json['explain'] as String?,
      json['winner_thumb_url'] as String?,
      json['flg_enable'] as int?,
      json['player_id_left'] as int?,
      json['player_id_right'] as int?,
      json['player_name_left'] as String?,
      json['player_name_right'] as String?,
      json['player_thumb_left'] as String?,
      json['player_thumb_right'] as String?,
      json['score_left'] as int?,
      json['score_right'] as int?,
      json['pk_score_left'] as int?,
      json['pk_score_right'] as int?,
      json['win_lose_type_left'] as String?,
      json['win_lose_type_right'] as String?,
      json['win_certification_url'] as String?,
    );

Map<String, dynamic> _$ScoreItemToJson(ScoreItem instance) => <String, dynamic>{
      'battle_no': instance.battle_no,
      'explain': instance.explain,
      'winner_thumb_url': instance.winner_thumb_url,
      'flg_enable': instance.flg_enable,
      'player_id_left': instance.player_id_left,
      'player_id_right': instance.player_id_right,
      'player_name_left': instance.player_name_left,
      'player_name_right': instance.player_name_right,
      'player_thumb_left': instance.player_thumb_left,
      'player_thumb_right': instance.player_thumb_right,
      'score_left': instance.score_left,
      'score_right': instance.score_right,
      'pk_score_left': instance.pk_score_left,
      'pk_score_right': instance.pk_score_right,
      'win_lose_type_left': instance.win_lose_type_left,
      'win_lose_type_right': instance.win_lose_type_right,
      'win_certification_url': instance.win_certification_url,
    };
