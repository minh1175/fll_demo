import 'package:json_annotation/json_annotation.dart';

part 'typing_msg_post_data.g.dart';

@JsonSerializable()
class TypingMessagePostData {
  String? tournament_id;

  TypingMessagePostData({this.tournament_id});

  factory TypingMessagePostData.fromJson(Map<String, dynamic> json) =>
      _$TypingMessagePostDataFromJson(json);

  Map<String, dynamic> toJson() => _$TypingMessagePostDataToJson(this);
}

@JsonSerializable()
class TypingPrivateMessagePostData {
  String? tournament_round_id;

  TypingPrivateMessagePostData({this.tournament_round_id});

  factory TypingPrivateMessagePostData.fromJson(Map<String, dynamic> json) =>
      _$TypingPrivateMessagePostDataFromJson(json);

  Map<String, dynamic> toJson() => _$TypingPrivateMessagePostDataToJson(this);
}
