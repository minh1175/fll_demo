import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'start_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class StartResponse extends BaseResponse {
  String? app_token;
  int? user_id;
  int? login_type;
  int? player_id;
  String? player_name;
  String? thumb_url;
  @JsonKey(ignore: false)
  bool is_twitter_link;
  @JsonKey(ignore: false)
  bool is_update_info;
  int? live_bitrate;
  Setting? setting;
  BattleReport? battle_report;

  StartResponse({
    required bool success,
    required String error_message,
    this.app_token,
    this.user_id,
    this.login_type,
    this.player_id,
    this.player_name,
    this.thumb_url,
    required this.is_twitter_link,
    required this.is_update_info,
    this.live_bitrate,
    this.setting,
    this.battle_report,
  }): super(success: success, error_message: error_message);

  factory StartResponse.fromJson(Map<String, dynamic> json) =>
      _$StartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StartResponseToJson(this);
}

@JsonSerializable()
class Setting {
  int? flgNoFinishedPush;
  int? flgPlayerPushTwitterMension;
  int? flgPlayerPushOpponentDecision;
  int? flgPlayerPushPrivateChatComment;
  int? flgOrganizerPushCall;
  int? flgOrganizerPushPrivateChatComment;

  Setting({
    this.flgNoFinishedPush,
    this.flgPlayerPushTwitterMension,
    this.flgPlayerPushOpponentDecision,
    this.flgPlayerPushPrivateChatComment,
    this.flgOrganizerPushCall,
    this.flgOrganizerPushPrivateChatComment,
  });

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}

@JsonSerializable()
class BattleReport {
  bool? is_show;
  int? before_rate;
  int? after_rate;
  int? before_score;
  int? after_score;
  String? game_title;
  String? game_title_thumb;
  String? before_player_thumb_url;
  String? before_player_thumb_background_url;
  String? before_player_thumb_frame_url;
  String? after_player_thumb_url;
  String? after_player_thumb_background_url;
  String? after_player_thumb_frame_url;
  String? up_basic_prize_name;

  BattleReport({
    this.is_show,
    this.before_rate,
    this.after_rate,
    this.before_score,
    this.after_score,
    this.game_title,
    this.game_title_thumb,
    this.before_player_thumb_url,
    this.before_player_thumb_background_url,
    this.before_player_thumb_frame_url,
    this.after_player_thumb_url,
    this.after_player_thumb_background_url,
    this.after_player_thumb_frame_url,
    this.up_basic_prize_name
  });

  factory BattleReport.fromJson(Map<String, dynamic> json) =>
      _$BattleReportFromJson(json);

  Map<String, dynamic> toJson() => _$BattleReportToJson(this);
}
