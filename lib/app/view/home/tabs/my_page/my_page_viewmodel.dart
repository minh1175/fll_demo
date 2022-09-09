import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:Gametector/app/module/network/response/login_response.dart';
import 'package:Gametector/app/module/network/response/mypage_response.dart';
import 'package:Gametector/app/module/network/response/profile_info_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/model/webview_param.dart';
import 'package:Gametector/app/module/service/logout.dart';
import 'package:Gametector/app/view/component/bottom_sheet/delete_user_bottom_sheet.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/flutter_easyloading.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:Gametector/app/view/component/dialog/update_twitter_info_dialog.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game.dart';
import 'package:Gametector/app/view/webview/webview_page.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MyPageViewModel extends BaseViewModel {
  static MyPageViewModel? _cache;
  NavigationService _navigationService = getIt<NavigationService>();
  UserSharePref _userSharePref = getIt<UserSharePref>();

  final DataRepository _dataRepo;
  late BaseResponse _response;
  MyPageResponse? _myPageResponse;
  ProfileInfoResponse? _profileResponse;
  late BaseResponse _introductionPostResponse;
  LoginResponse? loginResponse = getIt<UserSharePref>().getUser();

  double endReachedThreshold = 200;
  bool isLoading = true;
  bool canLoadMore = true;
  LoadingState loadingState = LoadingState.LOADING;
  bool? isUpdateInfo = false;

  // for profile edit
  TextEditingController textProfileEditingController = new TextEditingController();
  TextEditingController textNameEditingController = new TextEditingController();
  ProfileItem? editDisplayLocation;
  ProfileItem? editDisplayBirthYear;
  ProfileItem? editDisplayBirthMonth;
  ProfileItem? editDisplayBirthDay;
  String editDisplayIntroduction = '';
  String editDisplayName = '';
  bool isEditPost = false;

  factory MyPageViewModel(dataRepo,) {
    if (_cache == null) _cache = new MyPageViewModel._(dataRepo);
    return _cache!;
  }

  void clear() {
    _cache?.dispose();
    _cache = null;
  }

  MyPageViewModel._(this._dataRepo,);

  set response(BaseResponse response) {
    _response = response;
    notifyListeners();
  }

  set myPageResponse(MyPageResponse? myPageResponse) {
    _myPageResponse = myPageResponse;
    notifyListeners();
  }

  set profileResponse(ProfileInfoResponse? profileResponse) {
    _profileResponse = profileResponse;
    notifyListeners();
  }

  set introductionPostResponse(BaseResponse response) {
    _introductionPostResponse = response;
  }

  MyPageResponse? get myPageResponse => _myPageResponse;

  BaseResponse get response => _response;

  ProfileInfoResponse? get profileResponse => _profileResponse;

  BaseResponse get introductionPostResponse => _introductionPostResponse;

  Future<void> logoutApi(context) async {
    final subscript = logout().listen((_) {
      if (response.success) {
        systemLogout();
        getIt<NavigationService>().refreshApp();
      } else {
        _navigationService.gotoErrorPage(message: response.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

  Stream logout() => _dataRepo
      .logout()
      .doOnData((r) => response = BaseResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      response = BaseResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Future<void> twitterInfoUpdateApi() async {
    final subscript = twitterInfoUpdate().listen((_) {
      if (response.success) {
        showUpdateTwitterInfoDialog(
            message: txt_update_twitter_info,
            actionString: txt_action_yes,
            defaultAction: () {
              _navigationService.back();
            });
      } else {
        _navigationService.gotoErrorPage(message: response.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

  Stream twitterInfoUpdate() => _dataRepo
      .twitterInfoUpdate()
      .doOnData((r) => response = BaseResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      response = BaseResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
    /*EasyLoading.show();*/
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Future<void> mypageApi() async {
    isLoading = true;
    final subscript = myPage().listen((_) {
      if (myPageResponse != null && myPageResponse!.success) {
        loadingState = LoadingState.DONE;
      } else {
        if (loadingState != LoadingState.ERROR) {
          loadingState = LoadingState.ERROR;
        }
        _navigationService.gotoErrorPage(message: response.error_message);
      }
    }, onError: (e) {
      isLoading = false;
      notifyListeners();
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

  Stream myPage() => _dataRepo
      .mypage()
      .doOnData((r) => myPageResponse = MyPageResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      myPageResponse = MyPageResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
    /*EasyLoading.show();*/
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Future<void> profileAPI() async {
    var params = <String, dynamic>{};
    final subscript = profileInfo(params).listen((_) {
      if (profileResponse != null && profileResponse!.success) {
        profileResponse = profileResponse;
        initEditProfileData();
        _userSharePref.getUser();
      } else {
        _navigationService.gotoErrorPage(
            message: profileResponse?.error_message);
      }
    }, onError: (e) {
      _navigationService.gotoErrorPage();
    });
    addSubscription(subscript);
  }

  Stream profileInfo(Map<String, dynamic> params) => _dataRepo
      .profile(params)
      .doOnData((r) => profileResponse = ProfileInfoResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      profileResponse = ProfileInfoResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
    /*EasyLoading.show();*/
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  Future<void> introductionPostApi() async {
    String trimedUserName = this.editDisplayName.trim();
    if (trimedUserName.length <= 0 || trimedUserName.length > 50) {
      showAlertGTDialog(message: "ユーザー名は1~50文字で入力してください。");
      return;
    }
    var params = <String, dynamic>{
      'user_name': trimedUserName,
      'introduction': this.editDisplayIntroduction,
      'birth_year': this.editDisplayBirthYear?.value,
      'birth_month': this.editDisplayBirthMonth?.value,
      'birth_day': this.editDisplayBirthDay?.value,
      'location': this.editDisplayLocation?.value,
    };
    if (profileResponse != null) {
      introductionPost(params).listen((_) {
        if (introductionPostResponse.success) {
          mypageApi();
          _navigationService.back();
        } else {
          _navigationService.gotoErrorPage(message: introductionPostResponse.error_message);
        }
      }, onError: (e) {
        _navigationService.gotoErrorPage(message: e);
      });
    } else {
      _navigationService.back();
    }
  }

  Stream introductionPost(Map<String, dynamic> params) => _dataRepo
      .introductionPost(params)
      .doOnData((r) => introductionPostResponse = BaseResponse.fromJson(r))
      .doOnError((e, stacktrace) {
    if (e is DioError) {
      introductionPostResponse = BaseResponse.fromJson(e.response?.data.trim() ?? '');
    }
  }).doOnListen(() {
    EasyLoading.show();
  }).doOnDone(() {
    EasyLoading.dismiss();
  });

  void openMypageGameFromPush(BuildContext context){
    int initialGameTitleId = getIt<NavigationService>().myPageGameTitileIdFromPush;
    if (initialGameTitleId != -1) {
      String initialType = getIt<NavigationService>().myPageTypeFromPush;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyPageGame(
            gameTitleId: initialGameTitleId,
            type: initialType,
          ),
        ),
      );
      getIt<NavigationService>().myPageGameTitileIdFromPush = -1;
    }
  }

  void showTerm() {
    _navigationService.pushEnterFadeExitDown(WebviewPage(WebviewParam(url: URL_TERMS_OF_SERVICE)));
  }

  void showPolicy() {
    _navigationService.pushEnterFadeExitDown(WebviewPage(WebviewParam(url: URL_PRIVACY_POLICY)));
  }

  void setEditProfileDisplay(String type, ProfileItem item) {
    switch (type) {
      case "_location":
        this.editDisplayLocation = item;
        break;
      case "_birthYear":
        this.editDisplayBirthYear = item;
        break;
      case "_birthMonth":
        this.editDisplayBirthMonth = item;
        break;
      case "_birthDay":
        this.editDisplayBirthDay = item;
        break;
    }
    notifyListeners();
  }

  void setEditProfileIntroduction(String introduction) {
    this.editDisplayIntroduction = introduction;
    notifyListeners();
  }

  void setEditNameIntroduction(String name) {
    this.editDisplayName = name;
    notifyListeners();
  }

  void initEditProfileData() {
    this.editDisplayLocation = _findProfileItemIndex(this.profileResponse!.location_list, this.profileResponse!.location);
    this.editDisplayBirthYear = _findProfileItemIndex(this.profileResponse!.birth_year_list, this.profileResponse!.birth_year);
    this.editDisplayBirthMonth = _findProfileItemIndex(this.profileResponse!.birth_month_list, this.profileResponse!.birth_month);
    this.editDisplayBirthDay = _findProfileItemIndex(this.profileResponse!.birth_day_list, this.profileResponse!.birth_day);
    this.editDisplayIntroduction = this.profileResponse?.introduction ?? '' ;
    this.editDisplayName = this.profileResponse!.user_name!;
    this.textProfileEditingController.text = this.editDisplayIntroduction;
    this.textNameEditingController.text = this.editDisplayName;
  }

  ProfileItem? _findProfileItemIndex(List<ProfileItem>? list, String? value) {
    final index = list!.indexWhere((item) => item.value == value);
    return index >= 0 ? list[index] : null;
  }

  void deleteAccount() {
    _navigationService.pushEnterFadeExitDown(DeleteUserBottomSheet());
  }
}
