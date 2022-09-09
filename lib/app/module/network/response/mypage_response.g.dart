// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPageResponse _$MyPageResponseFromJson(Map<String, dynamic> json) =>
    MyPageResponse(
      json['user_name'] as String?,
      json['introduction'] as String?,
      json['twitter_url'] as String?,
      json['twitter_web_url'] as String?,
      json['create_tournament_url'] as String?,
      (json['game_list'] as List<dynamic>?)
              ?.map((e) => Game.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['banner_list'] as List<dynamic>?)
              ?.map((e) => MyPageBanner.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$MyPageResponseToJson(MyPageResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'user_name': instance.user_name,
      'introduction': instance.introduction,
      'twitter_url': instance.twitter_url,
      'twitter_web_url': instance.twitter_web_url,
      'create_tournament_url': instance.create_tournament_url,
      'game_list': instance.game_list,
      'banner_list': instance.banner_list,
    };

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['game_title_name'] as String?,
      json['game_title_id'] as int?,
      json['game_thumb_url'] as String?,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'game_title_name': instance.game_title_name,
      'game_title_id': instance.game_title_id,
      'game_thumb_url': instance.game_thumb_url,
    };

MyPageBanner _$MyPageBannerFromJson(Map<String, dynamic> json) => MyPageBanner(
      json['thumb_url'] as String?,
      json['web_url'] as String?,
    );

Map<String, dynamic> _$MyPageBannerToJson(MyPageBanner instance) =>
    <String, dynamic>{
      'thumb_url': instance.thumb_url,
      'web_url': instance.web_url,
    };
