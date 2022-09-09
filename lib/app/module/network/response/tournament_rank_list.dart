import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tournament_rank_list.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class TournamentRankListResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<RankItem>? ranking_list;

  TournamentRankListResponse({
    required bool success,
    required String error_message,
    this.ranking_list,
  }) : super(success: success, error_message: error_message);

  factory TournamentRankListResponse.fromJson(Map<String, dynamic> json) => _$TournamentRankListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentRankListResponseToJson(this);
}

@JsonSerializable()
class RankItem {
  int? rank;
  String? thumb_url;
  String? player_name;

  RankItem(
      this.rank,
      this.thumb_url,
      this.player_name);

  factory RankItem.fromJson(Map<String, dynamic> json) => _$RankItemFromJson(json);
  Map<String, dynamic> toJson() => _$RankItemToJson(this);
}
