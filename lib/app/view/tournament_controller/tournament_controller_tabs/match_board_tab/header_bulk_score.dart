import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/swiss_round_decision_bottom_sheet.dart';
import 'package:Gametector/app/view/component/bottom_sheet/bulk_approval_sheet.dart';
import 'package:Gametector/app/view/component/bottom_sheet/end_tournament.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_board_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderBulkScore extends StatelessWidget {
  final int competitionType;
  final int? leagueType;
  final bool isAllRoundFinish;
  const HeaderBulkScore({
    Key? key,
    required this.competitionType,
    required this.leagueType,
    required this.isAllRoundFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchBoardViewModel>(builder: (context, value, child) {
      return Visibility(
        visible: (value.resMatchList?.role_type == 'organizer' || value.resMatchList?.role_type == 'both'),
        child: Container(
          padding: EdgeInsets.only(top: size_10_h),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size_5_r,),
            ),
            elevation: 1,
            child: Container(
              padding: EdgeInsets.all(size_2_w,),
              decoration: BoxDecoration(
                color: kColor2b2e3e,
                borderRadius: BorderRadius.circular(size_5_r,),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(size_10_w,),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              bulkApprovalBottomSheet(value.tournamentId, this.competitionType);
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(size_10_w),
                                        child: Image.asset(
                                          'asset/icons/icon_regist_score.png',
                                          height: size_20_w,
                                          width: size_20_w,
                                        ),
                                      ),
                                      Visibility(
                                        visible: ((value.resMatchList?.unapproved_count?? 0) > 0),
                                        child: Positioned(  // draw a red marble
                                          top: 0.0,
                                          right: 0.0,
                                          child: new Icon(
                                            Icons.brightness_1,
                                            size: 14.0,
                                            color: kColorD0021C,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    txt_approve_collectively,
                                    style: TextStyle(color: Colors.white, fontSize: text_12,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: this.competitionType == 2,
                          child: Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: (() {
                                SwissRoundDecisionBottomSheet(tournamentId: value.tournamentId, isAllRoundFinish: this.isAllRoundFinish);
                              }),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(size_10_w),
                                      child: Image.asset(
                                        'asset/icons/icon_drop_player.png',
                                        height: size_20_w,
                                        width: size_20_w,
                                      ),
                                    ),
                                    Text(
                                      txt_athletes_abstain,
                                      style: TextStyle(color: Colors.white, fontSize: text_12,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (this.competitionType == 2 && this.leagueType == 1),
                          child: Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                endTournamentBottomSheet(tournamentId: value.tournamentId,);
                              },
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(size_10_w),
                                      child: Image.asset(
                                        'asset/icons/icon_stop_tournament.png',
                                        height: size_20_w,
                                        width: size_20_w,
                                      ),
                                    ),
                                    Text(
                                      txt_end_of_the_tournament,
                                      style: TextStyle(color: Colors.white, fontSize: text_12,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size_1_h,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size_10_h, horizontal: size_10_w,),
                    child: Container(
                      child: Text(
                        value.resMatchList?.explain ?? '',
                        style: TextStyle(color: Colors.white, fontSize: text_12,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}