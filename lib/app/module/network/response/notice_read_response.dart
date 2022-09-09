import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice_read_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class NoticeReadResponse extends BaseResponse {

   int? flg_badge_on;
   int? badge_count;

   NoticeReadResponse(this.flg_badge_on, this.badge_count);

  factory NoticeReadResponse.fromJson(Map<String, dynamic> json) =>
      _$NoticeReadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeReadResponseToJson(this);
}