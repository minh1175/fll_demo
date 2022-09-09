import 'dart:io';
import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/view/component/common/bottom_sheet_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void CheckinBottomSheet({String? message, int? tournamentId}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: transparent,
    context: context,
    builder: (BuildContext builderContext) {
      return FractionallySizedBox(
        heightFactor: 0.90,
        child: _checkinBottomSheet(
          tournamentId: tournamentId,
        ),
      );
    },
  );
}

class _checkinBottomSheet extends StatefulWidget {
  final int? tournamentId;
  const _checkinBottomSheet({
    Key? key,
    this.tournamentId,
  }) : super(key: key);

  @override
  __checkinBottomSheetState createState() => __checkinBottomSheetState();
}

class __checkinBottomSheetState extends State<_checkinBottomSheet> {
  bool isFinishLoad = false;
  final String appToken = getIt<UserSharePref>().getAppToken();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Stack(
        children: [
          // TODO : move with bottom sheet
          // TODO : update tournamentInfo if checkin complete.
          WebView(
            initialUrl: URL_CHECKIN
                .replaceAll('{tournamentId}', widget.tournamentId.toString())
                .replaceAll('{deviceType}', 'flutter')
                +'?app_token=$appToken',
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: Set.from([
              JavascriptChannel(
                name: "close",
                onMessageReceived: (JavascriptMessage result) {
                  Navigator.pop(context);
                },
              ),
            ]),
            gestureRecognizers: Set()..add(Factory<OneSequenceGestureRecognizer>(()=> EagerGestureRecognizer())),
            onPageFinished: (value) {
              setState(() {
                isFinishLoad = true;
              });
            },
          ),
          Visibility(
            visible: !isFinishLoad,
            child: Container(
              color: kColor202330,
            ),
          ),
        ],
      ),
    );
  }
}