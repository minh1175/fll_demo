import 'dart:developer';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/login_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/agreement/agreement_page.dart';
import 'package:Gametector/app/view/component/bottom_sheet/apple_user_name_bottom_sheet.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:Gametector/app/view/home/home_page.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../module/socket/socket_manager.dart';
import '../../viewmodel/base_viewmodel.dart';
import '../../module/service/twitter_client.dart';

class LoginViewModel extends BaseViewModel {
  final DataRepository _dataRepo;
  late LoginResponse _response;
  NavigationService _navigationService = getIt<NavigationService>();
  UserSharePref _userSharePref = getIt<UserSharePref>();
  SocketManager _socketManager = getIt<SocketManager>();

  LoginViewModel(this._dataRepo);

  set response(LoginResponse response) {
    _response = response;
    notifyListeners();
  }

  LoginResponse get response => _response;

  setloginType(int loginType) => _userSharePref.saveLoginType(loginType);

  Stream login(Map<String, dynamic> params) => _dataRepo
      .login(params)
      .doOnData((r) => response = LoginResponse.fromJson(r))
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          response = LoginResponse.fromJson(e.response?.data.trim());
        }
      })
      .doOnListen(() {})
      .doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> loginApi(String twitterId) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('login_type', () => 1);
    params.putIfAbsent('twitter_id', () => twitterId);
    final subscript = this.login(params).listen((_) {
      if (response.success) {
        _userSharePref.saveUser(response);
        _userSharePref.saveTwitterId(twitterId);
        //init socket
        _socketManager.initSocket();
        if(response.is_new_regist){
          _navigationService.pushReplacementScreenWithFade(AgreementPage());
        }else{
          _navigationService.pushReplacementScreenWithFade(HomePage());
        }
      } else {
        _navigationService.gotoErrorPage(message: response.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Future<void> loginApiForApple(String appleId, String email) async {
    Map<String, dynamic> params = new Map<String, dynamic>();
    params.putIfAbsent('login_type', () => 2);
    params.putIfAbsent('apple_id', () => appleId);
    params.putIfAbsent('email', () => email);
    final subscript = this.login(params).listen((_) {
      if (response.success) {
        _userSharePref.saveUser(response);
        _userSharePref.saveAppleId(appleId);
        //init socket
        _socketManager.initSocket();
        appleUseNameBottomSheet(response.player_name ?? "");
      } else {
        _navigationService.gotoErrorPage(message: response.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }
  
  Future<void> twitterLogin() async {
    EasyLoading.show();
    Resource? result;
    try {
      result = await signInWithTwitter();
      if (result == null) {
        EasyLoading.dismiss();
        showAlertGTDialog(message: 'ログインに失敗しました\nerror_status:1');
      } else if (result.status != Status.Success) {
        EasyLoading.dismiss();
        showAlertGTDialog(message: 'ログインに失敗しました\nerror_status:2');
      } else if (result.twitterId.isEmpty) {
        EasyLoading.dismiss();
        showAlertGTDialog(message: 'ログインに失敗しました\nerror_status:3');
      } else {
        await loginApi(result.twitterId);
      }
    } catch (e) {
      //Failed Auth
      EasyLoading.dismiss();
      showAlertGTDialog(message: 'ログインに失敗しました。\nerror_status:4');
      if (e is FirebaseAuthException) {
        log('Firebase Auth Exception: ${e.toString()}');
      }
    }
  }

  Future<void> appleLogin() async {
    try{
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (appleCredential.userIdentifier != null) {
        _userSharePref.saveLoginType(2);
        await loginApiForApple(appleCredential.userIdentifier ?? "", appleCredential.email ?? "");
      }
    } catch(e) {
    }
  }
}
