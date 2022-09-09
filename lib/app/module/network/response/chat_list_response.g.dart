// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatListResponse _$ChatListResponseFromJson(Map<String, dynamic> json) =>
    ChatListResponse(
      json['flg_chat_close'] as int?,
      json['current_unix_time'] as int?,
      json['tournament_progress_status'] as int?,
      json['flg_last_page'] as int?,
      json['bot_url'] as String?,
      json['parallel_url'] as String?,
      (json['chat_list'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['fixed_messages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      (json['typing_message_response'] as List<dynamic>?)
              ?.map((e) =>
                  TypingMessageResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String
      ..is_ad_display = json['is_ad_display'] as bool?;

Map<String, dynamic> _$ChatListResponseToJson(ChatListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'flg_chat_close': instance.flg_chat_close,
      'tournament_progress_status': instance.tournament_progress_status,
      'current_unix_time': instance.current_unix_time,
      'flg_last_page': instance.flg_last_page,
      'bot_url': instance.bot_url,
      'parallel_url': instance.parallel_url,
      'is_ad_display': instance.is_ad_display,
      'chat_list': instance.chat_list,
      'fixed_messages': instance.fixed_messages,
      'typing_message_response': instance.typing_message_response,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['tournament_chat_id'] as int?,
      json['user_id'] as int?,
      json['player_name'] as String?,
      json['player_unique_id'] as String?,
      json['player_thumb_url'] as String?,
      json['organizer_name'] as String?,
      json['organizer_unique_id'] as String?,
      json['organizer_thumb_url'] as String?,
      json['type'] as int?,
      json['flg_announce'] as int?,
      json['message'] as String?,
      json['image_url'] as String?,
      json['flg_result_reflect'] as int?,
      json['tournament_round_id'] as int?,
      json['round_box_no'] as int?,
      json['player_id_left'] as int?,
      json['player_id_right'] as int?,
      json['player_name_left'] as String?,
      json['player_name_right'] as String?,
      json['player_thumb_left'] as String?,
      json['player_thumb_right'] as String?,
      json['score_left'] as int?,
      json['score_right'] as int?,
      json['win_lose_type_left'] as String?,
      json['win_lose_type_right'] as String?,
      json['win_certification_url'] as String?,
      json['post_unix_time'] as int?,
      json['post_time'] as String?,
      (json['image_size_rate'] as num?)?.toDouble(),
      json['ranking_info'] == null
          ? null
          : RankingInfo.fromJson(json['ranking_info'] as Map<String, dynamic>),
      (json['alrady_read_list'] as List<dynamic>?)
              ?.map((e) =>
                  AlreadyReadMessageData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['isRightPos'] as bool?,
      json['isTyping'] as bool?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'tournament_chat_id': instance.tournament_chat_id,
      'user_id': instance.user_id,
      'player_name': instance.player_name,
      'player_unique_id': instance.player_unique_id,
      'player_thumb_url': instance.player_thumb_url,
      'organizer_name': instance.organizer_name,
      'organizer_unique_id': instance.organizer_unique_id,
      'organizer_thumb_url': instance.organizer_thumb_url,
      'type': instance.type,
      'flg_announce': instance.flg_announce,
      'message': instance.message,
      'image_url': instance.image_url,
      'flg_result_reflect': instance.flg_result_reflect,
      'tournament_round_id': instance.tournament_round_id,
      'round_box_no': instance.round_box_no,
      'player_id_left': instance.player_id_left,
      'player_id_right': instance.player_id_right,
      'player_name_left': instance.player_name_left,
      'player_name_right': instance.player_name_right,
      'player_thumb_left': instance.player_thumb_left,
      'player_thumb_right': instance.player_thumb_right,
      'score_left': instance.score_left,
      'score_right': instance.score_right,
      'win_lose_type_left': instance.win_lose_type_left,
      'win_lose_type_right': instance.win_lose_type_right,
      'win_certification_url': instance.win_certification_url,
      'post_unix_time': instance.post_unix_time,
      'post_time': instance.post_time,
      'image_size_rate': instance.image_size_rate,
      'ranking_info': instance.ranking_info,
      'alrady_read_list': instance.alrady_read_list,
      'isRightPos': instance.isRightPos,
      'isTyping': instance.isTyping,
    };

RankingInfo _$RankingInfoFromJson(Map<String, dynamic> json) => RankingInfo(
      json['ranking_url'] as String?,
      (json['ranking'] as List<dynamic>?)
              ?.map((e) => ItemRank.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RankingInfoToJson(RankingInfo instance) =>
    <String, dynamic>{
      'ranking_url': instance.ranking_url,
      'ranking': instance.ranking,
    };

ItemRank _$ItemRankFromJson(Map<String, dynamic> json) => ItemRank(
      json['rank'] as int?,
      json['thumb_url'] as String?,
      json['player_name'] as String?,
    );

Map<String, dynamic> _$ItemRankToJson(ItemRank instance) => <String, dynamic>{
      'rank': instance.rank,
      'thumb_url': instance.thumb_url,
      'player_name': instance.player_name,
    };

AlreadyReadMessageData _$AlreadyReadMessageDataFromJson(
        Map<String, dynamic> json) =>
    AlreadyReadMessageData(
      json['user_id'] as int?,
      json['thumbnail'] as String?,
      json['already_read_chat_id'] as int?,
    );

Map<String, dynamic> _$AlreadyReadMessageDataToJson(
        AlreadyReadMessageData instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'thumbnail': instance.thumbnail,
      'already_read_chat_id': instance.already_read_chat_id,
    };

TypingMessageResponse _$TypingMessageResponseFromJson(
        Map<String, dynamic> json) =>
    TypingMessageResponse(
      display_name: json['display_name'] as String?,
      display_thumbnail: json['display_thumbnail'] as String?,
      post_current_time: json['post_current_time'] as int?,
      tournament_id: json['tournament_id'] as int?,
      tournament_round_id: json['tournament_round_id'] as int?,
    );

Map<String, dynamic> _$TypingMessageResponseToJson(
        TypingMessageResponse instance) =>
    <String, dynamic>{
      'display_name': instance.display_name,
      'display_thumbnail': instance.display_thumbnail,
      'post_current_time': instance.post_current_time,
      'tournament_id': instance.tournament_id,
      'tournament_round_id': instance.tournament_round_id,
    };
