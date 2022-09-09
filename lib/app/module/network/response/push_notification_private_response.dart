import 'package:Gametector/app/module/socket/receive/base_socket_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_notification_private_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PushNotificationPrivateResponse extends BaseSocketResponse {
  bool? is_private;
  int? type;
  String? image_url;
  double? image_size_rate;
  String? post_time;
  int? post_unix_time;
  int? current_unix_time;
  int? player_id = 0;
  String? player_unique_id;
  String? player_name;
  String? player_thumb_url;
  int? tournament_private_chat_id;
  int? tournament_id;
  int? tournament_round_id;
  int? user_id = 0;
  int? flg_organizer_call;

  PushNotificationPrivateResponse({
    required List<int>? push_type,
    required String? message,
    required int? socket_id,
    required int? status,
    this.is_private,
    this.type,
    this.image_url,
    this.image_size_rate,
    this.post_time,
    this.post_unix_time,
    this.player_id,
    this.player_unique_id,
    this.player_name,
    this.player_thumb_url,
    this.tournament_private_chat_id,
    this.tournament_id,
    this.tournament_round_id,
    this.user_id,
    this.flg_organizer_call,
  }) : super(
            push_type: push_type,
            message: message,
            socket_id: socket_id,
            status: status);

  factory PushNotificationPrivateResponse.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationPrivateResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PushNotificationPrivateResponseToJson(this);
}
