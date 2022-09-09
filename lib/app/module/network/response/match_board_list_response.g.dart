// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_board_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchBoardListResponse _$MatchBoardListResponseFromJson(
        Map<String, dynamic> json) =>
    MatchBoardListResponse(
      json['game_type'] as int?,
      json['game_title_id'] as int?,
      json['role_type'] as String?,
      json['flg_badge_on'] as int?,
      json['badge_count'] as int?,
      json['flg_use_live'] as int?,
      json['explain'] as String?,
      (json['filter_menu_list'] as List<dynamic>?)
              ?.map((e) => Filter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['flg_last_page'] as int?,
      json['unapproved_count'] as int?,
      (json['match_board_list'] as List<dynamic>?)
              ?.map((e) => ItemMatch.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$MatchBoardListResponseToJson(
        MatchBoardListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'game_type': instance.game_type,
      'game_title_id': instance.game_title_id,
      'role_type': instance.role_type,
      'flg_badge_on': instance.flg_badge_on,
      'badge_count': instance.badge_count,
      'flg_use_live': instance.flg_use_live,
      'explain': instance.explain,
      'filter_menu_list': instance.filter_menu_list,
      'flg_last_page': instance.flg_last_page,
      'unapproved_count': instance.unapproved_count,
      'match_board_list': instance.match_board_list,
    };

ItemMatch _$ItemMatchFromJson(Map<String, dynamic> json) => ItemMatch(
      json['tournament_id'] as int?,
      json['round_box_no'] as int?,
      json['round_box_str'] as String?,
      json['player_id_left'] as int?,
      json['player_id_right'] as int?,
      json['player_unique_id_left'] as String?,
      json['player_unique_id_right'] as String?,
      json['player_name_left'] as String?,
      json['player_name_right'] as String?,
      json['player_thumb_left'] as String?,
      json['player_thumb_right'] as String?,
      json['player_left_flg_unsubscribe'] as int?,
      json['player_right_flg_unsubscribe'] as int?,
      json['player_twitter_id_left'] as String?,
      json['player_twitter_id_right'] as String?,
      json['player_twitter_url_left'] as String?,
      json['player_twitter_url_right'] as String?,
      json['score_left'] as String?,
      json['score_right'] as String?,
      json['pk_score_left'] as String?,
      json['pk_score_right'] as String?,
      json['win_lose_type_left'] as String?,
      json['win_lose_type_right'] as String?,
      json['gt_score_left'] as int?,
      json['gt_score_right'] as int?,
      json['play_url_left'] as String?,
      json['play_url_right'] as String?,
      json['chat_last_access_time_left'] as String?,
      json['chat_last_access_time_right'] as String?,
      json['live_orientation'] as String?,
      json['flg_input_score_badge_on'] as int?,
      json['stats_url'] as String?,
      json['is_chat_btn_display'] as bool?,
      json['is_chat_btn_available'] as bool?,
      json['is_score_post_btn_display'] as bool?,
      json['is_score_post_btn_available'] as bool?,
      (json['move_list'] as List<dynamic>?)
              ?.map((e) => ItemMovie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..tournament_name = json['tournament_name'] as String?
      ..tournament_thumb_url = json['tournament_thumb_url'] as String?
      ..game_type = json['game_type'] as int?
      ..game_thumb_url = json['game_thumb_url'] as String?
      ..tournament_round_id = json['tournament_round_id'] as int?
      ..status = json['status'] as int?
      ..status_string = json['status_string'] as String?
      ..round_no = json['round_no'] as int?
      ..is_score_post = json['is_score_post'] as int?
      ..user_id_left = json['user_id_left'] as int?
      ..user_id_right = json['user_id_right'] as int?;

Map<String, dynamic> _$ItemMatchToJson(ItemMatch instance) => <String, dynamic>{
      'tournament_id': instance.tournament_id,
      'tournament_name': instance.tournament_name,
      'tournament_thumb_url': instance.tournament_thumb_url,
      'game_type': instance.game_type,
      'game_thumb_url': instance.game_thumb_url,
      'tournament_round_id': instance.tournament_round_id,
      'round_box_no': instance.round_box_no,
      'round_box_str': instance.round_box_str,
      'status': instance.status,
      'status_string': instance.status_string,
      'round_no': instance.round_no,
      'is_score_post': instance.is_score_post,
      'player_id_left': instance.player_id_left,
      'player_id_right': instance.player_id_right,
      'user_id_left': instance.user_id_left,
      'user_id_right': instance.user_id_right,
      'player_unique_id_left': instance.player_unique_id_left,
      'player_unique_id_right': instance.player_unique_id_right,
      'player_name_left': instance.player_name_left,
      'player_name_right': instance.player_name_right,
      'player_thumb_left': instance.player_thumb_left,
      'player_thumb_right': instance.player_thumb_right,
      'player_left_flg_unsubscribe': instance.player_left_flg_unsubscribe,
      'player_right_flg_unsubscribe': instance.player_right_flg_unsubscribe,
      'player_twitter_id_left': instance.player_twitter_id_left,
      'player_twitter_id_right': instance.player_twitter_id_right,
      'player_twitter_url_left': instance.player_twitter_url_left,
      'player_twitter_url_right': instance.player_twitter_url_right,
      'score_left': instance.score_left,
      'score_right': instance.score_right,
      'pk_score_left': instance.pk_score_left,
      'pk_score_right': instance.pk_score_right,
      'win_lose_type_left': instance.win_lose_type_left,
      'win_lose_type_right': instance.win_lose_type_right,
      'gt_score_left': instance.gt_score_left,
      'gt_score_right': instance.gt_score_right,
      'play_url_left': instance.play_url_left,
      'play_url_right': instance.play_url_right,
      'chat_last_access_time_left': instance.chat_last_access_time_left,
      'chat_last_access_time_right': instance.chat_last_access_time_right,
      'live_orientation': instance.live_orientation,
      'flg_input_score_badge_on': instance.flg_input_score_badge_on,
      'stats_url': instance.stats_url,
      'is_chat_btn_display': instance.is_chat_btn_display,
      'is_chat_btn_available': instance.is_chat_btn_available,
      'is_score_post_btn_display': instance.is_score_post_btn_display,
      'is_score_post_btn_available': instance.is_score_post_btn_available,
      'move_list': instance.move_list,
    };

ItemMovie _$ItemMovieFromJson(Map<String, dynamic> json) => ItemMovie(
      json['flg_live'] as int?,
      json['player_thumb_url'] as String?,
      json['movie_thumb_url'] as String?,
      json['movie_url'] as String?,
    );

Map<String, dynamic> _$ItemMovieToJson(ItemMovie instance) => <String, dynamic>{
      'flg_live': instance.flg_live,
      'player_thumb_url': instance.player_thumb_url,
      'movie_thumb_url': instance.movie_thumb_url,
      'movie_url': instance.movie_url,
    };

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      json['type'] as int?,
      json['round_no'] as int?,
      json['title'] as String?,
      json['count'] as String?,
      json['flg_badge_on'] as int?,
      json['isCheck'] as bool?,
    );

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'type': instance.type,
      'round_no': instance.round_no,
      'title': instance.title,
      'count': instance.count,
      'flg_badge_on': instance.flg_badge_on,
      'isCheck': instance.isCheck,
    };
