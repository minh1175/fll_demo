import 'package:Gametector/app/module/common/config.dart';
import '../network_util.dart';


class SettingRequest {
  SettingRequest();

  Stream getSetting() => get(API_SETTING);

  Stream postSetting(params) => post(API_SETTING, params: params);
}
