import 'package:json_annotation/json_annotation.dart';
part 'base_socket_response.g.dart';

@JsonSerializable()
class BaseSocketResponse {
  List<int>? push_type;
  String? message;
  int? socket_id;
  int? status;

  BaseSocketResponse({
    this.push_type,
    this.message,
    this.socket_id,
    this.status
}
      );

  factory BaseSocketResponse.fromJson(
      Map<String, dynamic> json) =>
      _$BaseSocketResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$BaseSocketResponseToJson(this);

}
