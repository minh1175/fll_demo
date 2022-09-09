import 'dart:async';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/all_notification_response.dart';
import 'package:Gametector/app/module/network/response/notice_read_response.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class NotificationChatPrivateViewModel extends BaseViewModel {
  static NotificationChatPrivateViewModel? _cache;
  final NavigationService _navigationService = getIt<NavigationService>();
  final DataRepository _dataRepo;
  AllNotifyResponse? _response;
  NoticeReadResponse? _noticeResponse;

  int pageNo = 1;
  int flgLastPage = 0;
  LoadingState loadingState = LoadingState.LOADING;
  List<Tournament> lsData = [];

  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  factory NotificationChatPrivateViewModel(dataRepo,) {
    if (_cache == null) _cache = new NotificationChatPrivateViewModel._(dataRepo);
    return _cache!;
  }

  void clear() {
    _cache?.dispose();
    _cache = null;
  }

  NotificationChatPrivateViewModel._(this._dataRepo,);

  set noticeReadResponse(NoticeReadResponse? response) {
    _noticeResponse = response;
    notifyListeners();
  }

  set response(AllNotifyResponse? response) {
    _response = response;
    notifyListeners();
  }

  NoticeReadResponse? get noticeReadResponse => _noticeResponse;

  AllNotifyResponse? get response => _response;

  Future<void> notificationChatPrivateListApi() async {
    if (flgLastPage == 1) {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      return;
    }

    var params = <String, dynamic>{};
    params.putIfAbsent('page_no', () => pageNo);
    params.putIfAbsent('type', () => 2);
    final subscript = notificationChatPrivateList(params).listen((_) {
      if (response != null && response!.success) {
        if (loadingState != LoadingState.DONE) loadingState = LoadingState.DONE;
        flgLastPage = response?.flg_last_page?? 1;
        if (pageNo == 1) {
          lsData = response?.list ?? [];
        } else {
          lsData.addAll(response?.list ?? []);
        }
        pageNo++;
        eventBus.fire(RefreshAllNotificationBadgeEvent());
      } else {
        if (loadingState != LoadingState.ERROR) loadingState = LoadingState.ERROR;
        _navigationService.gotoErrorPage(message: response?.error_message);
      }
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      notifyListeners();
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

  Stream notificationChatPrivateList(Map<String, dynamic> params) => _dataRepo
      .all(params)
      .doOnData((r) => response = AllNotifyResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          response = AllNotifyResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> noticeReadApi(index) async {
    var item = lsData[index];
    if (item.flg_unread == 0) return;

    var params = <String, dynamic>{};
    params.putIfAbsent('tournament_id', () => item.tournament_id);
    params.putIfAbsent('notice_type', () => 3);
    params.putIfAbsent('tournament_round_id', () => item.tournament_round_id);
    final subscript = noticeRead(params).listen((_) {
      if (noticeReadResponse != null && noticeReadResponse!.success) {
        lsData[index].flg_unread = 0;
        eventBus.fire(UpdateAllNotificationTabBadgeEvent(2, noticeReadResponse!.flg_badge_on?? 0));
        notifyListeners();
      }
    });
    addSubscription(subscript);
  }

  Stream noticeRead(Map<String, dynamic> params) => _dataRepo
      .noticeRead(params)
      .doOnData((r) => noticeReadResponse = NoticeReadResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          print('error');
          noticeReadResponse = NoticeReadResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {});

  refreshData() {
    pageNo = 1;
    flgLastPage = 0;
    notificationChatPrivateListApi();
  }
}
