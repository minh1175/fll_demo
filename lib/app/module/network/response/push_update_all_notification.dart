import 'package:Gametector/app/module/socket/receive/base_socket_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_update_all_notification.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PushUpdateAllNotification extends BaseSocketResponse {
  int? type;
  int? flg_badge_update;

  PushUpdateAllNotification({
    this.type,
    this.flg_badge_update,
  });

  factory PushUpdateAllNotification.fromJson(Map<String, dynamic> json) =>
      _$PushUpdateAllNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$PushUpdateAllNotificationToJson(this);
}
