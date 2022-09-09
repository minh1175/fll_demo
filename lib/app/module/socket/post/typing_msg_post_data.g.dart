// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typing_msg_post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypingMessagePostData _$TypingMessagePostDataFromJson(
        Map<String, dynamic> json) =>
    TypingMessagePostData(
      tournament_id: json['tournament_id'] as String?,
    );

Map<String, dynamic> _$TypingMessagePostDataToJson(
        TypingMessagePostData instance) =>
    <String, dynamic>{
      'tournament_id': instance.tournament_id,
    };

TypingPrivateMessagePostData _$TypingPrivateMessagePostDataFromJson(
        Map<String, dynamic> json) =>
    TypingPrivateMessagePostData(
      tournament_round_id: json['tournament_round_id'] as String?,
    );

Map<String, dynamic> _$TypingPrivateMessagePostDataToJson(
        TypingPrivateMessagePostData instance) =>
    <String, dynamic>{
      'tournament_round_id': instance.tournament_round_id,
    };
