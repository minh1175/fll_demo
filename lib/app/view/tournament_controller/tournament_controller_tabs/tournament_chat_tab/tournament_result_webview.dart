import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/common/res/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TournamentResultWebview extends StatefulWidget {
  final String? tournamentName;
  final String? rankingUrl;
  const TournamentResultWebview({
    Key? key,
    this.tournamentName,
    this.rankingUrl,
  }) : super(key: key);

  @override
  _TournamentResultWebviewState createState() => _TournamentResultWebviewState();
}

class _TournamentResultWebviewState extends State<TournamentResultWebview> {
  bool isFinishLoad = false;
  final String appToken = getIt<UserSharePref>().getAppToken();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding:EdgeInsets.only(top: size_20_h),
            height: size_80_h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){Navigator.of(context).pop();},
                  child: Padding(
                    padding: EdgeInsets.all(size_16_h),
                    child: SvgPicture.asset(
                      'asset/icons/ic_close.svg',
                      height: size_24_h,
                      width: size_24_h,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: size_50_h),
                    child: Text(
                      widget.tournamentName??'',
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
                  initialUrl: widget.rankingUrl!+'?app_token=$appToken',
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
    );
  }
}
