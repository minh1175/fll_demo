import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'athletes_abstrain_participants_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AthletesAbstrainParticipantResponse extends BaseResponse {
  String? explain;
  bool? is_all_round_finish;
  @JsonKey(defaultValue: [])
  List<ItemAthletes>? player_list;

  AthletesAbstrainParticipantResponse(
      this.explain,
      this.is_all_round_finish,
      this.player_list);

  factory AthletesAbstrainParticipantResponse.fromJson(Map<String, dynamic> json) => _$AthletesAbstrainParticipantResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AthletesAbstrainParticipantResponseToJson(this);
}

@JsonSerializable()
class ItemAthletes {
  String? thumb_url;
  String? player_name;
  int? player_id;
  int? flg_retire;

  bool getFlgRetire() {
    return flg_retire == 1;
  }

  ItemAthletes(
      this.thumb_url,
      this.player_name,
      this.player_id,
      this.flg_retire);

  factory ItemAthletes.fromJson(Map<String, dynamic> json) => _$ItemAthletesFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAthletesToJson(this);
}
