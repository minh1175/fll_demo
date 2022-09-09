import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tournament_info_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class TournamentInfoResponse extends BaseResponse {
  TournamentInfo? tournament_info;

  TournamentInfoResponse({
    required bool success,
    required String error_message,
    this.tournament_info,
  }) : super(success: success, error_message: error_message);

  factory TournamentInfoResponse.fromJson(Map<String, dynamic> json) => _$TournamentInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentInfoResponseToJson(this);
}

@JsonSerializable()
class TournamentInfo {
  int? flg_large_score;
  int? tournament_id;
  int? competition_type;
  String? competition_type_str;
  int? league_type;
  int? tournament_progress_status;
  int? tournament_progress_percent;
  String? tournament_name;
  String? match_type_str;
  String? tournament_type_str;
  String? tournament_thumb_url;
  String? tournament_result_url;
  String? organizer_name;
  String? organizer_twitter_id;
  String? organizer_thumb_url;
  String? organizer_web_url;
  String? organizer_announce;
  String? start_ymd;
  String? end_ymd;
  int? entry_type;
  int? entry_status;
  String? game_title_name;
  int? game_title_id;
  String? game_info;
  String? game_thumb_url;
  String? game_cover_thumb_url;
  String? game_icon_thumb_url;
  String? schedule_ymd;
  String? schedule_ymdhis;
  String? checkin_start_time;
  int? checkin_status;
  String? tournament_status;
  String? location_name;
  int? entry_player_num;
  int? real_entry_player_num;
  String? rule;
  String? role_type;
  String? app_bracket_url;
  String? rank_1_player_thumb_url;
  String? rank_2_player_thumb_url;
  String? rank_3_1_player_thumb_url;
  String? rank_3_2_player_thumb_url;
  int? flg_use_app;
  int? flg_use_live;
  int? organizer_user_id;
  int? flg_tournament_badge_on;
  int? flg_notice_badge_on;
  int? notice_badge_count;
  int? flg_match_board_badge_on;
  int? match_board_badge_count;
  int? player_status;

  TournamentInfo(
    this.flg_large_score,
    this.tournament_id,
    this.competition_type,
    this.competition_type_str,
    this.league_type,
    this.tournament_progress_status,
    this.tournament_progress_percent,
    this.tournament_name,
    this.match_type_str,
    this.tournament_type_str,
    this.tournament_thumb_url,
    this.tournament_result_url,
    this.organizer_name,
    this.organizer_twitter_id,
    this.organizer_thumb_url,
    this.organizer_web_url,
    this.organizer_announce,
    this.start_ymd,
    this.end_ymd,
    this.entry_type,
    this.entry_status,
    this.game_title_name,
    this.game_info,
    this.game_title_id,
    this.game_thumb_url,
    this.game_cover_thumb_url,
    this.game_icon_thumb_url,
    this.schedule_ymd,
    this.schedule_ymdhis,
    this.checkin_start_time,
    this.checkin_status,
    this.tournament_status,
    this.location_name,
    this.entry_player_num,
    this.real_entry_player_num,
    this.rule,
    this.role_type,
    this.app_bracket_url,
    this.rank_1_player_thumb_url,
    this.rank_2_player_thumb_url,
    this.rank_3_1_player_thumb_url,
    this.rank_3_2_player_thumb_url,
    this.flg_use_app,
    this.flg_use_live,
    this.organizer_user_id,
    this.flg_tournament_badge_on,
    this.flg_notice_badge_on,
    this.notice_badge_count,
    this.flg_match_board_badge_on,
    this.match_board_badge_count,
    this.player_status,
  );
  factory TournamentInfo.fromJson(Map<String, dynamic> json) => _$TournamentInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentInfoToJson(this);
}