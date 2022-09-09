import 'package:Gametector/app/module/socket/receive/base_socket_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_update_match_board.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PushUpdateMatchBoard extends BaseSocketResponse {
  int? tournament_id;

  PushUpdateMatchBoard({
    required List<int>? push_type,
    required String? message,
    required int? socket_id,
    required int? status,
    this.tournament_id,
  }) : super(
    push_type: push_type,
    message: message,
    socket_id: socket_id,
    status: status,
  );

  factory PushUpdateMatchBoard.fromJson(Map<String, dynamic> json) =>
      _$PushUpdateMatchBoardFromJson(json);

  Map<String, dynamic> toJson() => _$PushUpdateMatchBoardToJson(this);
}
