import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'retire_player.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class RetirePlayerResponse extends BaseResponse {
  bool? is_complete;
  bool? is_all_round_finish;

  RetirePlayerResponse({
    required bool success,
    required String error_message,
    this.is_complete,
    this.is_all_round_finish,
  }): super(success: success, error_message: error_message);

  factory RetirePlayerResponse.fromJson(Map<String, dynamic> json) => _$RetirePlayerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RetirePlayerResponseToJson(this);
}