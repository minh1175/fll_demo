import 'dart:async';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:Gametector/app/module/network/response/participants_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class ParticipantListViewModel extends BaseViewModel {
  NavigationService _navigationService = getIt<NavigationService>();
  final DataRepository _dataRepo;

  late int tournamentId;
  ParticipantResponse? _participantResponse;
  late BaseResponse? _response;
  List<bool> customTileExpanded = [];

  ParticipantListViewModel(this._dataRepo);

  CompositeSubscription compositeSubscription = CompositeSubscription();
  addSubscription(StreamSubscription subscription) {
    compositeSubscription.add(subscription);
  }

  set participantResponse(ParticipantResponse? response) {
    _participantResponse = response;
    notifyListeners();
  }

  set response(BaseResponse? response) {
    _response = response;
    notifyListeners();
  }

  ParticipantResponse? get participantResponse => _participantResponse;
  BaseResponse? get response => _response;


  Future<void> participantsApi(tournament_id) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    tournamentId = tournament_id;
    params.putIfAbsent('tournament_id', () => tournament_id);
    final subscript = this.participants(params).listen((_) {
      if (participantResponse!.success) {
        customTileExpanded = List<bool>.generate(participantResponse!.team_list!.length, (i) => false);
        notifyListeners();
      } else {
        _navigationService.gotoErrorPage(message: participantResponse!.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Future<void> excludePlayerApi(playerId, entryStatus, type) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournamentId);
    params.putIfAbsent('player_id', () => playerId);
    params.putIfAbsent('entry_status', () => entryStatus);
    params.putIfAbsent('type', () => type);
    final subscript = this.excludePlayer(params).listen((_) {
      if (response!.success) {
        this.participantsApi(this.tournamentId);
        _navigationService.back();
      } else {
        // display alert
        showAlertGTDialog(message: response!.error_message,);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Future<void> deletePlayerApi(playerId, type) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournamentId);
    params.putIfAbsent('player_id', () => playerId);
    params.putIfAbsent('type', () => type);
    final subscript = this.deletePlayer(params).listen((_) {
      if (response!.success) {
        this.participantsApi(this.tournamentId);
        _navigationService.back();
      } else {
        // display alert
        showAlertGTDialog(message: response!.error_message,);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream participants(Map<String, dynamic> params) => _dataRepo
      .participants(params)
      .doOnData((r) => participantResponse = ParticipantResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      print ('error');
      participantResponse = ParticipantResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
    EasyLoading.show();
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Stream excludePlayer(Map<String, dynamic> params) => _dataRepo
      .excludePlayer(params)
      .doOnData((r) => response = BaseResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      print ('error');
      response = BaseResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
    EasyLoading.show();
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Stream deletePlayer(Map<String, dynamic> params) => _dataRepo
      .deletePlayer(params)
      .doOnData((r) => response = BaseResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      print ('error');
      response = BaseResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
    EasyLoading.show();
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  changeCustomExtend(int idx, bool expanded) {
    customTileExpanded[idx] = expanded;
    notifyListeners();
  }
}