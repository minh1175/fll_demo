import 'package:Gametector/app/module/common/config.dart';
import '../network_util.dart';



class CommonRequest {
  CommonRequest();

  Stream start() => post(API_APP_START, params: null);
}
