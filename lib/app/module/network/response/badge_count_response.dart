import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'badge_count_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BadgeCountResponse extends BaseResponse {
   int? flg_chat_badge_on;
   int? flg_private_chat_badge_on;
   int? chat_badge_count;
   int? private_chat_badge_count;
   int? flg_other_badge_on;
   int? other_badge_count;

   BadgeCountResponse(
      this.flg_chat_badge_on,
      this.flg_private_chat_badge_on,
      this.chat_badge_count,
      this.private_chat_badge_count,
      this.flg_other_badge_on,
      this.other_badge_count);
}