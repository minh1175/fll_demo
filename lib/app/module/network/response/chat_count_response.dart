import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

@JsonSerializable()
class ChatCountResponse extends BaseResponse {

  bool? exist_diff;
}