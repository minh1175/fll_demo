import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bulk_score_input_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BulkScoreInputResponse extends BaseResponse {

  @JsonKey(defaultValue: [])
  List<Item>? score_list;

  BulkScoreInputResponse(this.score_list);

  factory BulkScoreInputResponse.fromJson(Map<String, dynamic> json) =>
      _$BulkScoreInputResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BulkScoreInputResponseToJson(this);
}

@JsonSerializable()
class Item {

   int round_box_no;
   String player_thumb_left;
   String player_thumb_right;
   String player_name_left;
   String player_name_right;
   int player_id_left;
   int player_id_right;
   int? score_left;
   int? score_right;
   int? pk_score_left;
   int? pk_score_right;
   String win_lose_type_left;
   String win_lose_type_right;
   String? win_certification_url;
   @JsonKey(defaultValue: true)
   bool is_check_item;

   Item(
      this.round_box_no,
      this.player_thumb_left,
      this.player_thumb_right,
      this.player_name_left,
      this.player_name_right,
      this.player_id_left,
      this.player_id_right,
      this.score_left,
      this.score_right,
      this.pk_score_left,
      this.pk_score_right,
      this.win_lose_type_left,
      this.win_lose_type_right,
      this.win_certification_url,
      this.is_check_item);

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

