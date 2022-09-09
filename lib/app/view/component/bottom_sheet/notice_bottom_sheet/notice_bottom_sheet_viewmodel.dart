import 'dart:core';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/base_response.dart';
import 'package:Gametector/app/module/network/response/get_setting_response.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class NoticeBottomSheetViewModel extends BaseViewModel {
  NavigationService _navigationService = getIt<NavigationService>();
  final DataRepository _dataRepo;
  GetSettingResponse? _settingResponse;
  BaseResponse? _postSettingResponse;

  NoticeBottomSheetViewModel(this._dataRepo);

  set settingResponse(GetSettingResponse? response) {
    _settingResponse = response;
    notifyListeners();
  }

  set postSettingResponse(BaseResponse? response) {
    _postSettingResponse = response;
    notifyListeners();
  }

  GetSettingResponse? get settingResponse => this._settingResponse;

  BaseResponse? get postSettingResponse => this._postSettingResponse;

  Stream getSetting() => _dataRepo
          .setting()
          .doOnData((r) => settingResponse = GetSettingResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        print(e.toString());
        if (e is DioError) {
          settingResponse =
              GetSettingResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {
        // EasyLoading.show();
      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> getSettingAPI() async {
    final subscript = this.getSetting().listen((_) {
      if (settingResponse != null && settingResponse!.success) {
      } else
        _navigationService.gotoErrorPage(
            message: settingResponse?.error_message);
    }, onError: (e) {
      notifyListeners();
      _navigationService.gotoErrorPage();
    });
    this.addSubscription(subscript);
  }

  Stream postSetting(Map<String, dynamic> params) => _dataRepo
          .postSetting(params)
          .doOnData((r) => postSettingResponse = BaseResponse.fromJson(r))
          .doOnError((e, stacktrace) {
        if (e is DioError) {
          postSettingResponse =
              BaseResponse.fromJson(e.response?.data.trim() ?? '');
        }
      }).doOnListen(() {
        EasyLoading.show();
      }).doOnDone(() {
        EasyLoading.dismiss();
      });

  Future<void> postSettingApi() async {
    var params = <String, dynamic>{};
    for (Item group in settingResponse?.list ?? []) {
      for (Content content in group.content ?? []) {
        params.putIfAbsent(content.key!, () => content.flg_on);
      }
    }

    if (settingResponse != null) {
      final subscript = this.postSetting(params).listen((_) {
        if (postSettingResponse!.success) {
          _navigationService.back();
        } else {
          _navigationService.gotoErrorPage(
              message: postSettingResponse!.error_message);
        }
      }, onError: (e) {
        _navigationService.gotoErrorPage(message: e);
      });
    } else {
      _navigationService.gotoErrorPage(message: "");
    }
  }

  void changeSetting(String key, int value) {
    for (Item group in settingResponse?.list ?? []) {
      final index = group.content!.indexWhere((item) => item.key == key);
      print(index);
      if (index >= 0) {
        group.content![index].flg_on = value;
        notifyListeners();
        return;
      }
    }
  }
}
