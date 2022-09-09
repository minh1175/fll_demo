import 'dart:io';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void resultInputHistoryBottomSheet(String url) {
  BuildContext context =
      getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;
  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
  showModalBottomSheet(
    backgroundColor: transparent,
    context: context,
    enableDrag: true,
    isDismissible: false,
    isScrollControlled: true,
    builder: (BuildContext builderContext) {
      return makeDismissible(
          child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (BuildContext context, ScrollController scrollController) {
          return ResultInputHistoryBottomSheet(
            defaultAction: defaultAction,
            url: url,
          );
        },
      ));
    },
  );
}

class ResultInputHistoryBottomSheet extends StatefulWidget {
  final VoidCallback? defaultAction;
  final String url;

  const ResultInputHistoryBottomSheet(
      {Key? key, this.defaultAction, this.url = ""})
      : super(key: key);

  @override
  _ResultInputHistoryBottomSheetState createState() =>
      _ResultInputHistoryBottomSheetState();
}

class _ResultInputHistoryBottomSheetState
    extends State<ResultInputHistoryBottomSheet> {
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size_10_r),
        color: kColor202330,
      ),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 1, bottom: 5),
              child: SizedBox(
                width: 80,
                child: Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
              )),
          Expanded(
            child: Stack(
              children: [
                WebView(
                  // TODO : move with bottom sheet
                  initialUrl: widget.url + '?app_token=$appToken',
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels: Set.from([
                    JavascriptChannel(
                      name: "close",
                      onMessageReceived: (JavascriptMessage result) {
                        Navigator.pop(context);
                      },
                    ),
                  ]),
                  gestureRecognizers: Set()
                    ..add(Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer())),
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
          ),
        ],
      ),
    );
  }
}
