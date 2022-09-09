import 'package:Gametector/app/module/socket/receive/base_socket_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_reflect_match_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PushReflectMatchResult extends BaseSocketResponse {
  int? tournament_id;
  int? round_box_no;

  PushReflectMatchResult({
    required List<int>? push_type,
    required String? message,
    required int? socket_id,
    required int? status,
    this.tournament_id,
    this.round_box_no,
  }) : super(
            push_type: push_type,
            message: message,
            socket_id: socket_id,
            status: status);

  factory PushReflectMatchResult.fromJson(Map<String, dynamic> json) =>
      _$PushReflectMatchResultFromJson(json);

  Map<String, dynamic> toJson() => _$PushReflectMatchResultToJson(this);
}
