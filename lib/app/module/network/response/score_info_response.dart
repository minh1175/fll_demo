import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'score_info_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ScoreInfoResponse extends BaseResponse {
  int? round_box_no;
  int? game_type;
  String? battle_type;
  String? battle_type_text;
  bool? is_all_round_finish;
  @JsonKey(defaultValue: [])
  List<ScoreItem>? score_list;
  String? score_title;
  String? option_score_title;
  String? option_score_explain;
  String? score_history_url;
  int? flg_swiss_round_decision;

  ScoreInfoResponse({
    required bool success,
    required String error_message,
    this.round_box_no,
    this.game_type,
    this.battle_type,
    this.battle_type_text,
    this.is_all_round_finish,
    this.score_list,
    this.score_title,
    this.option_score_title,
    this.option_score_explain,
    this.score_history_url,
    this.flg_swiss_round_decision,
  }) : super(success: success, error_message: error_message);

  factory ScoreInfoResponse.fromJson(Map<String, dynamic> json) => _$ScoreInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreInfoResponseToJson(this);
}

@JsonSerializable()
class ScoreItem {
  int? battle_no;
  String? explain;
  String? winner_thumb_url;
  int? flg_enable;
  int? player_id_left;
  int? player_id_right;
  String? player_name_left;
  String? player_name_right;
  String? player_thumb_left;
  String? player_thumb_right;
  int? score_left;
  int? score_right;
  int? pk_score_left;
  int? pk_score_right;
  String? win_lose_type_left;
  String? win_lose_type_right;
  String? win_certification_url;

  ScoreItem(
      this.battle_no,
      this.explain,
      this.winner_thumb_url,
      this.flg_enable,
      this.player_id_left,
      this.player_id_right,
      this.player_name_left,
      this.player_name_right,
      this.player_thumb_left,
      this.player_thumb_right,
      this.score_left,
      this.score_right,
      this.pk_score_left,
      this.pk_score_right,
      this.win_lose_type_left,
      this.win_lose_type_right,
      this.win_certification_url);

  factory ScoreItem.fromJson(Map<String, dynamic> json) => _$ScoreItemFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreItemToJson(this);
}
