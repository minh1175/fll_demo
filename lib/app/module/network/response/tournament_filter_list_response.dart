import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tournament_filter_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class TournamentFilterListResponse extends BaseResponse {
  @JsonKey(defaultValue: [])
  List<Filter>? filter_menu_list;

  TournamentFilterListResponse({
    required bool success,
    required String error_message,
    this.filter_menu_list,
  }) : super(success: success, error_message: error_message);

  factory TournamentFilterListResponse.fromJson(Map<String, dynamic> json) =>
      _$TournamentFilterListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentFilterListResponseToJson(this);
}

@JsonSerializable()
class Filter {
  int? type;
  String? title;

  Filter({this.type, this.title});

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}
