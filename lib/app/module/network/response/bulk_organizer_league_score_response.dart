import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'bulk_organizer_league_score_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BulkOrganizerLeagueScoreResponse extends BaseResponse {
    bool? is_all_round_finish;
    int? flg_badge_on;
    int? badge_count;
    int? flg_swiss_round_decision;

    BulkOrganizerLeagueScoreResponse(this.is_all_round_finish, this.flg_badge_on,
      this.badge_count, this.flg_swiss_round_decision);

    factory BulkOrganizerLeagueScoreResponse.fromJson(Map<String, dynamic> json) =>
        _$BulkOrganizerLeagueScoreResponseFromJson(json);

    Map<String, dynamic> toJson() => _$BulkOrganizerLeagueScoreResponseToJson(this);
}