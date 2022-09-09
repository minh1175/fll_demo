import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'all_notification_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AllNotifyResponse extends BaseResponse {
  int? match_remaining_count;
  int? flg_chat_badge_on;
  int? chat_badge_count;
  int? flg_private_chat_badge_on;
  int? private_chat_badge_count;
  @JsonKey(defaultValue: 1)
  int flg_last_page;
  int? flg_other_badge_on;
  int? other_badge_count;
  @JsonKey(defaultValue: [])
  List<Tournament>? list;

  AllNotifyResponse({
    required bool success,
    required String error_message,
    this.match_remaining_count,
    this.flg_chat_badge_on,
    this.chat_badge_count,
    this.flg_private_chat_badge_on,
    this.private_chat_badge_count,
    required this.flg_last_page,
    this.flg_other_badge_on,
    this.other_badge_count,
     this.list,
  }) : super(success: success, error_message: error_message);

  factory AllNotifyResponse.fromJson(Map<String, dynamic> json) =>
      _$AllNotifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllNotifyResponseToJson(this);
}

@JsonSerializable()
class Tournament {
  int? tournament_id;
  String? tournament_name;
  int? tournament_round_id;
  String? title;
  String? message;
  String? thumb_url;
  String? date;
  int? tournament_private_chat_id;
  int? tournament_chat_id;
  int? notice_type;
  int? flg_unread;
  int? flg_badge_on;
  String? badge_text;
  String? match_text;
  @JsonKey(defaultValue: [])
  List<Label>? label_list;
  //type = 3
  int? id;
  int? type;
  int? url_type;
  String? url;
  Option? option;
  String? icon_url_main;
  String? icon_url_sub;

  Tournament(
      this.tournament_id,
      this.tournament_name,
      this.tournament_round_id,
      this.title,
      this.message,
      this.thumb_url,
      this.date,
      this.tournament_private_chat_id,
      this.tournament_chat_id,
      this.notice_type,
      this.flg_unread,
      this.flg_badge_on,
      this.badge_text,
      this.match_text,
      this.label_list,
      this.id,
      this.type,
      this.url_type,
      this.url,
      this.option,
      this.icon_url_main,
      this.icon_url_sub);

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentToJson(this);
}

@JsonSerializable()
class Label {
  String? text;
  int? color_type;

  Label(this.text, this.color_type);

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);

  Map<String, dynamic> toJson() => _$LabelToJson(this);
}

@JsonSerializable()
class Option {
  String? type;
  int? game_title_id;

  Option(this.type, this.game_title_id);

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
