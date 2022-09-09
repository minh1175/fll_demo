import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/tournament_filter_list_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';

class TournamentHomeViewModel extends BaseViewModel {
  static Map<String, TournamentHomeViewModel?>? _cache;
  final DataRepository _dataRepo;
  int tabType = 2; /*1: 主催者（organizer）、2：選手（player）*/
  late TournamentFilterListResponse _response;
  NavigationService _navigationService = getIt<NavigationService>();
  List<Filter> lsFilter = [];

  // TODO : confirm whether this code is ok or ng.
  factory TournamentHomeViewModel(dataRepo, {tabType}) {
    var key = tabType.toString();
    // reset
    if (tabType == 0) _cache = null;
    if (_cache == null) _cache = {};
    if (_cache!.containsKey(key) == false) {
      _cache![key] = new TournamentHomeViewModel._(dataRepo, tabType: tabType);
    }
    return _cache![key]!;
  }

  TournamentHomeViewModel._(this._dataRepo, {this.tabType = 2});

  set response(TournamentFilterListResponse response) {
    _response = response;
    notifyListeners();
  }

  TournamentFilterListResponse get response => _response;

  Stream filterMenuList(Map<String, dynamic> params) => _dataRepo
      .filterMenuList(params)
      .doOnData((r) => response = TournamentFilterListResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          response = TournamentFilterListResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {
      })
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> filterMenuListApi() async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tab_type', () => tabType);
    final subscript = this.filterMenuList(params).listen((_) {
      if (response.success) {
        lsFilter = response.filter_menu_list ?? [];
        notifyListeners();
      } else {
        _navigationService.gotoErrorPage(message: response.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }
}