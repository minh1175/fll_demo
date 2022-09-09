// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadImageResponse _$UploadImageResponseFromJson(Map<String, dynamic> json) =>
    UploadImageResponse(
      json['thumb_file_name'] as String?,
      json['image_size'] == null
          ? null
          : Size.fromJson(json['image_size'] as Map<String, dynamic>),
      (json['image_size_rate'] as num?)?.toDouble(),
    )
      ..success = json['success'] as bool
      ..error_message = json['error_message'] as String;

Map<String, dynamic> _$UploadImageResponseToJson(
        UploadImageResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error_message': instance.error_message,
      'thumb_file_name': instance.thumb_file_name,
      'image_size': instance.image_size,
      'image_size_rate': instance.image_size_rate,
    };

Size _$SizeFromJson(Map<String, dynamic> json) => Size(
      json['width'] as int?,
      json['height'] as int?,
    );

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };
