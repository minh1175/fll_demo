// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllNotifyResponse _$AllNotifyResponseFromJson(Map<String, dynamic> json) =>
    AllNotifyResponse(
      success: json['success'] as bool,
      error_message: json['error_message'] as String,
      match_remaining_count: json['match_remaining_count'] as int?,
      flg_chat_badge_on: json['flg_chat_badge_on'] as int?,
      chat_badge_count: json['chat_badge_count'] as int?,
      flg_private_chat_badge_on: json['flg_private_chat_badge_on'] as int?,
      private_chat_badge_count: json['private_chat_badge_count'] as int?,
      flg_last_page: json['flg_last_page'] as int? ?? 1,
      flg_other_badge_on: json['flg_other_badge_on'] as int?,
      other_badge_count: json['other_badge_count'] as int?,
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => Tournament.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AllNotifyResponseToJson(AllNotifyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'match_remaining_count': instance.match_remaining_count,
      'flg_chat_badge_on': instance.flg_chat_badge_on,
      'chat_badge_count': instance.chat_badge_count,
      'flg_private_chat_badge_on': instance.flg_private_chat_badge_on,
      'private_chat_badge_count': instance.private_chat_badge_count,
      'flg_last_page': instance.flg_last_page,
      'flg_other_badge_on': instance.flg_other_badge_on,
      'other_badge_count': instance.other_badge_count,
      'list': instance.list,
    };

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      json['tournament_id'] as int?,
      json['tournament_name'] as String?,
      json['tournament_round_id'] as int?,
      json['title'] as String?,
      json['message'] as String?,
      json['thumb_url'] as String?,
      json['date'] as String?,
      json['tournament_private_chat_id'] as int?,
      json['tournament_chat_id'] as int?,
      json['notice_type'] as int?,
      json['flg_unread'] as int?,
      json['flg_badge_on'] as int?,
      json['badge_text'] as String?,
      json['match_text'] as String?,
      (json['label_list'] as List<dynamic>?)
              ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['id'] as int?,
      json['type'] as int?,
      json['url_type'] as int?,
      json['url'] as String?,
      json['option'] == null
          ? null
          : Option.fromJson(json['option'] as Map<String, dynamic>),
      json['icon_url_main'] as String?,
      json['icon_url_sub'] as String?,
    );

Map<String, dynamic> _$TournamentToJson(Tournament instance) =>
    <String, dynamic>{
      'tournament_id': instance.tournament_id,
      'tournament_name': instance.tournament_name,
      'tournament_round_id': instance.tournament_round_id,
      'title': instance.title,
      'message': instance.message,
      'thumb_url': instance.thumb_url,
      'date': instance.date,
      'tournament_private_chat_id': instance.tournament_private_chat_id,
      'tournament_chat_id': instance.tournament_chat_id,
      'notice_type': instance.notice_type,
      'flg_unread': instance.flg_unread,
      'flg_badge_on': instance.flg_badge_on,
      'badge_text': instance.badge_text,
      'match_text': instance.match_text,
      'label_list': instance.label_list,
      'id': instance.id,
      'type': instance.type,
      'url_type': instance.url_type,
      'url': instance.url,
      'option': instance.option,
      'icon_url_main': instance.icon_url_main,
      'icon_url_sub': instance.icon_url_sub,
    };

Label _$LabelFromJson(Map<String, dynamic> json) => Label(
      json['text'] as String?,
      json['color_type'] as int?,
    );

Map<String, dynamic> _$LabelToJson(Label instance) => <String, dynamic>{
      'text': instance.text,
      'color_type': instance.color_type,
    };

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      json['type'] as String?,
      json['game_title_id'] as int?,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'type': instance.type,
      'game_title_id': instance.game_title_id,
    };
