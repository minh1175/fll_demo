// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_private_post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPrivatePostData _$ChatPrivatePostDataFromJson(Map<String, dynamic> json) =>
    ChatPrivatePostData(
      message: json['message'] as String?,
      message_image: json['message_image'] as String?,
      image_size_rate: (json['image_size_rate'] as num?)?.toDouble(),
      flg_organizer_call: json['flg_organizer_call'] as int?,
      tournament_round_id: json['tournament_round_id'] as String?,
    );

Map<String, dynamic> _$ChatPrivatePostDataToJson(
        ChatPrivatePostData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'message_image': instance.message_image,
      'image_size_rate': instance.image_size_rate,
      'flg_organizer_call': instance.flg_organizer_call,
      'tournament_round_id': instance.tournament_round_id,
    };
