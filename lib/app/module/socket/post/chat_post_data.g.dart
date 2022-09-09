// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPostData _$ChatPostDataFromJson(Map<String, dynamic> json) => ChatPostData(
      message: json['message'] as String?,
      message_image: json['message_image'] as String?,
      image_size_rate: (json['image_size_rate'] as num?)?.toDouble(),
      flg_announce: json['flg_announce'] as int?,
      tournament_id: json['tournament_id'] as String?,
    );

Map<String, dynamic> _$ChatPostDataToJson(ChatPostData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'message_image': instance.message_image,
      'image_size_rate': instance.image_size_rate,
      'flg_announce': instance.flg_announce,
      'tournament_id': instance.tournament_id,
    };
