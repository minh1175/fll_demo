class BaseResponse {
  bool success;
  String error_message;

  BaseResponse({this.success = false, this.error_message = ''});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
        success: json["success"], error_message: json["error_message"]);
  }
}
