import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'get_setting_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GetSettingResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<Item>? list;

  GetSettingResponse(this.list);

  factory GetSettingResponse.fromJson(Map<String, dynamic> json) => _$GetSettingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSettingResponseToJson(this);
}

@JsonSerializable()
class Item {
  String? group;
  List<Content>? content;

  Item(this.group, this.content);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Content {
  String? title;
  String? comment;
  int? flg_on;
  String? key;

  Content(this.title, this.comment, this.flg_on, this.key);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}