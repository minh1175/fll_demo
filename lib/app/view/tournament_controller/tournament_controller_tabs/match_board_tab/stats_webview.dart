import 'dart:convert';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/common/res/style.dart';
import 'package:Gametector/app/view/component/bottom_sheet/mypage_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StatsWebview extends StatefulWidget {
  final int? tournamentRoundId;
  const StatsWebview({Key? key, this.tournamentRoundId}) : super(key: key);

  @override
  _StatsWebviewState createState() => _StatsWebviewState();
}

class _StatsWebviewState extends State<StatsWebview> {
  bool isFinishLoad = false;
  final String appToken = getIt<UserSharePref>().getAppToken();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColor202330,
      child: SafeArea(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: Scaffold(
            body: Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kColor202330,
                      border: Border(
                        bottom: BorderSide(
                          color: kColoraaaaaa,
                          width: 1,
                        ),
                      ),
                    ),
                    padding:EdgeInsets.only(top: size_5_h, bottom: size_5_h,),
                    // height: size_80_h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(size_10_w),
                            child: SvgPicture.asset(
                              'asset/icons/ic_close.svg',
                              height: size_24_w,
                              width: size_24_w,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: size_50_h),
                            child: Text(
                              txt_stats,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: text_15,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        WebView(
                          initialUrl: URL_MATCH_STATS.replaceAll('{tournamentRoundId}', widget.tournamentRoundId.toString())+'?device=flutter&app_token=$appToken',
                          javascriptMode: JavascriptMode.unrestricted,
                          javascriptChannels: Set.from([
                            JavascriptChannel(
                              name: "openMypage",
                              onMessageReceived: (JavascriptMessage result) {
                                final params = jsonDecode(result.message);
                                MypageBottomSheet(
                                  gameTitleId: params["gameTitleId"]!,
                                  userId: params["userId"]!,
                                  type: "player",
                                );
                              },
                            ),
                          ]),
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
            ),
          ),
        ),
      ),
    );
  }
}
