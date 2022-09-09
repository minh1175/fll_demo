import 'dart:core';
import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/score_info_response.dart';
import 'package:Gametector/app/module/network/response/tournament_info_response.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/view/component/dialog/accept_score_input_dialog.dart';
import 'package:Gametector/app/view/component/dialog/suggest_finish_tournament_dialog.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import '../../component/bottom_sheet/swiss_round_decision_bottom_sheet.dart';

class ScoreInputViewModel extends BaseViewModel {
  final DataRepository _dataRepo;
  UserSharePref _userSharePref = getIt<UserSharePref>();
  NavigationService _navigationService = getIt<NavigationService>();
  TournamentInfoResponse? _tournamentInfoResponse;
  ScoreInfoResponse? _scoreInfoResponse;
  ScoreInfoResponse? _scorePostResponse;

  List<ScoreItem> lsItem = [];
  late int _tournamentRoundId;

  ScoreInputViewModel(this._dataRepo);

  set responseTournamentInfo(TournamentInfoResponse? response) {
    _tournamentInfoResponse = response;
    notifyListeners();
  }

  set responseScoreInfo(ScoreInfoResponse? response) {
    _scoreInfoResponse = response;
    notifyListeners();
  }

  set responseScorePost(ScoreInfoResponse? response) {
    _scorePostResponse = response;
    notifyListeners();
  }

  TournamentInfoResponse? get responseTournamentInfo => _tournamentInfoResponse;
  ScoreInfoResponse? get responseScoreInfo => _scoreInfoResponse;
  ScoreInfoResponse? get responseScorePost => _scorePostResponse;

