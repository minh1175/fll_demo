import 'package:Gametector/app/module/socket/receive/base_socket_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_update_all_notification_temp.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PushUpdateAllNotificationTemp extends BaseSocketResponse {
   bool is_private;
   int flg_announce;
   int flg_organizer_call;

   PushUpdateAllNotificationTemp({
    required List<int>? push_type,
    required String? message,
    required int? socket_id,
    required int? status,
    this.is_private = false,
    this.flg_announce = 0,
    this.flg_organizer_call = 0,
  }) : super(
            push_type: push_type,
            message: message,
            socket_id: socket_id,
            status: status);

  factory PushUpdateAllNotificationTemp.fromJson(Map<String, dynamic> json) =>
      _$PushUpdateAllNotificationTempFromJson(json);

  Map<String, dynamic> toJson() => _$PushUpdateAllNotificationTempToJson(this);
}
