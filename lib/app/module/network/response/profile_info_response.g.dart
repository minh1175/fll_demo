// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileInfoResponse _$ProfileInfoResponseFromJson(Map<String, dynamic> json) =>
    ProfileInfoResponse(
      (json['location_list'] as List<dynamic>?)
              ?.map((e) => ProfileItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['birth_year_list'] as List<dynamic>?)
              ?.map((e) => ProfileItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['birth_month_list'] as List<dynamic>?)
              ?.map((e) => ProfileItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['birth_day_list'] as List<dynamic>?)
              ?.map((e) => ProfileItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['location'] as String?,
      json['birth_year'] as String?,
      json['birth_month'] as String?,
      json['birth_day'] as String?,
      json['introduction'] as String?,
      json['user_name'] as String?,
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$ProfileInfoResponseToJson(
        ProfileInfoResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'location_list': instance.location_list,
      'birth_year_list': instance.birth_year_list,
      'birth_month_list': instance.birth_month_list,
      'birth_day_list': instance.birth_day_list,
      'location': instance.location,
      'birth_year': instance.birth_year,
      'birth_month': instance.birth_month,
      'birth_day': instance.birth_day,
      'introduction': instance.introduction,
      'user_name': instance.user_name,
    };

ProfileItem _$ProfileItemFromJson(Map<String, dynamic> json) => ProfileItem(
      json['display'] as String?,
      json['value'] as String?,
    );

Map<String, dynamic> _$ProfileItemToJson(ProfileItem instance) =>
    <String, dynamic>{
      'display': instance.display,
      'value': instance.value,
    };
