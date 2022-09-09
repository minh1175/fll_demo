import 'package:json_annotation/json_annotation.dart';

part 'already_read_msg_chat_private_post.g.dart';

@JsonSerializable()
class AlreadyReadMessageChatPrivatePost {
  int? tournament_round_id;
  int? tournament_private_chat_id;

  AlreadyReadMessageChatPrivatePost(
      {this.tournament_round_id, this.tournament_private_chat_id});

  factory AlreadyReadMessageChatPrivatePost.fromJson(
          Map<String, dynamic> json) =>
      _$AlreadyReadMessageChatPrivatePostFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AlreadyReadMessageChatPrivatePostToJson(this);
}