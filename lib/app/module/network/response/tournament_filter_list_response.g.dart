// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_filter_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentFilterListResponse _$TournamentFilterListResponseFromJson(
        Map<String, dynamic> json) =>
    TournamentFilterListResponse(
      success: json['success'] as bool,
      error_message: json['error_message'] as String,
      filter_menu_list: (json['filter_menu_list'] as List<dynamic>?)
              ?.map((e) => Filter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TournamentFilterListResponseToJson(
        TournamentFilterListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'filter_menu_list': instance.filter_menu_list,
    };

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      type: json['type'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
    };
