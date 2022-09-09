import 'package:Gametector/app/module/socket/receive/base_socket_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_reflect_match_result_bulk.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PushReflectMatchResultBulk extends BaseSocketResponse {
  int? tournament_id;
  List<int>? round_box_no_list;

  PushReflectMatchResultBulk({
    required List<int>? push_type,
    required String? message,
    required int? socket_id,
    required int? status,
    this.tournament_id,
    this.round_box_no_list,
  }) : super(
            push_type: push_type,
            message: message,
            socket_id: socket_id,
            status: status);

  factory PushReflectMatchResultBulk.fromJson(Map<String, dynamic> json) =>
      _$PushReflectMatchResultBulkFromJson(json);

  Map<String, dynamic> toJson() => _$PushReflectMatchResultBulkToJson(this);
}
