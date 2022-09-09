import 'package:Gametector/app/module/common/config.dart';
import '../network_util.dart';


class HomeRequest {
  HomeRequest();

  Stream home() => get(API_HOME);

}
