import 'package:Gametector/app/module/common/config.dart';
import '../network_util.dart';


class AuthRequest {
  AuthRequest();

  Stream login(params) => post(API_APP_LOGIN, params: params);

  Stream logout() => post(API_APP_LOGOUT);

  Stream loginComplete(params) => post(API_APP_SIGNUP_COMPLETE, params: params);
}
