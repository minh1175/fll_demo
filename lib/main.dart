// @dart=2.9
import 'dart:async';

import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/app.dart';
import 'app/di/injection.dart';
import 'app/view/component/custom/flutter_easyloading/custom_animation_loading.dart';
import 'app/view/component/custom/flutter_easyloading/src/easy_loading.dart';
import 'package:event_bus/event_bus.dart';

//event bus global
EventBus eventBus = EventBus();

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    //Start DI
    await SharedPrefManager.getInstance();
    await configureDependencies();
    await Firebase.initializeApp();
    configLoading();
    Key key = UniqueKey();
    runApp(ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext context, Widget child) => App(),
    ));
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..contentPadding = EdgeInsets.zero
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black26
    ..indicatorColor = Colors.white
    ..textColor = Colors.yellow
    ..maskColor = Colors.black.withOpacity(0.3)
    ..maskType = EasyLoadingMaskType.custom
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}