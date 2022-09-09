// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_rank_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentRankListResponse _$TournamentRankListResponseFromJson(
        Map<String, dynamic> json) =>
    TournamentRankListResponse(
      success: json['success'] as bool,
      error_message: json['error_message'] as String,
      ranking_list: (json['ranking_list'] as List<dynamic>?)
              ?.map((e) => RankItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TournamentRankListResponseToJson(
        TournamentRankListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'ranking_list': instance.ranking_list,
    };

RankItem _$RankItemFromJson(Map<String, dynamic> json) => RankItem(
      json['rank'] as int?,
      json['thumb_url'] as String?,
      json['player_name'] as String?,
    );

Map<String, dynamic> _$RankItemToJson(RankItem instance) => <String, dynamic>{
      'rank': instance.rank,
      'thumb_url': instance.thumb_url,
      'player_name': instance.player_name,
    };
