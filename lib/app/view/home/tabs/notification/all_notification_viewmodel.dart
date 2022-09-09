import 'dart:async';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/all_notification_response.dart';
import 'package:Gametector/app/module/network/response/get_setting_response.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AllNotificationViewModel extends BaseViewModel {
  static AllNotificationViewModel? _cache;
  NavigationService _navigationService = getIt<NavigationService>();
  final DataRepository _dataRepo;
  GetSettingResponse? _response;
  AllNotifyResponse? _notifyResponse;

  List<Item> lsItem = [];
  bool flgBadgeOn = false;

  List<int> tabBadgeCount = [0, 0, 0];


  late TabController tabController;

  factory AllNotificationViewModel(dataRepo,) {
    if (_cache == null) _cache = new AllNotificationViewModel._(dataRepo);
    return _cache!;
  }

  void clear() {
    _cache?.dispose();
    _cache = null;
  }

  AllNotificationViewModel._(this._dataRepo,) {
    addSubscription(
        eventBus.on<RefreshAllNotificationBadgeEvent>().listen((event) {
          badgeCountApi();
        })
    );

    addSubscription(
        eventBus.on<UpdateAllNotificationTabBadgeEvent>().listen((event) {
          tabBadgeCount[event.type - 1] = event.badgeCount;
          flgBadgeOn = tabBadgeCount.reduce((a, b) => a + b) > 0;
          notifyListeners();
        })
    );
  }

  set response(GetSettingResponse? response) {
    _response = response;
    notifyListeners();
  }

  GetSettingResponse? get response => this._response;

  set notifyResponse(AllNotifyResponse? response) {
    _notifyResponse = response;
    notifyListeners();
  }

  AllNotifyResponse? get notifyResponse => this._notifyResponse;

  Stream getSetting() => _dataRepo
      .setting()
      .doOnData((r) => response = GetSettingResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        print(e.toString());
        if (e is DioError) {
          response = GetSettingResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> settingAPI() async {
    final subscript = this.getSetting().listen((_) {
      if (response != null && response!.success) {
        lsItem.addAll(response?.list ?? []);
      } else
        _navigationService.gotoErrorPage(message: response?.error_message);
    }, onError: (e) {
      notifyListeners();
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream badgeCount() => _dataRepo
      .badgeCount()
      .doOnData((r) => notifyResponse = AllNotifyResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        print(e.toString());
        if (e is DioError) {
          notifyResponse =
              AllNotifyResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> badgeCountApi() async {
    final subscript = this.badgeCount().listen((_) {
      if (notifyResponse != null && notifyResponse!.success) {
        tabBadgeCount[0] = notifyResponse?.flg_chat_badge_on?? 0;
        tabBadgeCount[1] = notifyResponse?.flg_private_chat_badge_on?? 0;
        tabBadgeCount[2] = notifyResponse?.flg_other_badge_on?? 0;
        flgBadgeOn = tabBadgeCount.reduce((a, b) => a + b) > 0;
        notifyListeners();
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  void init(TabController controller) {
    badgeCountApi();
    tabController = controller;
    notifyListeners();
    final int initialIndex = _navigationService.allNotificationTabIndexFromPush;
    if (initialIndex != -1) {
      tabController.animateTo(initialIndex);
      _navigationService.allNotificationTabIndexFromPush = -1;
    }
  }
}
