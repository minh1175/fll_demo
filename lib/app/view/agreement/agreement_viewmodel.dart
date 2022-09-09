import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/model/webview_param.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/login_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/view/home/home_page.dart';
import 'package:Gametector/app/view/webview/webview_page.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../viewmodel/base_viewmodel.dart';

class AgreementViewModel extends BaseViewModel {
  final DataRepository _dataRepo;
  LoginResponse? _response;
  NavigationService _navigationService = getIt<NavigationService>();
  UserSharePref _userSharePref = getIt<UserSharePref>();
  bool termOfService = false;
  bool policy = false;

  AgreementViewModel(this._dataRepo);

  void changeTermOfService() {
    termOfService = !termOfService;
    notifyListeners();
  }

  void changePolicy() {
    policy = !policy;
    notifyListeners();
  }

  set response(LoginResponse? response) {
    _response = response;
    notifyListeners();
  }

  LoginResponse? get response => _response;

  Stream loginComplete(Map<String, dynamic> params) => _dataRepo
          .loginComplete(params)
          .doOnData((r) => response = LoginResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          response =
              LoginResponse.fromJson(e.response?.data.trim());
        }
      }).doOnListen(() {
        EasyLoading.show();
      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> loginCompleteApi() async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('login_type', () => _userSharePref.getLoginType());
    params.putIfAbsent('unique_id', () => _userSharePref.getLoginType() == 1 ? _userSharePref.getTwitterId() : _userSharePref.getAppleId());
    params.putIfAbsent('user_name', () => _userSharePref.getLoginType() == 1 ? '' : _userSharePref.getAppleUserName());
    params.putIfAbsent('email', () => '');
    final subscript = this.loginComplete(params).listen((_) {
      if (response!.success) {
        LoginResponse loginResponse = LoginResponse(
          error_message: '',
          success: true,
          is_new_regist: response?.is_new_regist ?? false,
          player_id: response?.player_id,
          player_name: response?.player_name,
          user_id: response?.user_id,
          thumb_url: response?.thumb_url,
        );
        _userSharePref.saveUser(loginResponse);
        _navigationService.pushReplacementScreenWithFade(HomePage());
      } else {
        _navigationService.gotoErrorPage(message: response?.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Future<void> loginCompleteAction() async {
    if (_userSharePref.getUser() != null) {
      await loginCompleteApi();
    } else {
      _navigationService.refreshApp();
    }
  }

  void showTerm() {
    _navigationService.pushEnterFadeExitDown(
        WebviewPage(WebviewParam(url: URL_TERMS_OF_SERVICE)));
  }

  void showPolicy() {
    _navigationService.pushEnterFadeExitDown(
        WebviewPage(WebviewParam(url: URL_PRIVACY_POLICY)));
  }
}
