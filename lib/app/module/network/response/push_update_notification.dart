import 'package:Gametector/app/module/socket/receive/base_socket_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_update_notification.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PushUpdateNotification extends BaseSocketResponse {
  int? tournament_id;
  int? tournament_round_id;

  PushUpdateNotification({
    required List<int>? push_type,
    required String? message,
    required int? socket_id,
    required int? status,
    this.tournament_id,
    this.tournament_round_id,
  }) : super(
            push_type: push_type,
            message: message,
            socket_id: socket_id,
            status: status);

  factory PushUpdateNotification.fromJson(Map<String, dynamic> json) =>
      _$PushUpdateNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$PushUpdateNotificationToJson(this);
}
