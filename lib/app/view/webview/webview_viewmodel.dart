import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/model/webview_param.dart';

import '../../viewmodel/base_viewmodel.dart';

class WebviewViewModel extends BaseViewModel {
  NavigationService navigationService = getIt<NavigationService>();
  bool _loading = true;
  WebviewParam? webviewParam = null;

  WebviewViewModel({this.webviewParam});

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}
