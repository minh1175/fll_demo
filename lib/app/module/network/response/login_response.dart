import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class LoginResponse extends BaseResponse {
  bool is_new_regist = false;
  int? user_id;
  int? player_id;
  String? player_name;
  String? thumb_url;

  LoginResponse({
    required bool success,
    required String error_message,
    this.is_new_regist = false,
    this.user_id,
    this.player_id,
    this.player_name,
    this.thumb_url,
  }) : super(success: success, error_message: error_message);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}
