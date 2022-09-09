import 'package:json_annotation/json_annotation.dart';

import 'base_socket_response.dart';

part 'already_read_msg_socket_response.g.dart';

@JsonSerializable()
class AlreadyReadMessageSocketResponse extends BaseSocketResponse {
  int? user_id;
  String? thumbnail;

  //chat
  int? tournament_id;
  int? already_read_chat_id;

  //chat private
  int? tournament_round_id;
  int? already_read_private_chat_id;

  AlreadyReadMessageSocketResponse({
      required List<int>? push_type,
      required String? message,
      required int? socket_id,
      required int? status,
      this.user_id,
      this.thumbnail,
      this.tournament_id,
      this.already_read_chat_id,
      this.tournament_round_id,
      this.already_read_private_chat_id})
      : super(push_type: push_type, message: message, socket_id: socket_id, status: status);

  factory AlreadyReadMessageSocketResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AlreadyReadMessageSocketResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AlreadyReadMessageSocketResponseToJson(this);
}
