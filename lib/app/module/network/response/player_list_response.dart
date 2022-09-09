import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PlayerListResponse extends BaseResponse {

   @JsonKey(defaultValue: [])
   List<Player>? list;

   PlayerListResponse({
     this.list
   });

  factory PlayerListResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerListResponseToJson(this);
}

@JsonSerializable()
class Player {
  int? user_id;
  String? player_thumb_url;
  String? player_name;
  String? last_access_time;
  String? player_web_url;


  Player(
       this.user_id,
       this.player_thumb_url,
       this.player_name,
       this.last_access_time,
       this.player_web_url,
       );

  factory Player.fromJson(Map<String, dynamic> json) =>
      _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
