import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/view/component/bottom_sheet/home_bottom_sheet.dart';
import 'package:Gametector/app/view/component/bottom_sheet/mypage_bottom_sheet.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/home/tabs/home_main/home_main_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeWebviewPage extends StatelessWidget {
  const HomeWebviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMainViewModel>(builder: (context, value, child) {
      return Container(
        color: kColor202330,
        child: Stack(
          children: [
            Visibility(
              visible: value.selectedGameTitleId != -1,
              child: WebView(
                backgroundColor: kColor202330,
                initialUrl: value.getWebviewUrl(),
                javascriptMode: JavascriptMode.unrestricted,
                javascriptChannels: Set.from([
                  JavascriptChannel(
                    name: "openWeb",
                    onMessageReceived: (JavascriptMessage result) {
                      launchURL(result.message);
                    },
                  ),
                  JavascriptChannel(
                    name: "openUrlModal",
                    onMessageReceived: (JavascriptMessage result) {
                      HomeBottomSheet(url: result.message);
                    },
                  ),
                  JavascriptChannel(
                    name: "openMypage",
                    onMessageReceived: (JavascriptMessage result) {
                      var uri = Uri.parse(result.message);
                      var params = uri.queryParameters;
                      MypageBottomSheet(
                        gameTitleId: int.parse(params["game_title_id"]!),
                        userId: int.parse(params["user_id"]!),
                        type: params["type"]!,
                      );
                    },
                  ),
                ]),
                gestureRecognizers: Set()
                  ..add(Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer())),
                onPageFinished: (v) {
                  value.finishWebviewLoad();
                },
                onWebViewCreated: (controller) {
                  value.setWebviewController(controller);
                },
              ),
            ),
            Visibility(
              visible: !value.isFinishLoad,
              child: BuildProgressLoading(),
            ),
          ],
        ),
      );
    });
  }
}
