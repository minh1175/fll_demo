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

class NotificationOtherViewModel extends BaseViewModel {
  static NotificationOtherViewModel? _cache;
  final DataRepository _dataRepo;

  AllNotifyResponse? _response;
  NoticeReadResponse? _readResponse;
  NavigationService _navigationService = getIt<NavigationService>();
  var pageNo = 1;
  int flgLastPage = 0;
  LoadingState loadingState = LoadingState.LOADING;

  List<Tournament> lsOther = [];

  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  factory NotificationOtherViewModel(dataRepo,) {
    if (_cache == null) _cache = new NotificationOtherViewModel._(dataRepo);
    return _cache!;
  }

  void clear() {
    _cache?.dispose();
    _cache = null;
  }

  NotificationOtherViewModel._(this._dataRepo,);

  set response(AllNotifyResponse? response) {
    _response = response;
    notifyListeners();
  }

  set readResponse(NoticeReadResponse? response) {
    _readResponse = response;
    notifyListeners();
  }

  AllNotifyResponse? get response => this._response;
  NoticeReadResponse? get readResponse => this._readResponse;

  Future<void> notificationOtherListApi() async {
    if (flgLastPage == 1) {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      return;
    }

    var params = <String, dynamic>{};
    params.putIfAbsent('page_no', () => pageNo);
    params.putIfAbsent('type', () => 3);
    final subscript = notificationOtherList(params).listen((_) {
      if (response != null && response!.success) {
        if (loadingState != LoadingState.DONE) loadingState = LoadingState.DONE;
        flgLastPage = response?.flg_last_page?? 1;
        if (pageNo == 1) {
          lsOther = response?.list ?? [];
        } else {
          lsOther.addAll(response?.list ?? []);
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
      notifyListeners();
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

  Stream notificationOtherList(Map<String, dynamic> params) => _dataRepo
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
    var item = lsOther[index];
    if (item.flg_unread == 0) return;

    var params = <String, dynamic>{};
    params.putIfAbsent('notice_type', () => 4);
    params.putIfAbsent('push_history_id', () => item.id);
    final subscript = noticeRead(params).listen((_) {
      if (readResponse != null && readResponse!.success) {
        lsOther[index].flg_unread = 0;
        notifyListeners();
        eventBus.fire(UpdateAllNotificationTabBadgeEvent(3, readResponse!.flg_badge_on?? 0));
      }
    });
    addSubscription(subscript);
  }

  Stream noticeRead(Map<String, dynamic> params) => _dataRepo
      .readNotify(params)
      .doOnData((r) => readResponse = NoticeReadResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          readResponse = NoticeReadResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
    EasyLoading.dismiss();
  });

  refreshData() {
    pageNo = 1;
    flgLastPage = 0;
    notificationOtherListApi();
  }
}
