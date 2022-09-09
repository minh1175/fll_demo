// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participants_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantResponse _$ParticipantResponseFromJson(Map<String, dynamic> json) =>
    ParticipantResponse(
      is_organizer: json['is_organizer'] as bool?,
      tournament_progress_status: json['tournament_progress_status'] as int?,
      match_type: json['match_type'] as int?,
      invitation_url: json['invitation_url'] as String?,
      is_make_teamcode: json['is_make_teamcode'] as bool?,
      team_list: (json['team_list'] as List<dynamic>?)
              ?.map((e) => Team.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      player_list: (json['player_list'] as List<dynamic>?)
              ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$ParticipantResponseToJson(
        ParticipantResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'is_organizer': instance.is_organizer,
      'tournament_progress_status': instance.tournament_progress_status,
      'match_type': instance.match_type,
      'invitation_url': instance.invitation_url,
      'is_make_teamcode': instance.is_make_teamcode,
      'team_list': instance.team_list,
      'player_list': instance.player_list,
    };

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      team_player_id: json['team_player_id'] as int,
      team_name: json['team_name'] as String,
      team_thumb_url: json['team_thumb_url'] as String,
      team_member_num: json['team_member_num'] as int,
      is_manageable: json['is_manageable'] as bool,
      entry_status: json['entry_status'] as int,
      member_list: (json['member_list'] as List<dynamic>?)
              ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'team_player_id': instance.team_player_id,
      'team_name': instance.team_name,
      'team_thumb_url': instance.team_thumb_url,
      'team_member_num': instance.team_member_num,
      'is_manageable': instance.is_manageable,
      'entry_status': instance.entry_status,
      'member_list': instance.member_list,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      player_id: json['player_id'] as int,
      player_thumb_url: json['player_thumb_url'] as String,
      player_name: json['player_name'] as String,
      player_thumb_background_url:
          json['player_thumb_background_url'] as String,
      player_thumb_frame_url: json['player_thumb_frame_url'] as String,
      player_in_game_id: json['player_in_game_id'] as String,
      gt_rate_class: json['gt_rate_class'] as String,
      gt_score: json['gt_score'] as int,
      is_manageable: json['is_manageable'] as bool,
      entry_status: json['entry_status'] as int,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'player_id': instance.player_id,
      'player_name': instance.player_name,
      'player_thumb_url': instance.player_thumb_url,
      'player_thumb_background_url': instance.player_thumb_background_url,
      'player_thumb_frame_url': instance.player_thumb_frame_url,
      'player_in_game_id': instance.player_in_game_id,
      'gt_rate_class': instance.gt_rate_class,
      'gt_score': instance.gt_score,
      'is_manageable': instance.is_manageable,
      'entry_status': instance.entry_status,
    };
