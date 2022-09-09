import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class HomeResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<ItemGame>? game_thumb_list;
  String? web_url;

  HomeResponse({
    required bool success,
    required String error_message,
    this.game_thumb_list,
    this.web_url,
  }) : super(success: success, error_message: error_message);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class ItemGame {
  int? game_title_id;
  String? thumb_url;

  ItemGame({this.game_title_id, this.thumb_url});

  factory ItemGame.fromJson(Map<String, dynamic> json) =>
      _$ItemGameFromJson(json);

  Map<String, dynamic> toJson() => _$ItemGameToJson(this);
}
