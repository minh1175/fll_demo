import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_private_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ChatPrivateListResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<String>? fixed_messages;
  bool? is_authorized;
  int? flg_chat_close;
  int? flg_last_page;
  int? tournament_id;
  int? competition_type;
  int? tournament_round_id;
  int? tournament_progress_status;
  bool? is_team;
  int? is_score_post;
  bool? is_score_post_btn_available;
  int? player_id_left;
  int? player_id_right;
  int? organizer_user_id;
  String? organizer_name;
  String? organizer_twitter_id;
  String? organizer_thumb_url;
  String? round_box_str;
  ChatUser? chat_user;
  ChatTeam? chat_team;
  int? current_unix_time;
  String? tournament_name;
  List<ChatPrivateItem>? chat_list;
  GameInfo game_info;

  ChatPrivateListResponse(
      this.fixed_messages,
      this.is_authorized,
      this.flg_chat_close,
      this.flg_last_page,
      this.tournament_id,
      this.competition_type,
      this.tournament_round_id,
      this.tournament_progress_status,
      this.is_team,
      this.is_score_post,
      this.player_id_left,
      this.player_id_right,
      this.organizer_user_id,
      this.organizer_name,
      this.organizer_twitter_id,
      this.organizer_thumb_url,
      this.round_box_str,
      this.chat_user,
      this.chat_team,
      this.current_unix_time,
      this.tournament_name,
      this.chat_list,
      this.game_info);

  factory ChatPrivateListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatPrivateListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatPrivateListResponseToJson(this);
}

@JsonSerializable()
class ChatUser {
  ChatUserItem? organizer;
  ChatUserItem? you;
  ChatUserItem? opponent;

  ChatUser(this.organizer, this.you, this.opponent);

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserToJson(this);
}

@JsonSerializable()
class ChatUserItem {
  String? thumb_url;
  String? twitter_id;
  int? user_id;
  String? name;
  String? disp_name;
  int? flg_non_access;
  String? last_access;
  int? flg_unsubscribe;

  ChatUserItem(
      this.thumb_url,
      this.twitter_id,
      this.user_id,
      this.name,
      this.disp_name,
      this.flg_non_access,
      this.last_access,
      this.flg_unsubscribe,);

  factory ChatUserItem.fromJson(Map<String, dynamic> json) =>
      _$ChatUserItemFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserItemToJson(this);
}

@JsonSerializable()
class ChatTeam {
  Team? your_team;
  Team? opponent_team;

  ChatTeam(this.your_team, this.opponent_team);

  factory ChatTeam.fromJson(Map<String, dynamic> json) =>
      _$ChatTeamFromJson(json);

  Map<String, dynamic> toJson() => _$ChatTeamToJson(this);
}

@JsonSerializable()
class Team {
  int? team_player_id;
  String? team_name;
  String? team_thumb_url;
  int? team_member_num;
  List<Member>? member_list;

  Team(this.team_player_id, this.team_name, this.team_thumb_url,
      this.team_member_num, this.member_list);

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable()
class Member {
  int? user_id;
  int? player_id;
  String? player_name;
  String? player_thumb_url;
  String? player_thumb_background_url;
  String? player_thumb_frame_url;
  String? player_in_game_id;
  String? twitter_id;

  Member(
      this.user_id,
      this.player_id,
      this.player_name,
      this.player_thumb_url,
      this.player_thumb_background_url,
      this.player_thumb_frame_url,
      this.player_in_game_id,
      this.twitter_id);

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class GameInfo {
  bool? is_default_show;
  int? game_title_id;
  String? open_close_title;
  int? game_match_type;
  String? game_thumb_url;
  String? match_explanation;
  String? type_id_exchange_explanation;
  String? type_id_exchange_player_thumb_left;
  String? type_id_exchange_in_game_id_left;
  String? type_id_exchange_player_thumb_right;
  String? type_id_exchange_in_game_id_right;
  String? type_host_explanation1;
  String? type_host_explanation2;
  String? type_host_player_name;
  String? type_host_player_thumb_url;
  String? type_host_game_thumb_url;
  String? type_password_explanation;
  String? type_password_text;

  GameInfo(
      this.is_default_show,
      this.game_title_id,
      this.open_close_title,
      this.game_match_type,
      this.game_thumb_url,
      this.match_explanation,
      this.type_id_exchange_explanation,
      this.type_id_exchange_player_thumb_left,
      this.type_id_exchange_in_game_id_left,
      this.type_id_exchange_player_thumb_right,
      this.type_id_exchange_in_game_id_right,
      this.type_host_explanation1,
      this.type_host_explanation2,
      this.type_host_player_name,
      this.type_host_player_thumb_url,
      this.type_host_game_thumb_url,
      this.type_password_explanation,
      this.type_password_text);

  factory GameInfo.fromJson(Map<String, dynamic> json) =>
      _$GameInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GameInfoToJson(this);
}

@JsonSerializable()
class ChatPrivateItem {
  int? tournament_private_chat_id;
  int? type;
  int? flg_organizer_call;
  int? user_id;
  String? player_name;
  String? player_unique_id;
  String? player_thumb_url;
  String? message;
  String? image_url;
  String? post_time;
  int? post_unix_time;
  double? image_size_rate;
  @JsonKey(defaultValue: [])
  List<AlreadyReadMessagePrivateData>? alrady_read_list;

  //extra
  bool? isRightPos;

  ChatPrivateItem(this.tournament_private_chat_id,
      this.type,
      this.flg_organizer_call,
      this.user_id,
      this.player_name,
      this.player_unique_id,
      this.player_thumb_url,
      this.message,
      this.image_url,
      this.post_time,
      this.post_unix_time,
      this.image_size_rate,
      this.alrady_read_list,
      this.isRightPos);

  factory ChatPrivateItem.fromJson(Map<String, dynamic> json) =>
      _$ChatPrivateItemFromJson(json);

  Map<String, dynamic> toJson() => _$ChatPrivateItemToJson(this);
}

@JsonSerializable()
class AlreadyReadMessagePrivateData {
  int? user_id;
  String? thumbnail;
  int? already_read_private_chat_id;

  AlreadyReadMessagePrivateData(
      this.user_id, this.thumbnail, this.already_read_private_chat_id);

  factory AlreadyReadMessagePrivateData.fromJson(Map<String, dynamic> json) =>
      _$AlreadyReadMessagePrivateDataFromJson(json);

  Map<String, dynamic> toJson() => _$AlreadyReadMessagePrivateDataToJson(this);
}
