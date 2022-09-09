import 'package:json_annotation/json_annotation.dart';

part 'already_read_msg_chat_post.g.dart';

@JsonSerializable()
class AlreadyReadMessageChatPost {
  int? tournament_id;
  int? tournament_chat_id;

  AlreadyReadMessageChatPost({
    this.tournament_id,
    this.tournament_chat_id,
  });

  factory AlreadyReadMessageChatPost.fromJson(Map<String, dynamic> json) =>
      _$AlreadyReadMessageChatPostFromJson(json);

  Map<String, dynamic> toJson() => _$AlreadyReadMessageChatPostToJson(this);
}

@JsonSerializable()
class AlreadyReadMessagePrivateChatPost {
  int? tournament_round_id;
  int? tournament_private_chat_id;

  AlreadyReadMessagePrivateChatPost({
    this.tournament_round_id,
    this.tournament_private_chat_id,
  });

  factory AlreadyReadMessagePrivateChatPost.fromJson(Map<String, dynamic> json) =>
      _$AlreadyReadMessagePrivateChatPostFromJson(json);

  Map<String, dynamic> toJson() => _$AlreadyReadMessagePrivateChatPostToJson(this);
}
