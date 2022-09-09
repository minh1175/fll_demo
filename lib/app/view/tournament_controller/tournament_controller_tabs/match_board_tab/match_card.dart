import 'package:Gametector/app/module/network/response/match_board_list_response.dart';
import 'package:Gametector/app/view/component/bottom_sheet/mypage_bottom_sheet.dart';
import 'package:Gametector/app/view/component/common/grayed_out.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/chat_private_page.dart';
import 'package:flutter/material.dart';
import 'package:Gametector/app/module/common/res/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../score_input/score_input_page.dart';
import 'stats_webview.dart';

class MatchCard extends StatelessWidget {
  final int gameTitleId;
  final int tournamentId;
  final ItemMatch match;

  MatchCard({
    Key? key,
    required this.gameTitleId,
    required this.tournamentId,
    required this.match
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size_5_r),
        color: kColor2b2e3e,
      ),
      child: Column(
        children: [
          Container(
            // Header
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size_5_r),
              color: kColor373C4A,
            ),
            padding:
                EdgeInsets.symmetric(vertical: size_12_h, horizontal: size_6_w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ChatAccessTime(
                    chatAccessTime: match.chat_last_access_time_left,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    match.round_box_str!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ChatAccessTime(
                    chatAccessTime: match.chat_last_access_time_right,
                  ),
                ),
              ],
            ),
          ),
          Container(
            // Contents
            padding: EdgeInsets.symmetric(
              vertical: size_10_h,
            ),
            color: kColor2b2e3e,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          WinMark(
                            isDisplay: (match.win_lose_type_left == "1" ||
                                match.win_lose_type_left == "3" ||
                                match.win_lose_type_left == "5"),
                            align: Alignment.centerLeft,
                          ),
                          SizedBox(
                            width: size_30_w,
                          ),
                          GestureDetector(
                            onTap: () {
                              MypageBottomSheet(
                                gameTitleId: this.gameTitleId,
                                userId: match.user_id_left,
                                type: "player",
                              );
                            },
                            child: PlayerThumb(
                              playerThumbUrl: match.player_thumb_left,
                              placeholderImage:
                                  'asset/images/ic_default_avatar.png',
                              size: size_40_w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size_12_h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(size_10_w),
                        child: Text(
                          match.player_name_left!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kColoraaaaaa,
                            fontSize: text_11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      ScoreResult(
                        scoreLeft: match.score_left,
                        statusString: match.status_string,
                        scoreRight: match.score_right,
                      ),
                      SizedBox(
                        height: size_22_h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StatsWebview(tournamentRoundId: match.tournament_round_id,),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: kColor373C4A,
                            borderRadius: BorderRadius.circular(
                              size_10_r,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: size_4_h,
                            horizontal: size_30_w,
                          ),
                          child: Text(
                            txt_stats,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_10,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              MypageBottomSheet(
                                gameTitleId: this.gameTitleId,
                                userId: match.user_id_right,
                                type: "player",
                              );
                            },
                            child: PlayerThumb(
                              playerThumbUrl: match.player_thumb_right,
                              placeholderImage:
                                  'asset/images/ic_default_avatar.png',
                              size: size_40_w,
                            ),
                          ),
                          SizedBox(
                            width: size_30_w,
                          ),
                          WinMark(
                            isDisplay: (match.win_lose_type_right == "1" ||
                                match.win_lose_type_right == "3" ||
                                match.win_lose_type_right == "5"),
                            align: Alignment.centerRight,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size_12_h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          size_10_w,
                        ),
                        child: Text(
                          match.player_name_right!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kColoraaaaaa,
                            fontSize: text_11,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: size_1_h,
            color: Colors.black,
          ),
          Visibility(
            visible: (match.is_chat_btn_display! == true || match.is_score_post_btn_display! == true),
            child: Container(
              // Footer
              padding: EdgeInsets.symmetric(
                vertical: size_5_h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FooterButton(
                    title: txt_private_chat,
                    icon: 'asset/icons/icon_match_chat.svg',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatPrivatePage(
                            tournamentId: this.tournamentId,
                            tournamentRoundId: match.tournament_round_id!,
                            isDiplayTournamentButton: false,
                          ),
                        ),
                      );
                    },
                    isDisplay: match.is_chat_btn_display,
                    isAvailable: match.is_chat_btn_available,
                    isDisplayBadge: false,
                  ),
                  FooterButton(
                    title: txt_score_input,
                    icon: 'asset/icons/icon_score.svg',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScoreInputPage(
                            tournamentRoundId: match.tournament_round_id!,
                            title: match.round_box_str!,
                            tournamentId: this.tournamentId,
                          ),
                        ),
                      );
                    },
                    isDisplay: match.is_score_post_btn_display,
                    isAvailable: match.is_score_post_btn_available,
                    isDisplayBadge: (match.flg_input_score_badge_on == 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreResult extends StatelessWidget {
  final String? scoreLeft;
  final String? statusString;
  final String? scoreRight;

  const ScoreResult(
      {Key? key,
      required this.scoreLeft,
      required this.statusString,
      required this.scoreRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          scoreLeft!,
          style: TextStyle(
            color: Colors.white,
            fontSize: text_25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: size_14_w,
        ),
        Text(
          statusString!,
          style: TextStyle(
            color: Colors.white,
            fontSize: text_15,
          ),
        ),
        SizedBox(
          width: size_14_w,
        ),
        Text(
          scoreRight!,
          style: TextStyle(
            color: Colors.white,
            fontSize: text_25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class WinMark extends StatelessWidget {
  final Alignment align;
  final bool isDisplay;

  const WinMark({Key? key, required this.isDisplay, required this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isDisplay
        ? Container(
            height: size_50_h,
            width: size_4_w,
            alignment: this.align,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size_2_r),
              color: kColor8B8100,
            ),
          )
        : Container(
            height: size_50_h,
            width: size_4_w,
            alignment: this.align,
          );
  }
}

class ChatAccessTime extends StatelessWidget {
  final String? chatAccessTime;

  const ChatAccessTime({Key? key, required this.chatAccessTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.chatAccessTime != null
        ? Text(
            this.chatAccessTime!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: text_10,
            ),
          )
        : Text(
            txt_chat_not_accessed,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: text_10,
            ),
          );
  }
}

class FooterButton extends StatelessWidget {
  final String? title;
  final String? icon;
  final GestureTapCallback? onTap;
  final bool? isDisplay;
  final bool? isAvailable;
  final bool? isDisplayBadge;

  const FooterButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onTap,
      required this.isDisplay,
      required this.isAvailable,
      required this.isDisplayBadge,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: this.isDisplay!,
      child: Expanded(
        child: GrayedOut(
          grayedOut: !this.isAvailable!,
          child: Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap: this.isAvailable! ? this.onTap! : null,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size_15_w, vertical: size_10_h,),
                    child: Wrap(
                      children: [
                        SvgPicture.asset(
                          this.icon!,
                          height: size_12_w,
                          width: size_12_w,
                        ),
                        SizedBox(
                          width: size_4_w,
                        ),
                        Text(
                          this.title!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: text_11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isDisplayBadge == true,
                    child: Positioned(  // draw a red marble
                      top: 0.0,
                      right: 0.0,
                      child: Icon(
                        Icons.brightness_1,
                        size: 14.0,
                        color: kColorD0021C,
                      ),
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
