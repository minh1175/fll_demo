import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import '../di/injection.dart';
import '../module/socket/socket_manager.dart';

abstract class LifecycleState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  var socketManager = getIt<SocketManager>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print ("lifeCycleBase paused:{$T}");
    } else if (state == AppLifecycleState.resumed) {
      print ("lifeCycleBase resumed:{$T}");
      FlutterAppBadger.removeBadge();
      socketManager.initSocket();
    } else if (state == AppLifecycleState.detached) {
      print ("lifeCycleBase detached:{$T}");
      socketManager.disconnect();
    }
  }
}
