import 'package:json_annotation/json_annotation.dart';

part 'chat_post_data.g.dart';

@JsonSerializable()
class ChatPostData {
  String? message;
  String? message_image;
  double? image_size_rate;
  int? flg_announce;
  String? tournament_id;

  ChatPostData({this.message, this.message_image, this.image_size_rate,this.flg_announce, this.tournament_id});

  factory ChatPostData.fromJson(Map<String, dynamic> json) =>
      _$ChatPostDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatPostDataToJson(this);
}