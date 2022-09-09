import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/notice_list_response.dart' as notice_list_response;
import 'package:Gametector/app/module/network/response/announce_list_response.dart' as announce_list_response;
import 'package:Gametector/app/module/network/response/notice_read_response.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/main.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class NotificationViewModel extends BaseViewModel {
  NavigationService _navigationService = getIt<NavigationService>();
  final DataRepository _dataRepo;
  late notice_list_response.NoticeListResponse _responseNoticeList;
  late announce_list_response.AnnounceListResponse _responseAnnounceList;
  NoticeReadResponse? _readResponse;
  List<notice_list_response.Item> lsItem = [];
  List<announce_list_response.Item> lsAnnounce = [];
  late int tournamentId;
  LoadingState loadingState = LoadingState.LOADING;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  static Map<String, NotificationViewModel?>? _cache;
  // TODO : confirm whether this code is ok or ng.
  factory NotificationViewModel(dataRepo, {tournamentId}) {
    var key = tournamentId.toString();
    // reset
    if (tournamentId == 0) _cache = null;
    if (_cache == null) _cache = {};
    if (_cache!.containsKey(key) == false) {
      _cache![key] = new NotificationViewModel._(dataRepo, tournamentId: tournamentId);
    }
    return _cache![key]!;
  }

  NotificationViewModel._(this._dataRepo, {this.tournamentId=0});

  set responseNoticeList(notice_list_response.NoticeListResponse response) {
    _responseNoticeList = response;
    notifyListeners();
  }

  set responseAnnounceList(announce_list_response.AnnounceListResponse response) {
    _responseAnnounceList = response;
    notifyListeners();
  }

  set readResponse(NoticeReadResponse? response) {
    _readResponse = response;
    notifyListeners();
  }

  notice_list_response.NoticeListResponse get responseNoticeList => _responseNoticeList;
  announce_list_response.AnnounceListResponse get responseAnnounceList => _responseAnnounceList;
  NoticeReadResponse? get readResponse => this._readResponse;

  Future<void> noticeListApi() async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournamentId);
    final subscript = this.noticeList(params).listen((_) {
      if (responseNoticeList.success) {
        if (loadingState != LoadingState.DONE) loadingState = LoadingState.DONE;
        lsItem = responseNoticeList.list!;
        eventBus.fire(UpdateTournamentPageTabBadgeEvent(tournamentId, 3, responseNoticeList.badge_count?? 0));
        refreshController.refreshCompleted();
        notifyListeners();
      } else {
        _navigationService.gotoErrorPage(message: responseNoticeList.error_message);
      }
    }, onError: (e) {
      if (loadingState != LoadingState.ERROR) loadingState = LoadingState.ERROR;
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream noticeList(Map<String, dynamic> params) => _dataRepo
      .listNotify(params)
      .doOnData((r) => responseNoticeList = notice_list_response.NoticeListResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      responseNoticeList = notice_list_response.NoticeListResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {

  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Future<void> announceListApi() async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournamentId);
    final subscript = this.announceList(params).listen((_) {
      if (responseAnnounceList.success) {
        lsAnnounce = responseAnnounceList.list!;
        notifyListeners();
      } else {
        _navigationService.gotoErrorPage(message: responseAnnounceList.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream announceList(Map<String, dynamic> params) => _dataRepo
      .announceList(params)
      .doOnData((r) => responseAnnounceList = announce_list_response.AnnounceListResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      responseAnnounceList = announce_list_response.AnnounceListResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {

  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Future<void> noticeReadApi(index) async {
    var item = lsItem[index];
    if (item.flg_unread == 0) return;

    var params = <String, dynamic>{};
    params.putIfAbsent('tournament_id', () => tournamentId);
    if (item.notice_type == 1) {
      params.putIfAbsent('notice_type', () => 1);
    } else {
      params.putIfAbsent('notice_type', () => 3);
      params.putIfAbsent('tournament_round_id', () => item.tournament_round_id);
    }
    final subscript = noticeRead(params).listen((_) {
      if (readResponse != null && readResponse!.success) {
        lsItem[index].flg_unread = 0;
        notifyListeners();
        eventBus.fire(UpdateTournamentPageTabBadgeEvent(tournamentId, 3, readResponse!.flg_badge_on?? 0));
      }
    }, onError: (e) {
      print(e);
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
    noticeListApi();
  }

  diposeSelf() {
    var key = tournamentId.toString();
    if (_cache!.containsKey(key)) {
      _cache![key]!.dispose();
      _cache!.remove(key);
    }
  }
}