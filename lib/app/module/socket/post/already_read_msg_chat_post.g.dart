// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'already_read_msg_chat_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlreadyReadMessageChatPost _$AlreadyReadMessageChatPostFromJson(
        Map<String, dynamic> json) =>
    AlreadyReadMessageChatPost(
      tournament_id: json['tournament_id'] as int?,
      tournament_chat_id: json['tournament_chat_id'] as int?,
    );

Map<String, dynamic> _$AlreadyReadMessageChatPostToJson(
        AlreadyReadMessageChatPost instance) =>
    <String, dynamic>{
      'tournament_id': instance.tournament_id,
      'tournament_chat_id': instance.tournament_chat_id,
    };

AlreadyReadMessagePrivateChatPost _$AlreadyReadMessagePrivateChatPostFromJson(
        Map<String, dynamic> json) =>
    AlreadyReadMessagePrivateChatPost(
      tournament_round_id: json['tournament_round_id'] as int?,
      tournament_private_chat_id: json['tournament_private_chat_id'] as int?,
    );

Map<String, dynamic> _$AlreadyReadMessagePrivateChatPostToJson(
        AlreadyReadMessagePrivateChatPost instance) =>
    <String, dynamic>{
      'tournament_round_id': instance.tournament_round_id,
      'tournament_private_chat_id': instance.tournament_private_chat_id,
    };
