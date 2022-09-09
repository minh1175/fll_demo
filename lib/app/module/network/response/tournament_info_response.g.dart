// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentInfoResponse _$TournamentInfoResponseFromJson(
        Map<String, dynamic> json) =>
    TournamentInfoResponse(
      success: json['success'] as bool,
      error_message: json['error_message'] as String,
      tournament_info: json['tournament_info'] == null
          ? null
          : TournamentInfo.fromJson(
              json['tournament_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TournamentInfoResponseToJson(
        TournamentInfoResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'tournament_info': instance.tournament_info,
    };

TournamentInfo _$TournamentInfoFromJson(Map<String, dynamic> json) =>
    TournamentInfo(
      json['flg_large_score'] as int?,
      json['tournament_id'] as int?,
      json['competition_type'] as int?,
      json['competition_type_str'] as String?,
      json['league_type'] as int?,
      json['tournament_progress_status'] as int?,
      json['tournament_progress_percent'] as int?,
      json['tournament_name'] as String?,
      json['match_type_str'] as String?,
      json['tournament_type_str'] as String?,
      json['tournament_thumb_url'] as String?,
      json['tournament_result_url'] as String?,
      json['organizer_name'] as String?,
      json['organizer_twitter_id'] as String?,
      json['organizer_thumb_url'] as String?,
      json['organizer_web_url'] as String?,
      json['organizer_announce'] as String?,
      json['start_ymd'] as String?,
      json['end_ymd'] as String?,
      json['entry_type'] as int?,
      json['entry_status'] as int?,
      json['game_title_name'] as String?,
      json['game_info'] as String?,
      json['game_title_id'] as int?,
      json['game_thumb_url'] as String?,
      json['game_cover_thumb_url'] as String?,
      json['game_icon_thumb_url'] as String?,
      json['schedule_ymd'] as String?,
      json['schedule_ymdhis'] as String?,
      json['checkin_start_time'] as String?,
      json['checkin_status'] as int?,
      json['tournament_status'] as String?,
      json['location_name'] as String?,
      json['entry_player_num'] as int?,
      json['real_entry_player_num'] as int?,
      json['rule'] as String?,
      json['role_type'] as String?,
      json['app_bracket_url'] as String?,
      json['rank_1_player_thumb_url'] as String?,
      json['rank_2_player_thumb_url'] as String?,
      json['rank_3_1_player_thumb_url'] as String?,
      json['rank_3_2_player_thumb_url'] as String?,
      json['flg_use_app'] as int?,
      json['flg_use_live'] as int?,
      json['organizer_user_id'] as int?,
      json['flg_tournament_badge_on'] as int?,
      json['flg_notice_badge_on'] as int?,
      json['notice_badge_count'] as int?,
      json['flg_match_board_badge_on'] as int?,
      json['match_board_badge_count'] as int?,
      json['player_status'] as int?,
    );

Map<String, dynamic> _$TournamentInfoToJson(TournamentInfo instance) =>
    <String, dynamic>{
      'flg_large_score': instance.flg_large_score,
      'tournament_id': instance.tournament_id,
      'competition_type': instance.competition_type,
      'competition_type_str': instance.competition_type_str,
      'league_type': instance.league_type,
      'tournament_progress_status': instance.tournament_progress_status,
      'tournament_progress_percent': instance.tournament_progress_percent,
      'tournament_name': instance.tournament_name,
      'match_type_str': instance.match_type_str,
      'tournament_type_str': instance.tournament_type_str,
      'tournament_thumb_url': instance.tournament_thumb_url,
      'tournament_result_url': instance.tournament_result_url,
      'organizer_name': instance.organizer_name,
      'organizer_twitter_id': instance.organizer_twitter_id,
      'organizer_thumb_url': instance.organizer_thumb_url,
      'organizer_web_url': instance.organizer_web_url,
      'organizer_announce': instance.organizer_announce,
      'start_ymd': instance.start_ymd,
      'end_ymd': instance.end_ymd,
      'entry_type': instance.entry_type,
      'entry_status': instance.entry_status,
      'game_title_name': instance.game_title_name,
      'game_title_id': instance.game_title_id,
      'game_info': instance.game_info,
      'game_thumb_url': instance.game_thumb_url,
      'game_cover_thumb_url': instance.game_cover_thumb_url,
      'game_icon_thumb_url': instance.game_icon_thumb_url,
      'schedule_ymd': instance.schedule_ymd,
      'schedule_ymdhis': instance.schedule_ymdhis,
      'checkin_start_time': instance.checkin_start_time,
      'checkin_status': instance.checkin_status,
      'tournament_status': instance.tournament_status,
      'location_name': instance.location_name,
      'entry_player_num': instance.entry_player_num,
      'real_entry_player_num': instance.real_entry_player_num,
      'rule': instance.rule,
      'role_type': instance.role_type,
      'app_bracket_url': instance.app_bracket_url,
      'rank_1_player_thumb_url': instance.rank_1_player_thumb_url,
      'rank_2_player_thumb_url': instance.rank_2_player_thumb_url,
      'rank_3_1_player_thumb_url': instance.rank_3_1_player_thumb_url,
      'rank_3_2_player_thumb_url': instance.rank_3_2_player_thumb_url,
      'flg_use_app': instance.flg_use_app,
      'flg_use_live': instance.flg_use_live,
      'organizer_user_id': instance.organizer_user_id,
      'flg_tournament_badge_on': instance.flg_tournament_badge_on,
      'flg_notice_badge_on': instance.flg_notice_badge_on,
      'notice_badge_count': instance.notice_badge_count,
      'flg_match_board_badge_on': instance.flg_match_board_badge_on,
      'match_board_badge_count': instance.match_board_badge_count,
      'player_status': instance.player_status,
    };
