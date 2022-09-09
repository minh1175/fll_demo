import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:Gametector/app/module/network/response/tournament_finish_half_way_response.dart';
import 'package:Gametector/app/module/network/response/tournament_info_response.dart';
import 'package:Gametector/app/module/network/response/tournament_rank_list.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/view/component/dialog/suggest_finish_tournament_dialog.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class TournamentControllerViewModel extends BaseViewModel {
  UserSharePref _userSharePref = getIt<UserSharePref>();
  NavigationService _navigationService = getIt<NavigationService>();
  final DataRepository _dataRepo;
  final int tournamentId;
  late TournamentInfoResponse _response;
  late TournamentFinishHalfWayResponse _responseTournamentFinishHalfWay;
  TournamentRankListResponse? _tournamentRankListResponse;
  BaseResponse? _tournamentFinishResponse;
  TournamentInfo? tournamentInfo;
  LoadingState loadingState = LoadingState.LOADING;

  TournamentControllerViewModel(this._dataRepo, {required this.tournamentId}) {
    addSubscription(
        eventBus.on<UpdateTournamentPageTabBadgeEvent>().listen((event) {
          if (event.tournamentId != this.tournamentId) return;
          updateTabBadge(event.index, event.count);
        })
    );

    // TODO : マッチボードと大会内お知らせのバッジを更新する (トナメ情報を更新するかどうか？)
    // addSubscription(
    //     eventBus.on<PushUpdateNotificationEvent>().listen((event) {
    //       if (event.tourId != tournamentId) return;
    //       updateTabBadge(3, 1);  //tournamentInfo を更新すれば良い？
    //     })
    // );
  }

  set response(TournamentInfoResponse response) {
    _response = response;
    notifyListeners();
  }

  set responseTournamentFinishHalfWay(
      TournamentFinishHalfWayResponse response) {
    _responseTournamentFinishHalfWay = response;
    notifyListeners();
  }

  set responseTournamentRankList(TournamentRankListResponse? response) {
    _tournamentRankListResponse = response;
    notifyListeners();
  }

  set responseTournamentFinish(BaseResponse? response) {
    _tournamentFinishResponse = response;
    notifyListeners();
  }

  TournamentInfoResponse get response => _response;

  TournamentFinishHalfWayResponse get responseTournamentFinishHalfWay =>
      _responseTournamentFinishHalfWay;

  TournamentRankListResponse? get responseTournamentRankList =>
      _tournamentRankListResponse;

  BaseResponse? get responseTournamentFinish => _tournamentFinishResponse;

  bool isAllRoundFinish() => (tournamentInfo!.tournament_progress_status! >= 5);

  bool isSuggestFinish() => (tournamentInfo!.tournament_progress_status == 5 &&
      tournamentInfo!.organizer_user_id == _userSharePref.getUser()!.user_id);

  Future<void> tournamentInfoApi() async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => this.tournamentId);
    final subscript = this.mapTournamentInfo(params).listen((_) {
      if (response.success) {
        _response = response;
        tournamentInfo = response.tournament_info!;
        loadingState = LoadingState.DONE;
        notifyListeners();

        // if all round is finished and you're organizer,  display dialog
        if (isSuggestFinish()) {
          suggestFinishTournamentDialog(tournamentInfo!.tournament_id!);
        }
      } else {
        if (loadingState != LoadingState.ERROR) {
          loadingState = LoadingState.ERROR;
        }
        _navigationService.gotoErrorPage(message: response.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream mapTournamentInfo(Map<String, dynamic> params) => _dataRepo
      .tournamentInfo(params)
      .doOnData((r) => response = TournamentInfoResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          response =
              TournamentInfoResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> finishHalfwayApi(tournament_id) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournament_id);
    final subscript = this.finishHalfway(params).listen((_) {
      if (responseTournamentFinishHalfWay.success) {
        _navigationService.back();
        _navigationService.back();
        if (responseTournamentFinishHalfWay.is_complete) {
          suggestFinishTournamentDialog(tournament_id);
        }
      } else {
        _navigationService.gotoErrorPage(
            message: responseTournamentFinishHalfWay.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream finishHalfway(Map<String, dynamic> params) => _dataRepo
      .finishHalfway(params)
      .doOnData((r) => responseTournamentFinishHalfWay =
          TournamentFinishHalfWayResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          responseTournamentFinishHalfWay =
              TournamentFinishHalfWayResponse.fromJson(
                  e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> rankListApi(tournament_id) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournament_id);
    final subscript = this.rankList(params).listen((_) {
      if (responseTournamentRankList!.success) {
        // Nothing to do
      } else {
        _navigationService.gotoErrorPage(
            message: responseTournamentRankList!.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream rankList(Map<String, dynamic> params) => _dataRepo
      .rankList(params)
      .doOnData((r) =>
          responseTournamentRankList = TournamentRankListResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          responseTournamentRankList = TournamentRankListResponse.fromJson(
              e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> tournamentFinishApi(tournament_id, result_comment) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournament_id);
    params.putIfAbsent('result_comment', () => result_comment);
    print(params);
    final subscript = this.tournamentFinish(params).listen((_) {
      if (responseTournamentFinish!.success) {
        eventBus.fire(RefreshTournamentChatEvent(tournament_id));
        _navigationService.back();
      } else {
        _navigationService.gotoErrorPage(
            message: responseTournamentFinish!.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream tournamentFinish(Map<String, dynamic> params) => _dataRepo
      .tournamentFinish(params)
      .doOnData((r) => responseTournamentFinish = BaseResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          responseTournamentFinish =
              BaseResponse.fromJson(e.response?.data.trim() ?? '');
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  updateTabBadge(int index, int count) {
    if (index == 1) {
      tournamentInfo!.match_board_badge_count = count;
    }
    if (index == 3) {
      tournamentInfo!.notice_badge_count = count;
    }
    notifyListeners();
  }
}
