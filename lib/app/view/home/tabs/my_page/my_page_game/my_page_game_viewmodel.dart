import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/mypage_game_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class MyPageGameViewModel extends BaseViewModel {
  final DataRepository _dataRepo;
  MyPageGameResponse? _playerResponse;
  MyPageGameResponse? _organizerResponse;
  NavigationService _navigationService = getIt<NavigationService>();

  late int? gameTitleId;
  late int? userId;
  late int playerSortType = 1;
  late int organizerSortType = 1;


  LoadingState loadingPlayerState = LoadingState.LOADING;
  LoadingState loadingOrganizerState = LoadingState.LOADING;

  RefreshController playerRefreshController = RefreshController(initialRefresh: false);
  RefreshController organizerRefreshController = RefreshController(initialRefresh: false);

  MyPageGameViewModel(this._dataRepo, {this.userId, this.gameTitleId});

  set playerResponse(MyPageGameResponse? response) {
    _playerResponse = response;
    notifyListeners();
  }

  MyPageGameResponse? get playerResponse => this._playerResponse;

  set organizerResponse(MyPageGameResponse? response) {
    _organizerResponse = response;
    notifyListeners();
  }

  MyPageGameResponse? get organizerResponse => this._organizerResponse;

  Future<void> mypagePlayerGameApi({int? sortType}) async {
    if (sortType != null) playerSortType = sortType;
    var params = <String, dynamic>{};
    params.putIfAbsent('type', () => 'player');
    params.putIfAbsent('sort_type', () => playerSortType);
    if (gameTitleId! > 0) params.putIfAbsent('game_title_id', () => gameTitleId);
    if (userId! > 0) params.putIfAbsent('user_id', () => userId);
    final subscript = mypagePlayerGame(params).listen((_) {
      if (playerResponse != null && playerResponse!.success) {
        if (loadingPlayerState != LoadingState.DONE) loadingPlayerState = LoadingState.DONE;
        playerRefreshController.refreshCompleted();
      } else {
        if (loadingPlayerState != LoadingState.ERROR) loadingPlayerState = LoadingState.ERROR;
        _navigationService.gotoErrorPage(message: playerResponse?.error_message);
      }
      notifyListeners();
    }, onError: (e) {
      notifyListeners();
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

  Stream mypagePlayerGame(Map<String, dynamic> params) =>
      _dataRepo
          .mypageGame(params)
          .doOnData((r) => playerResponse = MyPageGameResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          playerResponse = MyPageGameResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {
        /* ;*/
      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> mypageOrganizerGameApi({int? sortType}) async {
    if (sortType != null) organizerSortType = sortType;
    var params = <String, dynamic>{};
    params.putIfAbsent('type', () => 'organizer');
    params.putIfAbsent('sort_type', () => organizerSortType);
    if (gameTitleId! > 0) params.putIfAbsent('game_title_id', () => gameTitleId);
    if (userId! > 0) params.putIfAbsent('user_id', () => userId);
    final subscript = mypageOrganizerGame(params).listen((_) {
      if (organizerResponse != null && organizerResponse!.success) {
        if (loadingOrganizerState != LoadingState.DONE) loadingOrganizerState = LoadingState.DONE;
        organizerRefreshController.refreshCompleted();
      } else {
        if (loadingOrganizerState != LoadingState.ERROR) loadingOrganizerState = LoadingState.ERROR;
        _navigationService.gotoErrorPage(message: organizerResponse?.error_message);
      }
      notifyListeners();
    }, onError: (e) {
      notifyListeners();
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

  Stream mypageOrganizerGame(Map<String, dynamic> params) =>
      _dataRepo
          .mypageGame(params)
          .doOnData((r) => organizerResponse = MyPageGameResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          organizerResponse = MyPageGameResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {
        /* ;*/
      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  refreshPlayerData() {
    mypagePlayerGameApi();
  }

  refreshOrganizerData() {
    mypageOrganizerGameApi();
  }
}
