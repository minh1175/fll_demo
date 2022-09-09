import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tournament_finish_half_way_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class TournamentFinishHalfWayResponse extends BaseResponse {

  bool is_complete;

  TournamentFinishHalfWayResponse(this.is_complete);

  factory TournamentFinishHalfWayResponse.fromJson(Map<String, dynamic> json) =>
      _$TournamentFinishHalfWayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentFinishHalfWayResponseToJson(this);
}