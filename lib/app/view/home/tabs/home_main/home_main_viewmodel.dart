import 'dart:core';
import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/home_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeMainViewModel extends BaseViewModel {
  static HomeMainViewModel? _cache;
  final DataRepository _dataRepo;
  final String appToken = getIt<UserSharePref>().getAppToken();
  final NavigationService _navigationService = getIt<NavigationService>();
  late HomeResponse _response;
  List<ItemGame> gameThumbs = [];
  int selectedGameTitleId = -1;
  int selectedIdx = 0;
  bool isFinishLoad = false;
  late WebViewController webViewController;

  factory HomeMainViewModel(dataRepo,) {
    if (_cache == null) _cache = new HomeMainViewModel._(dataRepo);
    return _cache!;
  }

  void clear() {
    _cache?.dispose();
    _cache = null;
  }

  HomeMainViewModel._(this._dataRepo,);

  set response(HomeResponse response) {
    _response = response;
    notifyListeners();
  }

  HomeResponse get response => _response;

  Stream home() => _dataRepo
      .home()
      .doOnData((r) => response = HomeResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          response = HomeResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> homeApi() async {
    final subscript = this.home().listen((_) {
      if (response.success) {
        gameThumbs = response.game_thumb_list ?? [];
        if (gameThumbs.length > selectedIdx) {
          selectedGameTitleId = gameThumbs[selectedIdx].game_title_id!;
        }
      } else {
        _navigationService.gotoErrorPage(message: response.error_message);
      }
      notifyListeners();
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  void changeGameTitleId(gameTitleId, idx) {
    if (gameTitleId != selectedGameTitleId) {
      selectedIdx = idx;
      selectedGameTitleId = gameTitleId;
      isFinishLoad = false;
      notifyListeners();
      webViewController.loadUrl(getWebviewUrl());
    }
  }

  String getWebviewUrl() {
    String url = URL_HOME.replaceAll('{gameTitleId}', selectedGameTitleId.toString()) + '&device=flutter&app_token=${appToken}';
    return url;
  }

  void setWebviewController(WebViewController controller) {
    webViewController = controller;
    notifyListeners();
  }

  void finishWebviewLoad() {
    this.isFinishLoad = true;
    notifyListeners();
  }
}
