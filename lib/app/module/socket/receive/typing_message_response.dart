import 'package:json_annotation/json_annotation.dart';

import 'base_socket_response.dart';

part 'typing_message_response.g.dart';

@JsonSerializable()
class TypingMessageResponse extends BaseSocketResponse {
  String? display_name;
  String? display_thumbnail;
  String? post_current_time;
  String? tournament_id;
  String? tournament_round_id;

  TypingMessageResponse({
    required List<int>? push_type,
    required String? message,
    required int? socket_id,
    required int? status,
    this.display_name,
    this.display_thumbnail,
    this.post_current_time,
    this.tournament_id,
    this.tournament_round_id,
  }) : super(
            push_type: push_type,
            message: message,
            socket_id: socket_id,
            status: status);

  factory TypingMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$TypingMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TypingMessageResponseToJson(this);
}
