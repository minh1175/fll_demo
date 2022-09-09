// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_socket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseSocketResponse _$BaseSocketResponseFromJson(Map<String, dynamic> json) =>
    BaseSocketResponse(
      push_type:
          (json['push_type'] as List<dynamic>?)?.map((e) => e as int).toList(),
      message: json['message'] as String?,
      socket_id: json['socket_id'] as int?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$BaseSocketResponseToJson(BaseSocketResponse instance) =>
    <String, dynamic>{
      'push_type': instance.push_type,
      'message': instance.message,
      'socket_id': instance.socket_id,
      'status': instance.status,
    };
