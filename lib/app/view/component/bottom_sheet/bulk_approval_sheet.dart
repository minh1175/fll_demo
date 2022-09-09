// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/bulk_score_input_response.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/bottom_sheet_container.dart';
import 'package:Gametector/app/view/component/dialog/suggest_finish_tournament_dialog.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_board_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:webview_flutter/webview_flutter.dart';

// TODO : refresh matchboard if bulk approval post complete
void bulkApprovalBottomSheet(int tournamentId, int competitionType) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: transparent,
    builder: (BuildContext builderContext) {
      return FractionallySizedBox(
        heightFactor: 0.90,
        child: BulkApprovalPage(
          defaultAction: defaultAction,
          tournamentId: tournamentId,
          competitionType: competitionType,
        ),
      );
    },
  );
}

class BulkApprovalPage extends PageProvideNode<MatchBoardViewModel> {
  final int tournamentId;
  final int competitionType;
  VoidCallback? defaultAction;

  BulkApprovalPage({
    Key? key,
    this.defaultAction,
    this.tournamentId = 0,
    this.competitionType = 0
  }) : super(key: key, params: [tournamentId]);

  @override
  Widget buildContent(BuildContext context) {
    return BulkApprovalBottomSheet(
      viewModel,
      key: key,
      tournamentId: tournamentId,
      competitionType: competitionType,
    );
  }
}

class BulkApprovalBottomSheet extends StatefulWidget {
  final int tournamentId;
  final int competitionType;
  final MatchBoardViewModel _matchBoardViewModel;
  VoidCallback? defaultAction;

  BulkApprovalBottomSheet(this._matchBoardViewModel, {
    Key? key,
    this.tournamentId = 0,
    this.competitionType = 0
  }) : super(key: key);

  @override
  State<BulkApprovalBottomSheet> createState() => _BulkApprovalBottomSheetState();
}

class _BulkApprovalBottomSheetState extends State<BulkApprovalBottomSheet>
    with SingleTickerProviderStateMixin {
  MatchBoardViewModel get matchBoardViewModel => widget._matchBoardViewModel;
  late WebViewController _controller;
  NavigationService _navigationService = getIt<NavigationService>();
  final String _appToken = getIt<UserSharePref>().getAppToken();

  @override
  void initState() {
    matchBoardViewModel.bulkScoreInfoListApi(widget.tournamentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchBoardViewModel>(builder: (context, value, child) {
      return BottomSheetContainer(
        child: Column(
          children: [
            Container(
              width: 1.0,
              height: 1.0,
              child: widget.competitionType != 1
                  ? null
                  : WebView(
                      initialUrl: URL_ORGANIZER_POST_SCORE.replaceAll('{tournamentId}', widget.tournamentId.toString())+'?app_token=$_appToken',
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController controller) {
                        _controller = controller;
                      },
                      javascriptChannels: Set.from([
                        JavascriptChannel(
                            name: "postComplete",
                            onMessageReceived: (JavascriptMessage result) {
                              Map resultJson = json.decode(result.message);
                              if (resultJson["success"]) {
                                eventBus.fire(PushUpdateMatchBoardEvent(widget.tournamentId));
                                Navigator.pop(context);
                                if (resultJson["is_all_round_finish"] == 1) {
                                  suggestFinishTournamentDialog(widget.tournamentId);
                                }
                              } else {
                                _navigationService.gotoErrorPage();
                              }
                            }),
                      ])),
            ),
            Container(
              height: size_100_h,
              padding: EdgeInsets.symmetric(horizontal: size_15_w,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sprintf(txt_bulk_approval_select, [value.selectedBulkCount]),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_14,
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      txt_do_bulk_approval,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kColor247EF1,
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size_10_r),
                      ),
                    ),
                    onPressed: () {
                      List<Item> checkedScore = [];
                      for (var s in value.lsScore) {
                        if (s.is_check_item) {
                          checkedScore.add(s);
                        }
                      }
                      if (checkedScore.length == 0) {return;}

                      String bulkScoreJsonString = jsonEncode(checkedScore).replaceFirst('"', '\"');
                      if (widget.competitionType == 1) {
                        _controller.runJavascript("postBulkScoreForFlutter('${_appToken}', '${bulkScoreJsonString}');");
                      } else {
                        matchBoardViewModel.bulkOrganizerLeaguePostApi(widget.tournamentId, bulkScoreJsonString);
                      }
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.lsScore.length,
                itemBuilder: (BuildContext context, int index) {
                  return getItem(index, value.lsScore[index], matchBoardViewModel.changeCheckBulkItem);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget getItem(int idx, Item item, Function changeSelectedCount) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: kColor2b2e3e,
        border: const Border(
          bottom: BorderSide(
            color: kColor1D212C,
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MATCH " + item.round_box_no.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: text_16,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              child: CircleAvatar(
                                backgroundColor: kColor212430,
                                backgroundImage:
                                NetworkImage(item.player_thumb_left),
                              ),
                            ),
                            SizedBox(width: size_14_w,),
                            Expanded(
                              child: Text(
                                item.player_name_left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: text_13,
                                ),
                              ),
                            ),
                            SizedBox(width: size_14_w,),
                            Text(
                              _getWinLoseText(item.win_lose_type_left, item.score_left),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ["3", "4"].contains(item.win_lose_type_left) ? text_11 : text_20,
                              ),
                            ),
                            SizedBox(width: size_16_w,),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              child: CircleAvatar(
                                backgroundColor: kColor212430,
                                backgroundImage: NetworkImage(item.player_thumb_right),
                              ),
                            ),
                            SizedBox(width: size_14_w,),
                            Expanded(
                              child: Text(
                                item.player_name_right,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: text_13,
                                ),
                              ),
                            ),
                            SizedBox(width: size_14_w,),
                            Text(
                              _getWinLoseText(item.win_lose_type_right, item.score_right),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ["3", "4"].contains(item.win_lose_type_right) ? text_11 : text_20,
                              ),
                            ),
                            SizedBox(width: size_16_w,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  item.win_certification_url != null && item.win_certification_url != ""
                      ? Container(
                    width: 130.0,
                    height: 100.0,
                    color: kColor1D212C,
                    child: Image(
                      image: NetworkImage(item.win_certification_url ?? ""),
                    ),
                  )
                      : Container(
                    width: 130.0,
                    height: 100.0,
                    color: kColor1D212C,
                    alignment: Alignment.center,
                    child: Text(
                      "勝利証明なし",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_11,
                      ),
                    ),
                  ),
                  SizedBox(width: size_10_w,),
                  GestureDetector(
                    onTap: () {
                      changeSelectedCount(idx, !item.is_check_item);
                    },
                    child: Image(
                      width: 30,
                      height: 30,
                      image: (item.is_check_item == true)
                          ? AssetImage('asset/icons/ic_check_on.png')
                          : AssetImage('asset/icons/ic_check_off.png'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getWinLoseText(String type, int? score) {
    String res = score!.toString();
    if (type == "3") {
      res = "不戦勝";
    } else if (type == "4") {
      res = "不戦敗";
    }
    return res;
  }
}
