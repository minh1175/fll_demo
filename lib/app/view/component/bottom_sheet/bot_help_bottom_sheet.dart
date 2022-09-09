import 'dart:convert';
import 'dart:io';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/view/component/common/bottom_sheet_container.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_finish_page.dart';
import 'package:Gametector/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void botHelpBottomSheet({String? message, String? url, int? tournamentId}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
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
          return BotHelpBottomSheet(
            defaultAction: defaultAction,
            url: url,
            tournamentId: tournamentId,
          );
        },
      ));
    },
  );
}

class BotHelpBottomSheet extends StatefulWidget {
  final VoidCallback? defaultAction;
  final String? url;
  final int? tournamentId;

  const BotHelpBottomSheet({Key? key, this.defaultAction, this.url, this.tournamentId})
      : super(key: key);

  @override
  _BotHelpBottomSheetState createState() => _BotHelpBottomSheetState();
}

class _BotHelpBottomSheetState extends State<BotHelpBottomSheet> {
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
          WebView(
            initialUrl: widget.url! + '?device=flutter&app_token=$appToken',
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: Set.from([
              JavascriptChannel(
                name: "close",
                onMessageReceived: (JavascriptMessage result) {
                  eventBus.fire(RefreshTournamentChatEvent(widget.tournamentId?? -1));
                  Navigator.pop(context);
                },
              ),
              JavascriptChannel(
                name: "openFinishPage",
                onMessageReceived: (JavascriptMessage result) {
                  var params = jsonDecode(result.message);
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TournamentFinishPage(
                        tournamentId: int.parse(params["tournament_id"]!),
                        competitionType: int.parse(params["competition_type"]!),
                      ),
                    ),
                  );
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
