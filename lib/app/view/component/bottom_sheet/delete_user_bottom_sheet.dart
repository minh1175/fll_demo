import 'dart:convert';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/service/logout.dart';
import 'package:Gametector/app/view/component/custom/appbar_custom.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class DeleteUserBottomSheet extends StatefulWidget {
  const DeleteUserBottomSheet({Key? key}) : super(key: key);

  @override
  _DeleteUserBottomSheetState createState() => _DeleteUserBottomSheetState();
}

class _DeleteUserBottomSheetState extends State<DeleteUserBottomSheet> {
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
            backgroundColor: Colors.white,
            appBar: AppBarCustom(
              colorBackGround: kColor202330,
              resIcon: 'asset/icons/ic_close.svg',
              onPressIcon: () => getIt<NavigationService>().back(),
            ),
            body: Stack(
              children: [
                WebView(
                  initialUrl: URL_DELETE_USER + '?device=flutter&app_token=$appToken',
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels: Set.from([
                    JavascriptChannel(
                      name: "userDeleted",
                      onMessageReceived: (JavascriptMessage result) {
                        var res = json.decode(result.message);
                        print (result.message);
                        if (res["success"] == true) {
                          systemLogout();
                          showAlertGTDialog(
                            message:res["message"],
                            callback: (){
                              getIt<NavigationService>().refreshApp();
                            },
                          );
                        } else {
                          showAlertGTDialog(message:res["message"]);
                        }
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
        ),
      ),
    );
  }
}