import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_image_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class UploadImageResponse extends BaseResponse {
  String? thumb_file_name;
  Size? image_size;
  double? image_size_rate;

  UploadImageResponse(
      this.thumb_file_name,
      this.image_size,
      this.image_size_rate);

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageResponseToJson(this);
}

@JsonSerializable()
class Size {
  int? width;
  int? height;

  Size(this.width, this.height);

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

  Map<String, dynamic> toJson() => _$SizeToJson(this);
}
