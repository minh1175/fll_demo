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

class NotificationChatViewModel extends BaseViewModel {
  static NotificationChatViewModel? _cache;
  final NavigationService _navigationService = getIt<NavigationService>();
  final DataRepository _dataRepo;
  AllNotifyResponse? _notifyResponse;
  NoticeReadResponse? _readResponse;

  var pageNo = 1;
  int flgLastPage = 0;
  LoadingState loadingState = LoadingState.LOADING;
  List<Tournament> lsData = [];

  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  factory NotificationChatViewModel(dataRepo,) {
    if (_cache == null) _cache = new NotificationChatViewModel._(dataRepo);
    return _cache!;
  }

  void clear() {
    _cache?.dispose();
    _cache = null;
  }

  NotificationChatViewModel._(this._dataRepo,);

  set notifyResponse(AllNotifyResponse? notifyResponse) {
    _notifyResponse = notifyResponse;
    notifyListeners();
  }

  AllNotifyResponse? get notifyResponse => this._notifyResponse;

  set readResponse(NoticeReadResponse? response) {
    _readResponse = response;
    notifyListeners();
  }

  NoticeReadResponse? get readResponse => this._readResponse;

  Stream notificationChatList(Map<String, dynamic> params) => _dataRepo
      .all(params)
      .doOnData((r) => notifyResponse = AllNotifyResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    print(e.toString());
    if (e is DioError) {
      notifyResponse = AllNotifyResponse.fromJson(e.response?.data.trim() ?? '');
    }
  })
      .doOnListen(() {})
      .doOnDone(() {
    EasyLoading.dismiss();
  });

  Future<void> notificationChatListApi() async {
    if (flgLastPage == 1) {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      return;
    }

    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('page_no', () => pageNo);
    params.putIfAbsent('type', () => 1);
    final subscript = this.notificationChatList(params).listen((_) {
      if (notifyResponse != null && notifyResponse!.success) {
        if (loadingState != LoadingState.DONE) loadingState = LoadingState.DONE;
        flgLastPage = notifyResponse?.flg_last_page?? 1;
        if (pageNo == 1) {
          lsData = notifyResponse?.list ?? [];
        } else {
          lsData.addAll(notifyResponse?.list ?? []);
        }
        eventBus.fire(RefreshAllNotificationBadgeEvent());
        pageNo++;
      } else {
        if (loadingState != LoadingState.ERROR) loadingState = LoadingState.ERROR;
        _navigationService.gotoErrorPage(message: notifyResponse?.error_message);
      }
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      notifyListeners();
    }, onError: (e) {
      notifyListeners();
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Future<void> noticeReadApi(index) async {
    var item = lsData[index];
    if (item.flg_unread == 0) return;

    var params = <String, dynamic>{};
    params.putIfAbsent('notice_type', () => item.notice_type == 1 ? 1 : 2);
    params.putIfAbsent('tournament_id', () => item.tournament_id);
    final subscript = noticeRead(params).listen((_) {
      if (readResponse != null && readResponse!.success) {
        lsData[index].flg_unread = 0;
        notifyListeners();
        eventBus.fire(UpdateAllNotificationTabBadgeEvent(1, readResponse!.flg_badge_on?? 0));
      }
    });
    addSubscription(subscript);
  }

  Stream noticeRead(Map<String, dynamic> params) => _dataRepo
      .readNotify(params)
      .doOnData((r) => readResponse = NoticeReadResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      readResponse =
          NoticeReadResponse.fromJson(e.response?.data.trim() ?? '');
    }
  })
      .doOnListen(() {})
      .doOnDone(() {
    EasyLoading.dismiss();
  });

  refreshData() {
    pageNo = 1;
    flgLastPage = 0;
    notificationChatListApi();
  }
}