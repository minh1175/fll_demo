// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_private_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPrivateListResponse _$ChatPrivateListResponseFromJson(
        Map<String, dynamic> json) =>
    ChatPrivateListResponse(
      (json['fixed_messages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      json['is_authorized'] as bool?,
      json['flg_chat_close'] as int?,
      json['flg_last_page'] as int?,
      json['tournament_id'] as int?,
      json['competition_type'] as int?,
      json['tournament_round_id'] as int?,
      json['tournament_progress_status'] as int?,
      json['is_team'] as bool?,
      json['is_score_post'] as int?,
      json['player_id_left'] as int?,
      json['player_id_right'] as int?,
      json['organizer_user_id'] as int?,
      json['organizer_name'] as String?,
      json['organizer_twitter_id'] as String?,
      json['organizer_thumb_url'] as String?,
      json['round_box_str'] as String?,
      json['chat_user'] == null
          ? null
          : ChatUser.fromJson(json['chat_user'] as Map<String, dynamic>),
      json['chat_team'] == null
          ? null
          : ChatTeam.fromJson(json['chat_team'] as Map<String, dynamic>),
      json['current_unix_time'] as int?,
      json['tournament_name'] as String?,
      (json['chat_list'] as List<dynamic>?)
          ?.map((e) => ChatPrivateItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      GameInfo.fromJson(json['game_info'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String
      ..is_score_post_btn_available =
          json['is_score_post_btn_available'] as bool?;

Map<String, dynamic> _$ChatPrivateListResponseToJson(
        ChatPrivateListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'fixed_messages': instance.fixed_messages,
      'is_authorized': instance.is_authorized,
      'flg_chat_close': instance.flg_chat_close,
      'flg_last_page': instance.flg_last_page,
      'tournament_id': instance.tournament_id,
      'competition_type': instance.competition_type,
      'tournament_round_id': instance.tournament_round_id,
      'tournament_progress_status': instance.tournament_progress_status,
      'is_team': instance.is_team,
      'is_score_post': instance.is_score_post,
      'is_score_post_btn_available': instance.is_score_post_btn_available,
      'player_id_left': instance.player_id_left,
      'player_id_right': instance.player_id_right,
      'organizer_user_id': instance.organizer_user_id,
      'organizer_name': instance.organizer_name,
      'organizer_twitter_id': instance.organizer_twitter_id,
      'organizer_thumb_url': instance.organizer_thumb_url,
      'round_box_str': instance.round_box_str,
      'chat_user': instance.chat_user,
      'chat_team': instance.chat_team,
      'current_unix_time': instance.current_unix_time,
      'tournament_name': instance.tournament_name,
      'chat_list': instance.chat_list,
      'game_info': instance.game_info,
    };

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) => ChatUser(
      json['organizer'] == null
          ? null
          : ChatUserItem.fromJson(json['organizer'] as Map<String, dynamic>),
      json['you'] == null
          ? null
          : ChatUserItem.fromJson(json['you'] as Map<String, dynamic>),
      json['opponent'] == null
          ? null
          : ChatUserItem.fromJson(json['opponent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      'organizer': instance.organizer,
      'you': instance.you,
      'opponent': instance.opponent,
    };

ChatUserItem _$ChatUserItemFromJson(Map<String, dynamic> json) => ChatUserItem(
      json['thumb_url'] as String?,
      json['twitter_id'] as String?,
      json['user_id'] as int?,
      json['name'] as String?,
      json['disp_name'] as String?,
      json['flg_non_access'] as int?,
      json['last_access'] as String?,
      json['flg_unsubscribe'] as int?,
    );

Map<String, dynamic> _$ChatUserItemToJson(ChatUserItem instance) =>
    <String, dynamic>{
      'thumb_url': instance.thumb_url,
      'twitter_id': instance.twitter_id,
      'user_id': instance.user_id,
      'name': instance.name,
      'disp_name': instance.disp_name,
      'flg_non_access': instance.flg_non_access,
      'last_access': instance.last_access,
      'flg_unsubscribe': instance.flg_unsubscribe,
    };

ChatTeam _$ChatTeamFromJson(Map<String, dynamic> json) => ChatTeam(
      json['your_team'] == null
          ? null
          : Team.fromJson(json['your_team'] as Map<String, dynamic>),
      json['opponent_team'] == null
          ? null
          : Team.fromJson(json['opponent_team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatTeamToJson(ChatTeam instance) => <String, dynamic>{
      'your_team': instance.your_team,
      'opponent_team': instance.opponent_team,
    };

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      json['team_player_id'] as int?,
      json['team_name'] as String?,
      json['team_thumb_url'] as String?,
      json['team_member_num'] as int?,
      (json['member_list'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'team_player_id': instance.team_player_id,
      'team_name': instance.team_name,
      'team_thumb_url': instance.team_thumb_url,
      'team_member_num': instance.team_member_num,
      'member_list': instance.member_list,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      json['user_id'] as int?,
      json['player_id'] as int?,
      json['player_name'] as String?,
      json['player_thumb_url'] as String?,
      json['player_thumb_background_url'] as String?,
      json['player_thumb_frame_url'] as String?,
      json['player_in_game_id'] as String?,
      json['twitter_id'] as String?,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'player_id': instance.player_id,
      'player_name': instance.player_name,
      'player_thumb_url': instance.player_thumb_url,
      'player_thumb_background_url': instance.player_thumb_background_url,
      'player_thumb_frame_url': instance.player_thumb_frame_url,
      'player_in_game_id': instance.player_in_game_id,
      'twitter_id': instance.twitter_id,
    };

GameInfo _$GameInfoFromJson(Map<String, dynamic> json) => GameInfo(
      json['is_default_show'] as bool?,
      json['game_title_id'] as int?,
      json['open_close_title'] as String?,
      json['game_match_type'] as int?,
      json['game_thumb_url'] as String?,
      json['match_explanation'] as String?,
      json['type_id_exchange_explanation'] as String?,
      json['type_id_exchange_player_thumb_left'] as String?,
      json['type_id_exchange_in_game_id_left'] as String?,
      json['type_id_exchange_player_thumb_right'] as String?,
      json['type_id_exchange_in_game_id_right'] as String?,
      json['type_host_explanation1'] as String?,
      json['type_host_explanation2'] as String?,
      json['type_host_player_name'] as String?,
      json['type_host_player_thumb_url'] as String?,
      json['type_host_game_thumb_url'] as String?,
      json['type_password_explanation'] as String?,
      json['type_password_text'] as String?,
    );

Map<String, dynamic> _$GameInfoToJson(GameInfo instance) => <String, dynamic>{
      'is_default_show': instance.is_default_show,
      'game_title_id': instance.game_title_id,
      'open_close_title': instance.open_close_title,
      'game_match_type': instance.game_match_type,
      'game_thumb_url': instance.game_thumb_url,
      'match_explanation': instance.match_explanation,
      'type_id_exchange_explanation': instance.type_id_exchange_explanation,
      'type_id_exchange_player_thumb_left':
          instance.type_id_exchange_player_thumb_left,
      'type_id_exchange_in_game_id_left':
          instance.type_id_exchange_in_game_id_left,
      'type_id_exchange_player_thumb_right':
          instance.type_id_exchange_player_thumb_right,
      'type_id_exchange_in_game_id_right':
          instance.type_id_exchange_in_game_id_right,
      'type_host_explanation1': instance.type_host_explanation1,
      'type_host_explanation2': instance.type_host_explanation2,
      'type_host_player_name': instance.type_host_player_name,
      'type_host_player_thumb_url': instance.type_host_player_thumb_url,
      'type_host_game_thumb_url': instance.type_host_game_thumb_url,
      'type_password_explanation': instance.type_password_explanation,
      'type_password_text': instance.type_password_text,
    };

ChatPrivateItem _$ChatPrivateItemFromJson(Map<String, dynamic> json) =>
    ChatPrivateItem(
      json['tournament_private_chat_id'] as int?,
      json['type'] as int?,
      json['flg_organizer_call'] as int?,
      json['user_id'] as int?,
      json['player_name'] as String?,
      json['player_unique_id'] as String?,
      json['player_thumb_url'] as String?,
      json['message'] as String?,
      json['image_url'] as String?,
      json['post_time'] as String?,
      json['post_unix_time'] as int?,
      (json['image_size_rate'] as num?)?.toDouble(),
      (json['alrady_read_list'] as List<dynamic>?)
              ?.map((e) => AlreadyReadMessagePrivateData.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      json['isRightPos'] as bool?,
    );

Map<String, dynamic> _$ChatPrivateItemToJson(ChatPrivateItem instance) =>
    <String, dynamic>{
      'tournament_private_chat_id': instance.tournament_private_chat_id,
      'type': instance.type,
      'flg_organizer_call': instance.flg_organizer_call,
      'user_id': instance.user_id,
      'player_name': instance.player_name,
      'player_unique_id': instance.player_unique_id,
      'player_thumb_url': instance.player_thumb_url,
      'message': instance.message,
      'image_url': instance.image_url,
      'post_time': instance.post_time,
      'post_unix_time': instance.post_unix_time,
      'image_size_rate': instance.image_size_rate,
      'alrady_read_list': instance.alrady_read_list,
      'isRightPos': instance.isRightPos,
    };

AlreadyReadMessagePrivateData _$AlreadyReadMessagePrivateDataFromJson(
        Map<String, dynamic> json) =>
    AlreadyReadMessagePrivateData(
      json['user_id'] as int?,
      json['thumbnail'] as String?,
      json['already_read_private_chat_id'] as int?,
    );

Map<String, dynamic> _$AlreadyReadMessagePrivateDataToJson(
        AlreadyReadMessagePrivateData instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'thumbnail': instance.thumbnail,
      'already_read_private_chat_id': instance.already_read_private_chat_id,
    };
