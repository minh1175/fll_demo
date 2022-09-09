// import 'package:Gametector/app/module/network/receive/typing_message_response.dart';
import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ChatListResponse extends BaseResponse {
  int? flg_chat_close = 0; // TODO : delete??
  int? tournament_progress_status;
  int? current_unix_time;
  int? flg_last_page;
  String? bot_url;
  String? parallel_url;
  bool? is_ad_display;
  @JsonKey(defaultValue: [])
  List<Item>? chat_list;
  @JsonKey(defaultValue: [])
  List<String>? fixed_messages;
  @JsonKey(defaultValue: [])
  List<TypingMessageResponse>? typing_message_response;

  ChatListResponse(
      this.flg_chat_close,
      this.current_unix_time,
      this.tournament_progress_status,
      this.flg_last_page,
      this.bot_url,
      this.parallel_url,
      this.chat_list,
      this.fixed_messages,
      this.typing_message_response,
  );

  factory ChatListResponse.fromJson(Map<String, dynamic> json) => _$ChatListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatListResponseToJson(this);
}

@JsonSerializable()
class Item {
  int? tournament_chat_id;
  int? user_id;
  String? player_name;
  String? player_unique_id;
  String? player_thumb_url;
  String? organizer_name;
  String? organizer_unique_id;
  String? organizer_thumb_url;
  int? type;
  int? flg_announce;
  String? message;
  String? image_url;
  int? flg_result_reflect;
  int? tournament_round_id;
  int? round_box_no;
  int? player_id_left;
  int? player_id_right;
  String? player_name_left;
  String? player_name_right;
  String? player_thumb_left;
  String? player_thumb_right;
  int? score_left;
  int? score_right;
  String? win_lose_type_left;
  String? win_lose_type_right;
  String? win_certification_url;
  int? post_unix_time;
  String? post_time;
  double? image_size_rate;
  RankingInfo? ranking_info;
  @JsonKey(defaultValue: [])
  List<AlreadyReadMessageData>? alrady_read_list;
  //extra
  bool? isRightPos;
  bool? isTyping = false;

  Item(
      this.tournament_chat_id,
      this.user_id,
      this.player_name,
      this.player_unique_id,
      this.player_thumb_url,
      this.organizer_name,
      this.organizer_unique_id,
      this.organizer_thumb_url,
      this.type,
      this.flg_announce,
      this.message,
      this.image_url,
      this.flg_result_reflect,
      this.tournament_round_id,
      this.round_box_no,
      this.player_id_left,
      this.player_id_right,
      this.player_name_left,
      this.player_name_right,
      this.player_thumb_left,
      this.player_thumb_right,
      this.score_left,
      this.score_right,
      this.win_lose_type_left,
      this.win_lose_type_right,
      this.win_certification_url,
      this.post_unix_time,
      this.post_time,
      this.image_size_rate,
      this.ranking_info,
      this.alrady_read_list,
      this.isRightPos,
      this.isTyping,
  );

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class RankingInfo {
  String? ranking_url;
  @JsonKey(defaultValue: [])
  List<ItemRank>? ranking;

  RankingInfo(this.ranking_url, this.ranking);

  factory RankingInfo.fromJson(Map<String, dynamic> json) => _$RankingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RankingInfoToJson(this);
}

@JsonSerializable()
class ItemRank {
  int? rank;
  String? thumb_url;
  String? player_name;

  ItemRank(this.rank, this.thumb_url, this.player_name);

  factory ItemRank.fromJson(Map<String, dynamic> json) => _$ItemRankFromJson(json);
  Map<String, dynamic> toJson() => _$ItemRankToJson(this);
}

@JsonSerializable()
class AlreadyReadMessageData {
  int? user_id;
  String? thumbnail;
  int? already_read_chat_id;

  AlreadyReadMessageData(this.user_id, this.thumbnail, this.already_read_chat_id);

  factory AlreadyReadMessageData.fromJson(Map<String, dynamic> json) => _$AlreadyReadMessageDataFromJson(json);
  Map<String, dynamic> toJson() => _$AlreadyReadMessageDataToJson(this);
}

@JsonSerializable()
class TypingMessageResponse{
  String? display_name;
  String? display_thumbnail;
  int? post_current_time;
  int? tournament_id;
  int? tournament_round_id;

  TypingMessageResponse({
    this.display_name,
    this.display_thumbnail,
    this.post_current_time,
    this.tournament_id,
    this.tournament_round_id,
  });

  factory TypingMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$TypingMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TypingMessageResponseToJson(this);
}