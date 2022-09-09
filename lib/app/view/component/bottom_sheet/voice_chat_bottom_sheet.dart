import 'dart:io';
import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/view/component/common/bottom_sheet_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void voiceChatBottomSheet({String? message, String? url}) {
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
          return VoiceChatBottomSheet(
            defaultAction: defaultAction,
            url: url,
          );
        },
      ));
    },
  );
}

class VoiceChatBottomSheet extends StatefulWidget {
  final VoidCallback? defaultAction;
  final String? url;

  VoiceChatBottomSheet({Key? key, this.defaultAction, this.url})
      : super(key: key);

  @override
  _VoiceChatBottomSheetState createState() => _VoiceChatBottomSheetState();
}

class _VoiceChatBottomSheetState extends State<VoiceChatBottomSheet> {
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
          WebView(
            // TODO : move with bottom sheet
            onWebViewCreated: (WebViewController controller) {
              var posY = controller.getScrollY();
              print(posY);
            },
            initialUrl: widget.url! + '?device=flutter&app_token=$appToken',
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: Set.from([
              JavascriptChannel(
                name: "openUrl",
                onMessageReceived: (JavascriptMessage result) {
                  launchURL(result.message);
                },
              ),
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
    );
  }
}