  Future<void> tournamentInfoApi(tournament_id) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_id', () => tournament_id);
    final subscript = this.mapTournamentInfo(params).listen((_) {
      if (responseTournamentInfo!.success) {
        notifyListeners();
      } else {
        _navigationService.gotoErrorPage(message: responseTournamentInfo!.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream mapTournamentInfo(Map<String, dynamic> params) => _dataRepo
      .tournamentInfo(params)
      .doOnData((r) => responseTournamentInfo = TournamentInfoResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      responseTournamentInfo = TournamentInfoResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
    EasyLoading.show();
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Future<void> scoreInfoAPI(tournament_round_id) async {
    _tournamentRoundId = tournament_round_id;
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('tournament_round_id', () => tournament_round_id);
    final subscript = this.scoreInfo(params, tournament_round_id).listen((_) {
      if (responseScoreInfo != null && responseScoreInfo!.success) {
        lsItem.addAll(responseScoreInfo?.score_list ?? []);
        notifyListeners();
      } else {
        _navigationService.gotoErrorPage(message: responseScoreInfo?.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream scoreInfo(Map<String, dynamic> params, tournament_round_id) =>
      _dataRepo
          .scoreInfo(params, tournament_round_id)
          .doOnData((r) => responseScoreInfo = ScoreInfoResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          responseScoreInfo = ScoreInfoResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {
        EasyLoading.show();
      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  void setImage(String? imagePath, int battleNo){
    lsItem.forEach((ScoreItem item) {
      if (item.battle_no == battleNo) {
        item.win_certification_url = imagePath;
        notifyListeners();
      }
    });
  }

  void changeScoreValue(bool isUp, bool isLeft, int battleNo){
    lsItem.forEach((ScoreItem item) {
      if (item.battle_no == battleNo) {
        if (isLeft) {
          if (isUp) {
            item.score_left = item.score_left!+1;
          } else {
            if (item.score_left! == 0) return;
            item.score_left = item.score_left!-1;
          }
        } else {
          if (isUp) {
            item.score_right = item.score_right!+1;
          } else {
            if (item.score_right! == 0) return;
            item.score_right = item.score_right!-1;
          }
        }
        if (item.score_right != item.score_left) {
          item.pk_score_left = 0;
          item.pk_score_right = 0;
        }
        notifyListeners();
      }
    });
  }

  void changeOptionScoreValue(bool isUp, bool isLeft, int battleNo) {
    lsItem.forEach((ScoreItem item) {
      if (item.battle_no == battleNo) {
        if (isLeft) {
          if (isUp) {
            item.pk_score_left = item.pk_score_left!+1;
          } else {
            if (item.pk_score_left! == 0) return;
            item.pk_score_left = item.pk_score_left!-1;
          }
        } else {
          if (isUp) {
            item.pk_score_right = item.pk_score_right!+1;
          } else {
            if (item.pk_score_right! == 0) return;
            item.pk_score_right = item.pk_score_right!-1;
          }
        }
        notifyListeners();
      }
    });
  }

  void chagneDefaultScoreValue(int type, int battleNo) {
    lsItem.forEach((ScoreItem item) {
      if (item.battle_no == battleNo) {
        if (type == 1) {
          item.win_lose_type_left = '3';
          item.win_lose_type_right = '4';
        } else if (type == 2) {
          item.win_lose_type_left = '4';
          item.win_lose_type_right = '4';
        } else if (type == 3) {
          item.win_lose_type_left = '4';
          item.win_lose_type_right = '3';
        } else {
          item.win_lose_type_left = '';
          item.win_lose_type_right = '';
        }
        notifyListeners();
      }
    });
  }

  List getTournamentScoreInputParam(int battleNo) {
    // roundBoxNo, playerIdLeft, winLoseTypeLeft, scoreLeft, pkScoreLeft, playerIdRight, winLoseTypeRight, scoreRight, pkScoreRight
    List params = [];
    lsItem.forEach((ScoreItem item) {
      if (item.battle_no == battleNo) {
        if (item.win_lose_type_left != "3" && item.win_lose_type_left != "4") {
          if (item.score_left! > item.score_right!) {
            // left win
            item.win_lose_type_left = "1";
            item.win_lose_type_right = "2";
          } else if (item.score_left! < item.score_right!) {
            // right win
            item.win_lose_type_left = "2";
            item.win_lose_type_right = "1";
          } else {
            if (item.pk_score_left! > item.pk_score_right!) {
              // left win
              item.win_lose_type_left = "1";
              item.win_lose_type_right = "2";
            } else if (item.pk_score_left! < item.pk_score_right!) {
              // right win
              item.win_lose_type_left = "2";
              item.win_lose_type_right = "1";
            } else {
              // draw
              item.win_lose_type_left = "7";
              item.win_lose_type_right = "7";
            }
          }
        }
        params.add("'"+_userSharePref.getAppToken()+"'");
        params.add(responseScoreInfo!.round_box_no);
        params.add(item.player_id_left);
        params.add(item.win_lose_type_left);
        params.add(item.score_left);
        params.add(item.pk_score_left);
        params.add(item.player_id_right);
        params.add(item.win_lose_type_right);
        params.add(item.score_right);
        params.add(item.pk_score_right);
      }
    });
    return params;
  }

  bool isOrganizer(){
    if (responseTournamentInfo == null) {
      return false;
    }
    int organizerUserId = responseTournamentInfo!.tournament_info!.organizer_user_id?? -1;
    int myUserId = _userSharePref.getUser()!.user_id?? -2;
    return organizerUserId == myUserId;
  }

  Future<void> scorePostApi(int battleNo, XFile? file) async {
    int tourId = responseTournamentInfo!.tournament_info!.tournament_id!;

    Map<String, dynamic> params = new Map<String, dynamic>();
    lsItem.forEach((ScoreItem item) {
      if (item.battle_no == battleNo) {
        params.putIfAbsent('tournament_round_id', () => _tournamentRoundId);
        params.putIfAbsent('battle_no', () => item.battle_no);
        // 1: win, 2: lose, 3: win by default, 4: lose by default、7:draw
        params.putIfAbsent('win_lose_type_left', () => item.win_lose_type_left);
        params.putIfAbsent('win_lose_type_right', () => item.win_lose_type_right);
        params.putIfAbsent('score_left', () => item.score_left);
        params.putIfAbsent('score_right', () => item.score_right);
        params.putIfAbsent('pk_score_left', () => item.pk_score_left);
        params.putIfAbsent('pk_score_right', () => item.pk_score_right);
        if (file != null) {
          params.putIfAbsent('image', () =>
              MultipartFile.fromFileSync(file.path, filename: file.path.split('/').last,),
          );
        } else {
          if (item.win_certification_url == null || item.win_certification_url == "") {
            params.putIfAbsent('is_delete_image', () => 1);
          }
        }
      }
      print (params);
    });

    // tournament(organizer) : appscore Post
    // tournament(player) : scorePost
    // league(organizer) : scorePostLeagueOrganizer
    // league(player) : scorePost
    if (isOrganizer()) {
      // league(organizer)
      final subscript = this.scorePostLeagueOrganizer(params).listen((_) {
        if (responseScorePost != null && responseScorePost!.success) {
          lsItem = responseScorePost?.score_list ?? [];
          eventBus.fire(PushUpdateMatchBoardEvent(tourId));
          _navigationService.back();
          if (responseScorePost?.is_all_round_finish == true) {
            suggestFinishTournamentDialog(tourId);
          } else if(responseScorePost?.flg_swiss_round_decision == 1) {
            SwissRoundDecisionBottomSheet(tournamentId: tourId, isAllRoundFinish: false);
          }
          notifyListeners();
        } else {
          _navigationService.gotoErrorPage(message: responseScorePost?.error_message);
        }
      }, onError: (e) {
        _navigationService.gotoErrorPage();
      });
      this.addSubscription(subscript);
    } else {
      // league(player) / tournament(player)
      final subscript = this.scorePost(params).listen((_) {
        if (responseScorePost != null && responseScorePost!.success) {
          eventBus.fire(PushUpdateMatchBoardEvent(tourId));
          lsItem = responseScorePost?.score_list ?? [];
          _navigationService.back();
          acceptScoreInputDialog();
          notifyListeners();
        } else {
          _navigationService.gotoErrorPage(message: responseScorePost?.error_message);
        }
      }, onError: (e) {
        _navigationService.gotoErrorPage();
      });
      this.addSubscription(subscript);
    }
  }

  Stream scorePost(Map<String, dynamic> params) =>
      _dataRepo
          .scorePost(params)
          .doOnData((r) => responseScorePost = ScoreInfoResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          responseScorePost = ScoreInfoResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {
        EasyLoading.show();
      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  Stream scorePostLeagueOrganizer(Map<String, dynamic> params) =>
      _dataRepo
          .scorePostLeagueOrganizer(params)
          .doOnData((r) => responseScorePost = ScoreInfoResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          responseScorePost = ScoreInfoResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {
        EasyLoading.show();
      }).doOnDone(() {
        EasyLoading.dismiss();
      });
}
