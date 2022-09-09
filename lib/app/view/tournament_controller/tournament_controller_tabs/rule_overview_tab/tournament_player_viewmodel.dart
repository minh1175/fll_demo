import 'dart:core';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/player_list_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';


class TournamentPlayerViewModel extends BaseViewModel {
  final DataRepository _dataRepo;
  PlayerListResponse? _response;
  NavigationService _navigationService = getIt<NavigationService>();
  List<Player> lsPlayer = [];

  TournamentPlayerViewModel(this._dataRepo);

  set response(PlayerListResponse? response) {
    _response = response;
    notifyListeners();
  }

  PlayerListResponse? get response => _response;

  Future<void> playerListApi(tournament_id) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournament_id);
    final subscript = this.playerList(params).listen((_) {
      if (response!.success) {
        lsPlayer = response!.list ?? [];
        notifyListeners();
      } else {
        _navigationService.gotoErrorPage(message: response!.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream playerList(Map<String, dynamic> params) => _dataRepo
      .playerList(params)
      .doOnData((r) => response = PlayerListResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      response =
          PlayerListResponse.fromJson(e.response?.data.trim() ?? '');
    }
  })
      .doOnListen(() {})
      .doOnDone(() {
    EasyLoading.dismiss();
  });
}