import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mypage_game_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class MyPageGameResponse extends BaseResponse {
  String? selected_sort_name;
  List<SortType> sort_type_list;
  GameInfo? game_info;
  UserInfo? user_info;
  GTRate? gt_rate;
  GTScore? gt_score;
  List<Number>? number_list;
  List<Badge>? badge_list;
  List<TeamNumber>? team_number_list;
  ConsecutiveWin? consecutive_win;
  ScoreNumber? score_number;
  LossNumber? loss_number;
  List<Extension>? extension_list;
  OrganizerPrize? organizer_prize;
  TournamentNumber? tournament_number;
  EntryNumber? entry_number;
  MatchNumber? match_number;
  TournamentScale? tournament_scale;

  MyPageGameResponse(
      this.selected_sort_name,
      this.sort_type_list,
      this.game_info,
      this.user_info,
      this.gt_rate,
      this.gt_score,
      this.number_list,
      this.badge_list,
      this.team_number_list,
      this.consecutive_win,
      this.score_number,
      this.loss_number,
      this.extension_list,
      this.organizer_prize,
      this.tournament_number,
      this.entry_number,
      this.match_number,
      this.tournament_scale);

  factory MyPageGameResponse.fromJson(Map<String, dynamic> json) =>
      _$MyPageGameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyPageGameResponseToJson(this);
}

@JsonSerializable()
class SortType {
  String? sort_name;
  int? sort_type;

  SortType(this.sort_name, this.sort_type);

  factory SortType.fromJson(Map<String, dynamic> json) => _$SortTypeFromJson(json);
  Map<String, dynamic> toJson() => _$SortTypeToJson(this);
}

@JsonSerializable()
class TournamentNumber {
  int? value;
  bool? clickable;
  String? url;

  TournamentNumber(this.value, this.clickable, this.url);

  factory TournamentNumber.fromJson(Map<String, dynamic> json) =>
      _$TournamentNumberFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentNumberToJson(this);
}

@JsonSerializable()
class EntryNumber {
  int? value;

  EntryNumber(this.value);

  factory EntryNumber.fromJson(Map<String, dynamic> json) =>
      _$EntryNumberFromJson(json);

  Map<String, dynamic> toJson() => _$EntryNumberToJson(this);
}

@JsonSerializable()
class MatchNumber {
  int? value;

  MatchNumber(this.value);

  factory MatchNumber.fromJson(Map<String, dynamic> json) =>
      _$MatchNumberFromJson(json);

  Map<String, dynamic> toJson() => _$MatchNumberToJson(this);
}

@JsonSerializable()
class TournamentScale {
  int? max_value;
  int? ave_value;

  TournamentScale(this.max_value, this.ave_value);

  factory TournamentScale.fromJson(Map<String, dynamic> json) =>
      _$TournamentScaleFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentScaleToJson(this);
}

@JsonSerializable()
class OrganizerPrize {
  String? value_en;
  String? value_ja;
  int? percent;
  bool? clickable;
  String? url;

  OrganizerPrize(
      this.value_en, this.value_ja, this.percent, this.clickable, this.url);

  factory OrganizerPrize.fromJson(Map<String, dynamic> json) =>
      _$OrganizerPrizeFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizerPrizeToJson(this);
}

@JsonSerializable()
class GameInfo {
  String? game_title_name;
  String? game_thumb_url;
  String? sub_text;

  GameInfo(this.game_title_name, this.game_thumb_url, this.sub_text);

  factory GameInfo.fromJson(Map<String, dynamic> json) =>
      _$GameInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GameInfoToJson(this);
}

@JsonSerializable()
class UserInfo {
  String? user_thumb_url;
  String? user_thumb_background_url;
  String? user_thumb_frame_url;
  String? user_name;
  String? twitter_screen_name;
  String? introduction;
  String? url_twitter;
  String? url_web_twitter;

  UserInfo(
      this.user_thumb_url,
      this.user_thumb_background_url,
      this.user_thumb_frame_url,
      this.user_name,
      this.twitter_screen_name,
      this.introduction,
      this.url_twitter,
      this.url_web_twitter);

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class GTRate {
  int? value;
  String? rank;
  int? max_value;
  int? percent;
  bool? clickable;
  String? url;

  GTRate(this.value, this.rank, this.max_value, this.percent, this.clickable,
      this.url);

  factory GTRate.fromJson(Map<String, dynamic> json) => _$GTRateFromJson(json);

  Map<String, dynamic> toJson() => _$GTRateToJson(this);
}

@JsonSerializable()
class GTScore {
  int? value;
  int? rank;
  String? up_down;
  int? percent;
  bool? clickable;
  String? url;

  GTScore(this.value, this.rank, this.up_down, this.percent, this.clickable,
      this.url);

  factory GTScore.fromJson(Map<String, dynamic> json) =>
      _$GTScoreFromJson(json);

  Map<String, dynamic> toJson() => _$GTScoreToJson(this);
}

@JsonSerializable()
class Number {
  String? title;
  int? value;
  bool? clickable;
  String? url;

  Number(this.title, this.value, this.clickable, this.url);

  factory Number.fromJson(Map<String, dynamic> json) => _$NumberFromJson(json);

  Map<String, dynamic> toJson() => _$NumberToJson(this);
}

@JsonSerializable()
class Badge {
  String? title;
  String? thumb_file_url;
  String? acquisition_date;
  String? category;
  String? game_cover_url;

  Badge(this.title, this.thumb_file_url, this.acquisition_date, this.category, this.game_cover_url);

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}

@JsonSerializable()
class TeamNumber {
  String? title;
  int? value;
  bool? clickable;
  String? url;

  TeamNumber(this.title, this.value, this.clickable, this.url);

  factory TeamNumber.fromJson(Map<String, dynamic> json) =>
      _$TeamNumberFromJson(json);

  Map<String, dynamic> toJson() => _$TeamNumberToJson(this);
}

@JsonSerializable()
class ConsecutiveWin {
  int? value;
  int? max_value;

  ConsecutiveWin(this.value, this.max_value);

  factory ConsecutiveWin.fromJson(Map<String, dynamic> json) =>
      _$ConsecutiveWinFromJson(json);

  Map<String, dynamic> toJson() => _$ConsecutiveWinToJson(this);
}

@JsonSerializable()
class ScoreNumber {
  int? value;
  int? ave_value;

  ScoreNumber(this.value, this.ave_value);

  factory ScoreNumber.fromJson(Map<String, dynamic> json) =>
      _$ScoreNumberFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreNumberToJson(this);
}

@JsonSerializable()
class LossNumber {
  int? value;
  int? ave_value;

  LossNumber(this.value, this.ave_value);

  factory LossNumber.fromJson(Map<String, dynamic> json) =>
      _$LossNumberFromJson(json);

  Map<String, dynamic> toJson() => _$LossNumberToJson(this);
}

@JsonSerializable()
class Extension {
  String? title;
  @JsonKey(defaultValue: [])
  List<String>? thumb_list;
  bool? clickable;
  String? url;

  List<String>? getThumbList() {
    return thumb_list;
  }

  Extension(this.title, this.thumb_list, this.clickable, this.url);

  factory Extension.fromJson(Map<String, dynamic> json) =>
      _$ExtensionFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionToJson(this);
}
