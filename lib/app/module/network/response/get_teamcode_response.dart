import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'get_teamcode_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GetTeamCodeResponse extends BaseResponse {
    String? team_code;
    String? message;

    GetTeamCodeResponse(this.team_code, this.message);
}