import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/service/analytics_log_service.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'di/injection.dart';
import 'module/utils/system_utils.dart';
import 'module/service/local_notification_service.dart';
import 'view/splash/splash_page.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize();
    AnalyticsLogService.initialize();
    SystemUtils.setPortraitScreenOrientation();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: kColor202330));
    FlutterAppBadger.removeBadge();
  }

  @override
  void dispose() {
    super.dispose();
    LocalNotificationService.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Container(
        color: kColor202330,
        child: MaterialApp(
          //hide badge debug
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
          builder: EasyLoading.init(),
          navigatorKey: getIt<NavigationService>().navigatorKey,
        ),
      ),
    );
  }
}
