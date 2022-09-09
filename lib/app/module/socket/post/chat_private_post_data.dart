import 'package:json_annotation/json_annotation.dart';

part 'chat_private_post_data.g.dart';

@JsonSerializable()
class ChatPrivatePostData {
  String? message;
  String? message_image;
  double? image_size_rate;
  int? flg_organizer_call;
  String? tournament_round_id;

  ChatPrivatePostData(
      {this.message,
      this.message_image,
      this.image_size_rate,
      this.flg_organizer_call,
      this.tournament_round_id});

  factory ChatPrivatePostData.fromJson(Map<String, dynamic> json) =>
      _$ChatPrivatePostDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatPrivatePostDataToJson(this);
}
