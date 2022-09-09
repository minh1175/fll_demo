import 'package:Gametector/app/module/socket/receive/base_socket_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_notification_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PushNotificationResponse extends BaseSocketResponse {
  bool? is_private;
  String? organizer_unique_id;
  String? image_url;
  String? player_thumb_url;
  int? tournament_chat_id;
  int? type;
  String? organizer_thumb_url;
  String? post_time;
  int? tournament_id;
  int? post_unix_time;
  int? player_id = 0;
  int? user_id = 0;
  int? current_unix_time;
  double? image_size_rate;
  String? player_unique_id;
  String? player_name;
  String? organizer_name;
  int? flg_announce;

  PushNotificationResponse({
    required List<int>? push_type,
    required String? message,
    required int? socket_id,
    required int? status,
    this.is_private,
    this.organizer_unique_id,
    this.image_url,
    this.player_thumb_url,
    this.tournament_chat_id,
    this.type,
    this.organizer_thumb_url,
    this.post_time,
    this.tournament_id,
    this.post_unix_time,
    this.player_id = 0,
    this.user_id = 0,
    this.current_unix_time,
    this.image_size_rate,
    this.player_unique_id,
    this.player_name,
    this.organizer_name,
    this.flg_announce,
  }) : super(
            push_type: push_type,
            message: message,
            socket_id: socket_id,
            status: status);

  factory PushNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PushNotificationResponseToJson(this);
}
