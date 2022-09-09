import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_info_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ProfileInfoResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<ProfileItem>? location_list;
  @JsonKey(defaultValue: [])
  List<ProfileItem>? birth_year_list;
  @JsonKey(defaultValue: [])
  List<ProfileItem>? birth_month_list;
  @JsonKey(defaultValue: [])
  List<ProfileItem>? birth_day_list;
  String? location;
  String? birth_year;
  String? birth_month;
  String? birth_day;
  String? introduction;
  String? user_name;

  ProfileInfoResponse(
      this.location_list,
      this.birth_year_list,
      this.birth_month_list,
      this.birth_day_list,
      this.location,
      this.birth_year,
      this.birth_month,
      this.birth_day,
      this.introduction,
      this.user_name);

  factory ProfileInfoResponse.fromJson(Map<String, dynamic> json) => _$ProfileInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileInfoResponseToJson(this);
}

@JsonSerializable()
class ProfileItem {
  String? display;
  String? value;

  ProfileItem(this.display, this.value);

  factory ProfileItem.fromJson(Map<String, dynamic> json) => _$ProfileItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileItemToJson(this);
}
