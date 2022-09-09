import 'dart:io';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/component/bottom_sheet/entry_bottom_sheet.dart';
import 'package:Gametector/app/view/component/bottom_sheet/mypage_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

void HomeBottomSheet({String? message, String? url}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: transparent,
    context: context,
    builder: (BuildContext builderContext) {
      return FractionallySizedBox(
        heightFactor: 0.95,
        child: _homeBottomSheet(
          url: url,
        ),
      );
    },
  );
}


class _homeBottomSheet extends StatefulWidget {
  final String? url;
  const _homeBottomSheet({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  __homeBottomSheetState createState() => __homeBottomSheetState();
}

class __homeBottomSheetState extends State<_homeBottomSheet> {
  bool isFinishLoad = false;
  final String appToken = getIt<UserSharePref>().getAppToken();

  @override
  void initState() {
    super.initState();
    print (widget.url);
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
            padding: EdgeInsets.only(top: size_15_h, bottom: size_15_h, left:size_15_w, right:size_15_w,),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'asset/icons/ic_close.svg',
                    width: size_24_w,
                    height: size_24_w,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0.1,
            thickness: 0.1,
            color: Colors.white,
          ),
          Expanded(
            child: Stack(
              children: [
                WebView(
                  // TODO : move with bottom sheet
                  initialUrl: widget.url!+(widget.url!.contains("?") ? "&" : "?")+'device=flutter&app_token=$appToken',
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels: Set.from([
                    JavascriptChannel(
                      name: "openUrlModal",
                      onMessageReceived: (JavascriptMessage result) {
                        HomeBottomSheet(url: result.message);
                      },
                    ),
                    JavascriptChannel(
                      name: "openMoreMypage",
                      onMessageReceived: (JavascriptMessage result) {
                        print(result.message);
                        var uri = Uri.parse(result.message);
                        var params = uri.queryParameters;
                        MypageBottomSheet(
                          gameTitleId: int.parse(params["game_title_id"]!),
                          userId: int.parse(params["user_id"]!),
                          type: params["type"]!,
                        );
                      },
                    ),
                    JavascriptChannel(
                      name: "openEntrypage",
                      onMessageReceived: (JavascriptMessage result) {
                        print (result.message);
                        var params = Uri.parse(result.message).queryParameters;
                        var url = URL_ENTRY.replaceAll('{tournamentId}', params["tournament_id"]!)
                                              .replaceAll('{deviceType}', 'flutter');
                        entryBottomSheet(url: url);
                      },
                    ),
                    JavascriptChannel(
                      name: "openUrlTwitter",
                      onMessageReceived: (JavascriptMessage result) {
                        print (result.message);
                        var params = Uri.parse(result.message).queryParameters;
                        var scheme = TWITTER_URL_APP.replaceAll("{id}", params["id"]!);
                        var url = TWITTER_URL_WEB.replaceAll("{id}", params["id"]!);
                        launchScheme(scheme, url);
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
          ),
        ],
      ),
    );
  }
}
