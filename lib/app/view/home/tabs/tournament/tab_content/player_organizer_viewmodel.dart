import 'dart:core';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/tournament_list_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class PlayerOrganizerViewModel extends BaseViewModel {
  final DataRepository _dataRepo;
  late TournamentListResponse? _response;
  static Map<String, PlayerOrganizerViewModel?>? _cache;

  NavigationService _navigationService = getIt<NavigationService>();
  var filterType = 0; /*1: 主催者（organizer）、2：選手（player）*/
  var tabType = 2;
  var pageNo = 0;
  var flagLastPage = 0;
  LoadingState loadingState = LoadingState.LOADING;
  List<ItemTourPlayerOrganizer> lsData = [];

  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  // TODO : confirm whether this code is ok or ng.
  factory PlayerOrganizerViewModel(dataRepo, {tabType, filterType}) {
    var key = tabType.toString() + "_" + filterType.toString();
    // reset
    if (tabType == 0 && filterType == 0) _cache = null;
    if (_cache == null) _cache = {};
    if (_cache!.containsKey(key) == false) {
      _cache![key] = new PlayerOrganizerViewModel._(dataRepo, tabType: tabType, filterType: filterType);
    }
    return _cache![key]!;
  }

  PlayerOrganizerViewModel._(this._dataRepo, {this.tabType=2, this.filterType=1});

  set response(TournamentListResponse? response) {
    _response = response;
    notifyListeners();
  }

  TournamentListResponse? get response => this._response;

  Stream list(Map<String, dynamic> params) => _dataRepo
      .list(params)
      .doOnData((r) => response = TournamentListResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      response = TournamentListResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
  }).doOnDone(() {
  });

  Future<void> listApi() async {
    if (flagLastPage == 1) {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      return;
    }
    pageNo++;
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('page_no', () => pageNo);
    params.putIfAbsent('filter_menu_type', () => filterType);
    params.putIfAbsent('tab_type', () => tabType);
    final subscript = this.list(params).listen((_) {
      if (response != null && response!.success) {
        if(loadingState != LoadingState.DONE) loadingState = LoadingState.DONE;
        flagLastPage = response?.flg_last_page ?? 1;
        if (pageNo == 1) {
          lsData = response?.tournament_list ?? [];
        } else {
          lsData.addAll(response?.tournament_list ?? []);
        }
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        notifyListeners();
      } else {
        if(loadingState != LoadingState.ERROR) loadingState = LoadingState.ERROR;
        _navigationService.gotoErrorPage(message: response?.error_message);
      }
      notifyListeners();
    }, onError: (e) {
      notifyListeners();
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }


  refreshData(){
    pageNo = 0;
    flagLastPage = 0;
    listApi();
  }

}
