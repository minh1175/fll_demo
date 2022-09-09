import 'dart:io';

import 'package:Gametector/app/module/common/res/style.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TournamentBracketWebview extends StatefulWidget {
  final String tournamentName;
  final String appBracketUrl;
  final VoidCallback callBack;
  const TournamentBracketWebview({
    Key? key,
    required this.tournamentName,
    required this.appBracketUrl,
    required this.callBack,
  }) : super(key: key);

  @override
  _TournamentBracketWebviewState createState() => _TournamentBracketWebviewState();
}

class _TournamentBracketWebviewState extends State<TournamentBracketWebview> {
  bool isFinishLoad = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // for android back button
        widget.callBack();
        return true;
      },
      child: Container(
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
                      padding: EdgeInsets.only(
                        top: size_5_h,
                        bottom: size_5_h,
                      ),
                      decoration: BoxDecoration(
                        color: kColor202330,
                        border: Border(
                          bottom: BorderSide(
                            color: kColoraaaaaa,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              widget.callBack();
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
                            child: Container(
                              padding: EdgeInsets.only(right: size_40_w,),
                              child: Text(
                                widget.tournamentName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                            initialUrl: widget.appBracketUrl,
                            javascriptMode: JavascriptMode.unrestricted,
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
      ),
    );
  }
}
