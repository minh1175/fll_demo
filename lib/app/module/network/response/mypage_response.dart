import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mypage_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class MyPageResponse extends BaseResponse {
  String? user_name;
  String? introduction;
  String? twitter_url;
  String? twitter_web_url;
  String? create_tournament_url;
  @JsonKey(defaultValue: [])
  List<Game>? game_list;
  @JsonKey(defaultValue: [])
  List<MyPageBanner>? banner_list;

  MyPageResponse(
      this.user_name,
      this.introduction,
      this.twitter_url,
      this.twitter_web_url,
      this.create_tournament_url,
      this.game_list,
      this.banner_list);

  factory MyPageResponse.fromJson(Map<String, dynamic> json) =>
      _$MyPageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyPageResponseToJson(this);
}

@JsonSerializable()
class Game {
  String? game_title_name;
  int? game_title_id;
  String? game_thumb_url;

  Game(this.game_title_name, this.game_title_id, this.game_thumb_url);

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}

@JsonSerializable()
class MyPageBanner {
  String? thumb_url;
  String? web_url;

  MyPageBanner(this.thumb_url, this.web_url);

  factory MyPageBanner.fromJson(Map<String, dynamic> json) => _$MyPageBannerFromJson(json);

  Map<String, dynamic> toJson() => _$MyPageBannerToJson(this);
}
