// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartResponse _$StartResponseFromJson(Map<String, dynamic> json) =>
    StartResponse(
      success: json['success'] as bool,
      error_message: json['error_message'] as String,
      app_token: json['app_token'] as String?,
      user_id: json['user_id'] as int?,
      login_type: json['login_type'] as int?,
      player_id: json['player_id'] as int?,
      player_name: json['player_name'] as String?,
      thumb_url: json['thumb_url'] as String?,
      is_twitter_link: json['is_twitter_link'] as bool,
      is_update_info: json['is_update_info'] as bool,
      live_bitrate: json['live_bitrate'] as int?,
      setting: json['setting'] == null
          ? null
          : Setting.fromJson(json['setting'] as Map<String, dynamic>),
      battle_report: json['battle_report'] == null
          ? null
          : BattleReport.fromJson(
              json['battle_report'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StartResponseToJson(StartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'app_token': instance.app_token,
      'user_id': instance.user_id,
      'login_type': instance.login_type,
      'player_id': instance.player_id,
      'player_name': instance.player_name,
      'thumb_url': instance.thumb_url,
      'is_twitter_link': instance.is_twitter_link,
      'is_update_info': instance.is_update_info,
      'live_bitrate': instance.live_bitrate,
      'setting': instance.setting,
      'battle_report': instance.battle_report,
    };

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      flgNoFinishedPush: json['flgNoFinishedPush'] as int?,
      flgPlayerPushTwitterMension: json['flgPlayerPushTwitterMension'] as int?,
      flgPlayerPushOpponentDecision:
          json['flgPlayerPushOpponentDecision'] as int?,
      flgPlayerPushPrivateChatComment:
          json['flgPlayerPushPrivateChatComment'] as int?,
      flgOrganizerPushCall: json['flgOrganizerPushCall'] as int?,
      flgOrganizerPushPrivateChatComment:
          json['flgOrganizerPushPrivateChatComment'] as int?,
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'flgNoFinishedPush': instance.flgNoFinishedPush,
      'flgPlayerPushTwitterMension': instance.flgPlayerPushTwitterMension,
      'flgPlayerPushOpponentDecision': instance.flgPlayerPushOpponentDecision,
      'flgPlayerPushPrivateChatComment':
          instance.flgPlayerPushPrivateChatComment,
      'flgOrganizerPushCall': instance.flgOrganizerPushCall,
      'flgOrganizerPushPrivateChatComment':
          instance.flgOrganizerPushPrivateChatComment,
    };

BattleReport _$BattleReportFromJson(Map<String, dynamic> json) => BattleReport(
      is_show: json['is_show'] as bool?,
      before_rate: json['before_rate'] as int?,
      after_rate: json['after_rate'] as int?,
      before_score: json['before_score'] as int?,
      after_score: json['after_score'] as int?,
      game_title: json['game_title'] as String?,
      game_title_thumb: json['game_title_thumb'] as String?,
      before_player_thumb_url: json['before_player_thumb_url'] as String?,
      before_player_thumb_background_url:
          json['before_player_thumb_background_url'] as String?,
      before_player_thumb_frame_url:
          json['before_player_thumb_frame_url'] as String?,
      after_player_thumb_url: json['after_player_thumb_url'] as String?,
      after_player_thumb_background_url:
          json['after_player_thumb_background_url'] as String?,
      after_player_thumb_frame_url:
          json['after_player_thumb_frame_url'] as String?,
      up_basic_prize_name: json['up_basic_prize_name'] as String?,
    );

Map<String, dynamic> _$BattleReportToJson(BattleReport instance) =>
    <String, dynamic>{
      'is_show': instance.is_show,
      'before_rate': instance.before_rate,
      'after_rate': instance.after_rate,
      'before_score': instance.before_score,
      'after_score': instance.after_score,
      'game_title': instance.game_title,
      'game_title_thumb': instance.game_title_thumb,
      'before_player_thumb_url': instance.before_player_thumb_url,
      'before_player_thumb_background_url':
          instance.before_player_thumb_background_url,
      'before_player_thumb_frame_url': instance.before_player_thumb_frame_url,
      'after_player_thumb_url': instance.after_player_thumb_url,
      'after_player_thumb_background_url':
          instance.after_player_thumb_background_url,
      'after_player_thumb_frame_url': instance.after_player_thumb_frame_url,
      'up_basic_prize_name': instance.up_basic_prize_name,
    };
