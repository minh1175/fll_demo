import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/view/component/bottom_sheet/mypage_bottom_sheet.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/rule_overview_tab/tournament_players.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

class RuleOverviewTab extends StatelessWidget {
  RuleOverviewTab({Key? key,}) : super(key: key);

  List<Widget> get _TournamentInfoLists => [
    Consumer<TournamentControllerViewModel>(builder: (context, value, child) {
      return Container(
        height: size_60_h,
        child: Row(
          children: [
            Container(
              width: size_60_w,
              child: Image.network(
                value.tournamentInfo!.game_icon_thumb_url!,
                alignment: Alignment.centerLeft,
                width: size_40_w,
                height: size_40_w,
              ),
            ),
            Text(
              value.tournamentInfo!.game_title_name!,
              style: TextStyle(
                color: kCWhite,
                fontWeight: FontWeight.bold,
                fontSize: text_14,
              ),
            ),
          ],
        ),
      );
    }),
    Consumer<TournamentControllerViewModel>(builder: (context, value, child) {
      return Container(
        height: size_60_h,
        child: Row(
          children: [
            Container(
              width: size_60_w,
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size_20_w),
                child: Container(
                  height: size_40_w,
                  width: size_40_w,
                  color: kColor33353F,
                  child: SvgPicture.asset(
                    'asset/icons/ic_bracket.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value.tournamentInfo!.competition_type_str!,
                  style: TextStyle(
                    color: kCWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: text_14,
                  ),
                ),
                Text(
                  value.tournamentInfo!.tournament_type_str?? '',
                  style: TextStyle(
                    color: kCWhite,
                    fontSize: text_10,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }),
    Consumer<TournamentControllerViewModel>(builder: (context, value, child) {
      return Container(
        height: size_60_h,
        child: Row(
          children: [
            Container(
              width: size_60_w,
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size_20_w),
                child: Container(
                  height: size_40_w,
                  width: size_40_w,
                  color: kColor33353F,
                  child: SvgPicture.asset(
                    'asset/icons/ic_schedule.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Text(
              value.tournamentInfo!.schedule_ymdhis ?? '',
              style: TextStyle(
                color: kCWhite,
                fontWeight: FontWeight.bold,
                fontSize: text_14,
              ),
            ),
          ],
        ),
      );
    }),
  ];

  List<Widget> get _OrganizerInfoLists => [
    Consumer<TournamentControllerViewModel>(builder: (context, value, child) {
      return GestureDetector(
        onTap: (){
          MypageBottomSheet(
            gameTitleId: value.tournamentInfo!.game_title_id!,
            userId: value.tournamentInfo!.organizer_user_id!,
            type: "organizer",
          );
        },
        child: Container(
          height: size_60_h,
          child: Row(
            children: [
              Container(
                width: size_60_w,
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size_20_w),
                  child: Image.network(
                    value.tournamentInfo!.organizer_thumb_url!,
                    width: size_40_w,
                    height: size_40_w,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value.tournamentInfo!.organizer_name!,
                  style: TextStyle(
                    color: kCWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: text_14,
                  ),
                ),
              ),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.all(size_16_h),
                  child: SvgPicture.asset(
                    'asset/icons/ic_right_arrow.svg',
                    height: size_12_h,
                    width: size_12_h,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }),
  ];

  List<Widget> get _playerInfoLists => [
    Consumer<TournamentControllerViewModel>(builder: (context, value, child) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TournamentPlayers(
                    gameTitleId: value.tournamentInfo!.game_title_id!,
                    tournamentId: value.tournamentInfo!.tournament_id!,
                  ),
            ),
          );
        },
        child: Container(
          height: size_60_h,
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: size_60_w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size_20_w),
                  child: Container(
                    height: size_40_w,
                    width: size_40_w,
                    color: kColor33353F,
                    child: SvgPicture.asset(
                      'asset/icons/ic_attendees.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  sprintf(
                      txt_tournament_participating, [value.tournamentInfo!.real_entry_player_num]),
                  style: TextStyle(
                    color: kCWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: text_14,
                  ),
                ),
              ),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.all(size_16_h),
                  child: SvgPicture.asset(
                    'asset/icons/ic_right_arrow.svg',
                    height: size_12_h,
                    width: size_12_h,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }),
  ];

  List<Widget> get _TournamentRuleLists => [
    Consumer<TournamentControllerViewModel>(builder: (context, value, child){
      return Linkify(
        onOpen: (link) => launchURL(link.url),
        text: value.tournamentInfo!.rule!,
        style: TextStyle(
          color: kCWhite,
          fontWeight: FontWeight.bold,
          fontSize: text_14,
        ),
      );
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColor202330,
      margin: EdgeInsets.only(left:size_20_w, right: size_20_w,),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size_40_h,),
            Text(
              txt_tournament_info,
              style: TextStyle(
                color: kCWhite,
                fontWeight: FontWeight.bold,
                fontSize: text_12,
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.only(top: 0, bottom: 0,),
              shrinkWrap: true,   //追加
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return (index == 0 || index == _TournamentInfoLists.length + 1) ? Container() : _TournamentInfoLists[index - 1];
              },
              separatorBuilder: (BuildContext context, int index) =>  Divider(
                thickness: 0.3,
                color: kCWhite,
              ),
              itemCount: _TournamentInfoLists.length + 2,
            ),
            SizedBox(height: size_40_h,),
            Text(
              txt_tournament_organizer,
              style: TextStyle(
                color: kCWhite,
                fontWeight: FontWeight.bold,
                fontSize: text_12,
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.only(top: 0, bottom: 0,),
              shrinkWrap: true,   //追加
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return (index == 0 || index == _OrganizerInfoLists.length + 1) ? Container() : _OrganizerInfoLists[index - 1];
              },
              separatorBuilder: (BuildContext context, int index) =>  Divider(
                thickness: 0.3,
                color: kCWhite,
              ),
              itemCount: _OrganizerInfoLists.length + 2,
            ),
            SizedBox(height: size_40_h,),
            Text(
              txt_tournament_player,
              style: TextStyle(
                color: kCWhite,
                fontWeight: FontWeight.bold,
                fontSize: text_12,
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.only(top: 0, bottom: 0,),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return (index == 0 || index == _playerInfoLists.length + 1) ? Container() : _playerInfoLists[index - 1];
              },
              separatorBuilder: (BuildContext context, int index) =>  Divider(
                thickness: 0.3,
                color: kCWhite,
              ),
              itemCount: _playerInfoLists.length + 2,
            ),
            SizedBox(height: size_40_h,),
            Text(
              txt_tournament_rule,
              style: TextStyle(
                color: kCWhite,
                fontWeight: FontWeight.bold,
                fontSize: text_12,
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.only(top: 0, bottom: 0,),
              shrinkWrap: true,   //追加
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return (index == 0) ? Container() : _TournamentRuleLists[index - 1];
              },
              separatorBuilder: (BuildContext context, int index) =>  Divider(
                thickness: 0.3,
                color: kCWhite,
              ),
              itemCount: _TournamentRuleLists.length + 1,
            ),
            SizedBox(height: size_40_h,),
          ],
        ),
      ),
    );
  }
}
