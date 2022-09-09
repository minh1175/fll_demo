import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class NoticeListResponse extends BaseResponse {
  int? flg_badge_on;
  int? badge_count;
  int? current_unix_time;
  @JsonKey(defaultValue: [])
  List<Item>? list;

  NoticeListResponse(this.flg_badge_on, this.badge_count, this.current_unix_time, this.list);

  factory NoticeListResponse.fromJson(Map<String, dynamic> json) => _$NoticeListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeListResponseToJson(this);
}

@JsonSerializable()
class Item {
   int? tournament_round_id;
   int? notice_type;
   String? title;
   String? message;
   String? thumb_url;
   int? flg_unread;
   int? notice_unix_time;
   String? notice_time;

   Item(
       this.tournament_round_id,
       this.notice_type,
       this.title,
       this.message,
       this.thumb_url,
       this.flg_unread,
       this.notice_unix_time,
       this.notice_time,
   );

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
