import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participants_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ParticipantResponse extends BaseResponse {
  bool? is_organizer;
  int? tournament_progress_status;
  int? match_type;
  String? invitation_url;
  bool? is_make_teamcode;
  @JsonKey(defaultValue: [])
  List<Team>? team_list;
  @JsonKey(defaultValue: [])
  List<Player>? player_list;

  ParticipantResponse({
    this.is_organizer,
    this.tournament_progress_status,
    this.match_type,
    this.invitation_url,
    this.is_make_teamcode,
    this.team_list,
    this.player_list,
  });

  factory ParticipantResponse.fromJson(Map<String, dynamic> json) => _$ParticipantResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantResponseToJson(this);
}

@JsonSerializable()
class Team {
  int team_player_id;
  String team_name;
  String team_thumb_url;
  int team_member_num;
  bool is_manageable;
  int entry_status;
  @JsonKey(defaultValue: [])
  List<Player>? member_list;

  Team({
    required this.team_player_id,
    required this.team_name,
    required this.team_thumb_url,
    required this.team_member_num,
    required this.is_manageable,
    required this.entry_status,
    required this.member_list,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable()
class Player {
  int player_id;
  String player_name;
  String player_thumb_url;
  String player_thumb_background_url;
  String player_thumb_frame_url;
  String player_in_game_id;
  String gt_rate_class;
  int gt_score;
  bool is_manageable;
  int entry_status;

  Player({
    required this.player_id,
    required this.player_thumb_url,
    required this.player_name,
    required this.player_thumb_background_url,
    required this.player_thumb_frame_url,
    required this.player_in_game_id,
    required this.gt_rate_class,
    required this.gt_score,
    required this.is_manageable,
    required this.entry_status,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
