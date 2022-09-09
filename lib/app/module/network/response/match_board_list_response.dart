import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match_board_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class MatchBoardListResponse extends BaseResponse {
   int? game_type;
   int? game_title_id;
   String? role_type;
   int? flg_badge_on;
   int? badge_count;
   int? flg_use_live;
   String? explain;
   @JsonKey(defaultValue: [])
   List<Filter>? filter_menu_list;
   int? flg_last_page;
   int? unapproved_count;
   @JsonKey(defaultValue: [])
   List<ItemMatch>? match_board_list;

   MatchBoardListResponse(
       this.game_type,
       this.game_title_id,
       this.role_type,
       this.flg_badge_on,
       this.badge_count,
       this.flg_use_live,
       this.explain,
       this.filter_menu_list,
       this.flg_last_page,
       this.unapproved_count,
       this.match_board_list,
   );

  factory MatchBoardListResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchBoardListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatchBoardListResponseToJson(this);
}

@JsonSerializable()
class ItemMatch {
   int? tournament_id;
   String? tournament_name;
   String? tournament_thumb_url;
   int? game_type;
   String? game_thumb_url;
   int? tournament_round_id;
   int? round_box_no;
   String? round_box_str;
   int? status;
   String? status_string;
   int? round_no;
   int? is_score_post;
   int? player_id_left;
   int? player_id_right;
   int? user_id_left;
   int? user_id_right;
   String? player_unique_id_left;
   String? player_unique_id_right;
   String? player_name_left;
   String? player_name_right;
   String? player_thumb_left;
   String? player_thumb_right;
   int? player_left_flg_unsubscribe;
   int? player_right_flg_unsubscribe;
   String? player_twitter_id_left;
   String? player_twitter_id_right;
   String? player_twitter_url_left;
   String? player_twitter_url_right;
   String? score_left;
   String? score_right;
   String? pk_score_left;
   String? pk_score_right;
   String? win_lose_type_left;
   String? win_lose_type_right;
   int? gt_score_left;
   int? gt_score_right;
   String? play_url_left;
   String? play_url_right;
   String? chat_last_access_time_left;
   String? chat_last_access_time_right;
   String? live_orientation;
   int? flg_input_score_badge_on;
   String? stats_url;
   bool? is_chat_btn_display;
   bool? is_chat_btn_available;
   bool? is_score_post_btn_display;
   bool? is_score_post_btn_available;
   @JsonKey(defaultValue: [])
   List<ItemMovie>? move_list;

   ItemMatch(
       this.tournament_id,
       this.round_box_no,
       this.round_box_str,
       this.player_id_left,
       this.player_id_right,
       this.player_unique_id_left,
       this.player_unique_id_right,
       this.player_name_left,
       this.player_name_right,
       this.player_thumb_left,
       this.player_thumb_right,
       this.player_left_flg_unsubscribe,
       this.player_right_flg_unsubscribe,
       this.player_twitter_id_left,
       this.player_twitter_id_right,
       this.player_twitter_url_left,
       this.player_twitter_url_right,
       this.score_left,
       this.score_right,
       this.pk_score_left,
       this.pk_score_right,
       this.win_lose_type_left,
       this.win_lose_type_right,
       this.gt_score_left,
       this.gt_score_right,
       this.play_url_left,
       this.play_url_right,
       this.chat_last_access_time_left,
       this.chat_last_access_time_right,
       this.live_orientation,
       this.flg_input_score_badge_on,
       this.stats_url,
       this.is_chat_btn_display,
       this.is_chat_btn_available,
       this.is_score_post_btn_display,
       this.is_score_post_btn_available,
       this.move_list,
   );

   factory ItemMatch.fromJson(Map<String, dynamic> json) =>
       _$ItemMatchFromJson(json);
   Map<String, dynamic> toJson() => _$ItemMatchToJson(this);
}

@JsonSerializable()
class ItemMovie {
   int? flg_live;
   String? player_thumb_url;
   String? movie_thumb_url;
   String? movie_url;

   ItemMovie(
       this.flg_live,
       this.player_thumb_url,
       this.movie_thumb_url,
       this.movie_url,
   );

  factory ItemMovie.fromJson(Map<String, dynamic> json) =>
      _$ItemMovieFromJson(json);
  Map<String, dynamic> toJson() => _$ItemMovieToJson(this);
}


@JsonSerializable()
class Filter {
   int? type;
   int? round_no;
   String? title;
   String? count;
   int? flg_badge_on;
   bool? isCheck = false;

   Filter(
       this.type,
       this.round_no,
       this.title,
       this.count,
       this.flg_badge_on,
       this.isCheck,
   );

  factory Filter.fromJson(Map<String, dynamic> json) =>
      _$FilterFromJson(json);
  Map<String, dynamic> toJson() => _$FilterToJson(this);
}