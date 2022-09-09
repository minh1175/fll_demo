import 'dart:core';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/athletes_abstrain_participants_response.dart';
import 'package:Gametector/app/module/network/response/bulk_organizer_league_score_response.dart';
import 'package:Gametector/app/module/network/response/bulk_score_input_response.dart';
import 'package:Gametector/app/module/network/response/match_board_list_response.dart';
import 'package:Gametector/app/module/network/response/retire_player.dart';
import 'package:Gametector/app/module/network/response/tournament_list_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/view/component/bottom_sheet/swiss_round_decision_bottom_sheet.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/view/component/dialog/suggest_finish_tournament_dialog.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class MatchBoardViewModel extends BaseViewModel {
  AthletesAbstrainParticipantResponse? _athletesAbstrainResponse;
  RetirePlayerResponse? _retirePlayerResponse;
  final DataRepository _dataRepo;
  late BulkScoreInputResponse _responseBulkScore;
  late BulkOrganizerLeagueScoreResponse _responseBulkOrganizerLeagueScore;
  MatchBoardListResponse? resMatchList;
  NavigationService _navigationService = getIt<NavigationService>();
  List<Item> lsScore = [];
  List<Filter> lsFilter = [];
  List<ItemMatch> lsMatch = [];
  List<ItemTourPlayerOrganizer> lsTournament = [];
  int myUserId = getIt<UserSharePref>().getUser()?.user_id ?? -1;

  int filterType = 0;
  int tabType = 2;
  int pageNo = 1;
  int flgLastPage = 0;

  LoadingState loadingState = LoadingState.LOADING;

  late int selectedFilterIdx = 0;
  int selectedBulkCount = 0;
  late int tournamentId;

  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  static Map<String, MatchBoardViewModel?>? _cache;
  // TODO : confirm whether this code is ok or ng.
  factory MatchBoardViewModel(dataRepo, {tournamentId}) {
    var key = tournamentId.toString();
    // reset
    if (tournamentId == 0) _cache = null;
    if (_cache == null) _cache = {};
    if (_cache!.containsKey(key) == false) {
      _cache![key] = new MatchBoardViewModel._(dataRepo, tournamentId: tournamentId);
    }
    return _cache![key]!;
  }

  MatchBoardViewModel._(this._dataRepo, {this.tournamentId=0});

  int getNonRetirePlayerNum() {
    var num = 0;
    for (var p in _athletesAbstrainResponse?.player_list ?? []) {
      if (p.flg_retire == 0) num++;
    }
    return num;
  }

  set responseMatchList(MatchBoardListResponse? response) {
    resMatchList = response;
    notifyListeners();
  }

  set responseBulkScore(BulkScoreInputResponse response) {
    _responseBulkScore = response;
    notifyListeners();
  }

  set responseBulkOrganizerLeagueScore(
      BulkOrganizerLeagueScoreResponse response) {
    _responseBulkOrganizerLeagueScore = response;
    notifyListeners();
  }

  set athletesAbstrainResponse(AthletesAbstrainParticipantResponse? response) {
    _athletesAbstrainResponse = response;
    notifyListeners();
  }

  set retirePlayerResponse(RetirePlayerResponse? response) {
    _retirePlayerResponse = response;
    notifyListeners();
  }

  MatchBoardListResponse? get responseMatchList => resMatchList;

  BulkScoreInputResponse get responseBulkScore => _responseBulkScore;

  BulkOrganizerLeagueScoreResponse get responseBulkOrganizerLeagueScore =>
      _responseBulkOrganizerLeagueScore;

  AthletesAbstrainParticipantResponse? get athletesAbstrainResponse =>
      _athletesAbstrainResponse;

  RetirePlayerResponse? get retirePlayerResponse => _retirePlayerResponse;

  Future<void> matchBoardListApi({tabIdx}) async {
    if (tabIdx != null) {
      selectedFilterIdx = tabIdx;
      pageNo = 1;
      flgLastPage = 0;
      notifyListeners();
    }

    if (flgLastPage == 1) {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      return;
    }

    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournamentId);
    if (lsFilter.length > 0) {
      var targetFilter = lsFilter[selectedFilterIdx];
      params.putIfAbsent('filter_menu_type', () => targetFilter.type);
      params.putIfAbsent('round_no', () => targetFilter.round_no);
      params.putIfAbsent('page_no', () => pageNo);
    } else {
      params.putIfAbsent('filter_menu_type', () => 0);
      params.putIfAbsent('round_no', () => 0);
      params.putIfAbsent('page_no', () => pageNo);
    }
    final subscript = this.mapMatchBoardList(params).listen((_) {
      if (responseMatchList != null && responseMatchList!.success) {
        if (loadingState != LoadingState.DONE) loadingState = LoadingState.DONE;
        resMatchList = responseMatchList;
        lsFilter = responseMatchList?.filter_menu_list ?? [];
        flgLastPage = responseMatchList?.flg_last_page ?? 1;
        if (pageNo == 1) {
          lsMatch = responseMatchList?.match_board_list ?? [];
        } else {
          lsMatch.addAll(responseMatchList?.match_board_list ?? []);
        }
        pageNo++;
      } else {
        _navigationService.gotoErrorPage(
            message: responseMatchList?.error_message);
      }
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      notifyListeners();
    }, onError: (e) {
      if (loadingState != LoadingState.ERROR) loadingState = LoadingState.ERROR;
      notifyListeners();
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream mapMatchBoardList(Map<String, dynamic> params) => _dataRepo
      .matchBoardList(params)
      .doOnData((r) => responseMatchList = MatchBoardListResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          responseMatchList =
              MatchBoardListResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  changeCheckBulkItem(int idx, bool isCheck) {
    lsScore[idx].is_check_item = isCheck;
    if (isCheck) {
      selectedBulkCount++;
    } else {
      selectedBulkCount--;
    }
    notifyListeners();
  }

  Future<void> bulkScoreInfoListApi(tournament_id) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    final subscript = this.bulkScoreInfoList(params, tournament_id).listen((_) {
      if (responseBulkScore.success) {
        loadingState = LoadingState.DONE;
        lsScore = responseBulkScore.score_list!;
        selectedBulkCount = lsScore.length;
        notifyListeners();
      } else {
        _navigationService.gotoErrorPage(
            message: responseBulkScore.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream bulkScoreInfoList(Map<String, dynamic> params, tournament_id) =>
      _dataRepo
          .bulkScoreInfoList(params, tournament_id)
          .doOnData(
              (r) => responseBulkScore = BulkScoreInputResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          responseBulkScore =
              BulkScoreInputResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {

      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> bulkOrganizerLeaguePostApi(tournament_id, bluk_score_json) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournament_id);
    params.putIfAbsent('bulk_score_json', () => bluk_score_json);
    final subscript = this.bulkOrganizerLeaguePost(params).listen((_) {
      if (responseBulkOrganizerLeagueScore.success) {
        // eventBus.fire(PushUpdateMatchBoardEvent(tournament_id));
        _navigationService.back();
        if (responseBulkOrganizerLeagueScore.is_all_round_finish == true) {
          suggestFinishTournamentDialog(tournament_id);
        } else if (responseBulkOrganizerLeagueScore.flg_swiss_round_decision == 1) {
          SwissRoundDecisionBottomSheet(tournamentId: tournament_id, isAllRoundFinish: false);
        }
      } else {
        _navigationService.gotoErrorPage(
            message: responseBulkOrganizerLeagueScore.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream bulkOrganizerLeaguePost(Map<String, dynamic> params) => _dataRepo
          .bulkOrganizerLeaguePost(params)
          .doOnData((r) => responseBulkOrganizerLeagueScore =
              BulkOrganizerLeagueScoreResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          responseBulkOrganizerLeagueScore =
              BulkOrganizerLeagueScoreResponse.fromJson(
                  e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {

      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> athletesParticipantsApi(tournament_id) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    tournamentId = tournament_id;
    params.putIfAbsent('tournament_id', () => tournament_id);
    final subscript = this.athletes(params).listen((_) {
      if (athletesAbstrainResponse!.success) {
        // Nothing to do
      } else {
        _navigationService.gotoErrorPage(
            message: athletesAbstrainResponse!.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream athletes(Map<String, dynamic> params) => _dataRepo
          .athletes(params)
          .doOnData((r) => athletesAbstrainResponse =
              AthletesAbstrainParticipantResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          print('error');
          athletesAbstrainResponse =
              AthletesAbstrainParticipantResponse.fromJson(
                  e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {

      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> retirePlayerApi(tournament_id) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    var playerIdList = [];
    for (var p in _athletesAbstrainResponse?.player_list ?? []) {
      if (p.flg_retire == 1) {
        playerIdList.add(p.player_id);
      }
    }
    params.putIfAbsent('tournament_id', () => tournament_id);
    params.putIfAbsent('player_id_list[]', () => playerIdList);
    final subscript = this.retirePlayer(params).listen((_) {
      if (retirePlayerResponse!.success) {
        // eventBus.fire(PushUpdateMatchBoardEvent(tournament_id));
        _navigationService.back();
        _navigationService.back();
        if (retirePlayerResponse!.is_all_round_finish == true) {
          suggestFinishTournamentDialog(tournament_id);
        }
      } else {
        _navigationService.gotoErrorPage(
            message: retirePlayerResponse!.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream retirePlayer(Map<String, dynamic> params) => _dataRepo
          .retirePlayer(params)
          .doOnData(
              (r) => retirePlayerResponse = RetirePlayerResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          retirePlayerResponse =
              RetirePlayerResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {

      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  refreshData() {
    pageNo = 1;
    flgLastPage = 0;
    matchBoardListApi(tabIdx: selectedFilterIdx);
  }

  diposeSelf() {
    var key = tournamentId.toString();
    if (_cache!.containsKey(key)) {
      _cache![key]!.dispose();
      _cache!.remove(key);
    }
  }
}
