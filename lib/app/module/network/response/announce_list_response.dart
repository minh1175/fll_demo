import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'announce_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AnnounceListResponse extends BaseResponse {
   int? current_unix_time;
   List<Item>? list;

   AnnounceListResponse(this.current_unix_time, this.list);

  factory AnnounceListResponse.fromJson(Map<String, dynamic> json) =>
      _$AnnounceListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnnounceListResponseToJson(this);
}

@JsonSerializable()
class Item {
   String icon_text;
   String user_name;
   String thumb_url;
   String message;
   String image_url;
   int notice_unix_time;


   Item(this.icon_text, this.user_name, this.thumb_url, this.message,
      this.image_url, this.notice_unix_time);

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
