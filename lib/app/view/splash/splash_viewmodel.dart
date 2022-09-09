import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/login_response.dart';
import 'package:Gametector/app/module/network/response/start_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/module/utils/toast_util.dart';
import 'package:Gametector/app/module/socket/socket_manager.dart';
import 'package:Gametector/app/view/component/dialog/congratulation_gtscore_dialog.dart';
import 'package:Gametector/app/view/home/home_page.dart';
import 'package:Gametector/app/view/login/login_page.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../viewmodel/base_viewmodel.dart';

class SplashViewModel extends BaseViewModel {
  final DataRepository _dataRepo;
  late StartResponse _response;
  NavigationService _navigationService = getIt<NavigationService>();
  UserSharePref _userSharePref = getIt<UserSharePref>();
  SocketManager _socketManager = getIt<SocketManager>();

  SplashViewModel(this._dataRepo);

  set response(StartResponse response) {
    _response = response;
    notifyListeners();
  }

  StartResponse get response => _response;

  //no show loading in splash page
  Stream start() => _dataRepo
      .start()
      .doOnData((r) => response = StartResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          response =
              StartResponse.fromJson(e.response?.data.trim());
        }
      })
      .doOnListen(() {})
      .doOnDone(() {});

  Future<void> startApi() async {
    Future.delayed(
      Duration(milliseconds: DELAY_SPLASH_PAGE),
      () {
        final subscript = this.start().listen((_) {
          if (response.success) {
            _userSharePref.saveAppToken(response.app_token);
            _userSharePref.setLoadStartAPI(false);
            if (response.is_twitter_link) {
              // in case user remove app
              if (_userSharePref.getUser() == null ||
                  _userSharePref.getUser()!.user_id == 0) {
                LoginResponse loginResponse = LoginResponse(
                  error_message: '',
                  success: true,
                  player_id: response.player_id,
                  player_name: response.player_name,
                  user_id: response.user_id,
                  thumb_url: response.thumb_url,
                );
                _userSharePref.saveUser(loginResponse);
              } else {
                // update info user
                LoginResponse loginResponse = _userSharePref.getUser()!;
                loginResponse.player_id = response.player_id;
                loginResponse.player_name = response.player_name;
                loginResponse.user_id = response.user_id;
                loginResponse.thumb_url = response.thumb_url;
                _userSharePref.saveUser(loginResponse);
              }
              _socketManager.initSocket();
              _navigationService.pushReplacementScreenWithFade(HomePage());
              if (response.battle_report!.is_show == true) {
                showCongratulationGtscoreDialog(battleReport: response.battle_report);
              }
            } else {
              _navigationService.pushReplacementScreenWithFade(LoginPage());
            }
          } else {
            _navigationService.gotoErrorPage(message: response.error_message);
            ToastUtil.showToast(response.success.toString());
          }
        }, onError: (e) {
          _navigationService.gotoErrorPage();
        });
        this.addSubscription(subscript);
      },
    );
  }
}
