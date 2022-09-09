// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_game_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPageGameResponse _$MyPageGameResponseFromJson(Map<String, dynamic> json) =>
    MyPageGameResponse(
      json['selected_sort_name'] as String?,
      (json['sort_type_list'] as List<dynamic>)
          .map((e) => SortType.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['game_info'] == null
          ? null
          : GameInfo.fromJson(json['game_info'] as Map<String, dynamic>),
      json['user_info'] == null
          ? null
          : UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
      json['gt_rate'] == null
          ? null
          : GTRate.fromJson(json['gt_rate'] as Map<String, dynamic>),
      json['gt_score'] == null
          ? null
          : GTScore.fromJson(json['gt_score'] as Map<String, dynamic>),
      (json['number_list'] as List<dynamic>?)
          ?.map((e) => Number.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['badge_list'] as List<dynamic>?)
          ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['team_number_list'] as List<dynamic>?)
          ?.map((e) => TeamNumber.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['consecutive_win'] == null
          ? null
          : ConsecutiveWin.fromJson(
              json['consecutive_win'] as Map<String, dynamic>),
      json['score_number'] == null
          ? null
          : ScoreNumber.fromJson(json['score_number'] as Map<String, dynamic>),
      json['loss_number'] == null
          ? null
          : LossNumber.fromJson(json['loss_number'] as Map<String, dynamic>),
      (json['extension_list'] as List<dynamic>?)
          ?.map((e) => Extension.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['organizer_prize'] == null
          ? null
          : OrganizerPrize.fromJson(
              json['organizer_prize'] as Map<String, dynamic>),
      json['tournament_number'] == null
          ? null
          : TournamentNumber.fromJson(
              json['tournament_number'] as Map<String, dynamic>),
      json['entry_number'] == null
          ? null
          : EntryNumber.fromJson(json['entry_number'] as Map<String, dynamic>),
      json['match_number'] == null
          ? null
          : MatchNumber.fromJson(json['match_number'] as Map<String, dynamic>),
      json['tournament_scale'] == null
          ? null
          : TournamentScale.fromJson(
              json['tournament_scale'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$MyPageGameResponseToJson(MyPageGameResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'selected_sort_name': instance.selected_sort_name,
      'sort_type_list': instance.sort_type_list,
      'game_info': instance.game_info,
      'user_info': instance.user_info,
      'gt_rate': instance.gt_rate,
      'gt_score': instance.gt_score,
      'number_list': instance.number_list,
      'badge_list': instance.badge_list,
      'team_number_list': instance.team_number_list,
      'consecutive_win': instance.consecutive_win,
      'score_number': instance.score_number,
      'loss_number': instance.loss_number,
      'extension_list': instance.extension_list,
      'organizer_prize': instance.organizer_prize,
      'tournament_number': instance.tournament_number,
      'entry_number': instance.entry_number,
      'match_number': instance.match_number,
      'tournament_scale': instance.tournament_scale,
    };

SortType _$SortTypeFromJson(Map<String, dynamic> json) => SortType(
      json['sort_name'] as String?,
      json['sort_type'] as int?,
    );

Map<String, dynamic> _$SortTypeToJson(SortType instance) => <String, dynamic>{
      'sort_name': instance.sort_name,
      'sort_type': instance.sort_type,
    };

TournamentNumber _$TournamentNumberFromJson(Map<String, dynamic> json) =>
    TournamentNumber(
      json['value'] as int?,
      json['clickable'] as bool?,
      json['url'] as String?,
    );

Map<String, dynamic> _$TournamentNumberToJson(TournamentNumber instance) =>
    <String, dynamic>{
      'value': instance.value,
      'clickable': instance.clickable,
      'url': instance.url,
    };

EntryNumber _$EntryNumberFromJson(Map<String, dynamic> json) => EntryNumber(
      json['value'] as int?,
    );

Map<String, dynamic> _$EntryNumberToJson(EntryNumber instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

MatchNumber _$MatchNumberFromJson(Map<String, dynamic> json) => MatchNumber(
      json['value'] as int?,
    );

Map<String, dynamic> _$MatchNumberToJson(MatchNumber instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

TournamentScale _$TournamentScaleFromJson(Map<String, dynamic> json) =>
    TournamentScale(
      json['max_value'] as int?,
      json['ave_value'] as int?,
    );

Map<String, dynamic> _$TournamentScaleToJson(TournamentScale instance) =>
    <String, dynamic>{
      'max_value': instance.max_value,
      'ave_value': instance.ave_value,
    };

OrganizerPrize _$OrganizerPrizeFromJson(Map<String, dynamic> json) =>
    OrganizerPrize(
      json['value_en'] as String?,
      json['value_ja'] as String?,
      json['percent'] as int?,
      json['clickable'] as bool?,
      json['url'] as String?,
    );

Map<String, dynamic> _$OrganizerPrizeToJson(OrganizerPrize instance) =>
    <String, dynamic>{
      'value_en': instance.value_en,
      'value_ja': instance.value_ja,
      'percent': instance.percent,
      'clickable': instance.clickable,
      'url': instance.url,
    };

GameInfo _$GameInfoFromJson(Map<String, dynamic> json) => GameInfo(
      json['game_title_name'] as String?,
      json['game_thumb_url'] as String?,
      json['sub_text'] as String?,
    );

Map<String, dynamic> _$GameInfoToJson(GameInfo instance) => <String, dynamic>{
      'game_title_name': instance.game_title_name,
      'game_thumb_url': instance.game_thumb_url,
      'sub_text': instance.sub_text,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['user_thumb_url'] as String?,
      json['user_thumb_background_url'] as String?,
      json['user_thumb_frame_url'] as String?,
      json['user_name'] as String?,
      json['twitter_screen_name'] as String?,
      json['introduction'] as String?,
      json['url_twitter'] as String?,
      json['url_web_twitter'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'user_thumb_url': instance.user_thumb_url,
      'user_thumb_background_url': instance.user_thumb_background_url,
      'user_thumb_frame_url': instance.user_thumb_frame_url,
      'user_name': instance.user_name,
      'twitter_screen_name': instance.twitter_screen_name,
      'introduction': instance.introduction,
      'url_twitter': instance.url_twitter,
      'url_web_twitter': instance.url_web_twitter,
    };

GTRate _$GTRateFromJson(Map<String, dynamic> json) => GTRate(
      json['value'] as int?,
      json['rank'] as String?,
      json['max_value'] as int?,
      json['percent'] as int?,
      json['clickable'] as bool?,
      json['url'] as String?,
    );

Map<String, dynamic> _$GTRateToJson(GTRate instance) => <String, dynamic>{
      'value': instance.value,
      'rank': instance.rank,
      'max_value': instance.max_value,
      'percent': instance.percent,
      'clickable': instance.clickable,
      'url': instance.url,
    };

GTScore _$GTScoreFromJson(Map<String, dynamic> json) => GTScore(
      json['value'] as int?,
      json['rank'] as int?,
      json['up_down'] as String?,
      json['percent'] as int?,
      json['clickable'] as bool?,
      json['url'] as String?,
    );

Map<String, dynamic> _$GTScoreToJson(GTScore instance) => <String, dynamic>{
      'value': instance.value,
      'rank': instance.rank,
      'up_down': instance.up_down,
      'percent': instance.percent,
      'clickable': instance.clickable,
      'url': instance.url,
    };

Number _$NumberFromJson(Map<String, dynamic> json) => Number(
      json['title'] as String?,
      json['value'] as int?,
      json['clickable'] as bool?,
      json['url'] as String?,
    );

Map<String, dynamic> _$NumberToJson(Number instance) => <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
      'clickable': instance.clickable,
      'url': instance.url,
    };

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      json['title'] as String?,
      json['thumb_file_url'] as String?,
      json['acquisition_date'] as String?,
      json['category'] as String?,
      json['game_cover_url'] as String?,
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'title': instance.title,
      'thumb_file_url': instance.thumb_file_url,
      'acquisition_date': instance.acquisition_date,
      'category': instance.category,
      'game_cover_url': instance.game_cover_url,
    };

TeamNumber _$TeamNumberFromJson(Map<String, dynamic> json) => TeamNumber(
      json['title'] as String?,
      json['value'] as int?,
      json['clickable'] as bool?,
      json['url'] as String?,
    );

Map<String, dynamic> _$TeamNumberToJson(TeamNumber instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
      'clickable': instance.clickable,
      'url': instance.url,
    };

ConsecutiveWin _$ConsecutiveWinFromJson(Map<String, dynamic> json) =>
    ConsecutiveWin(
      json['value'] as int?,
      json['max_value'] as int?,
    );

Map<String, dynamic> _$ConsecutiveWinToJson(ConsecutiveWin instance) =>
    <String, dynamic>{
      'value': instance.value,
      'max_value': instance.max_value,
    };

ScoreNumber _$ScoreNumberFromJson(Map<String, dynamic> json) => ScoreNumber(
      json['value'] as int?,
      json['ave_value'] as int?,
    );

Map<String, dynamic> _$ScoreNumberToJson(ScoreNumber instance) =>
    <String, dynamic>{
      'value': instance.value,
      'ave_value': instance.ave_value,
    };

LossNumber _$LossNumberFromJson(Map<String, dynamic> json) => LossNumber(
      json['value'] as int?,
      json['ave_value'] as int?,
    );

Map<String, dynamic> _$LossNumberToJson(LossNumber instance) =>
    <String, dynamic>{
      'value': instance.value,
      'ave_value': instance.ave_value,
    };

Extension _$ExtensionFromJson(Map<String, dynamic> json) => Extension(
      json['title'] as String?,
      (json['thumb_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      json['clickable'] as bool?,
      json['url'] as String?,
    );

Map<String, dynamic> _$ExtensionToJson(Extension instance) => <String, dynamic>{
      'title': instance.title,
      'thumb_list': instance.thumb_list,
      'clickable': instance.clickable,
      'url': instance.url,
    };
