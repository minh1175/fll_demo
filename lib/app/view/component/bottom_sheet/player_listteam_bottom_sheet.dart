import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/chat_private_list_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/component/common/player_thumb_with_prize.dart';
import 'package:Gametector/app/view/component/common/twitter_elipse.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

void playerListTeamBottomSheet({bool? isAuthorized, ChatTeam? chatTeam}) {
  BuildContext context =
      getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: transparent,
      context: context,
      builder: (BuildContext builderContext) {
        return FractionallySizedBox(
          heightFactor: 0.90,
          child: PlayerListTeamBottomSheet(
            isAuthorized: isAuthorized,
            chatTeam: chatTeam,
            defaultAction: defaultAction,
          ),
        );
      });
}

class PlayerListTeamBottomSheet extends StatelessWidget {
  bool? isAuthorized;
  ChatTeam? chatTeam;
  int? gameTitleId;
  VoidCallback? defaultAction;

  PlayerListTeamBottomSheet({
    Key? key,
    this.isAuthorized,
    this.chatTeam,
    this.gameTitleId,
    this.defaultAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size_10_r),
        color: kColor202330,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 1, bottom: 5),
              child: SizedBox(
                width: 80,
                child: Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
              )),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: _teamContent(chatTeam?.your_team,),
              ),
              Expanded(
                flex: 1,
                child: _teamContent(chatTeam?.opponent_team,),
              ),
            ],
          ),
          Container(
            height: size_2_w,
            color: Colors.black,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: chatTeam?.your_team?.team_member_num ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: size_2_w,
                        crossAxisSpacing: size_2_w,
                        crossAxisCount: 1,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (context, index) => _memberContent(chatTeam?.your_team?.member_list?[index],),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: chatTeam?.opponent_team?.team_member_num ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: size_2_w,
                        crossAxisSpacing: size_2_w,
                        crossAxisCount: 1,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (context, index) => _memberContent(chatTeam?.opponent_team?.member_list?[index],),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamContent(Team? team) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size_10_h,
        horizontal: size_10_w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PlayerThumb(
            playerThumbUrl: team?.team_thumb_url ?? null,
            size: size_32_w,
            placeholderImage: 'asset/images/ic_default_avatar.png',
          ),
          SizedBox(
            height: size_8_h,
          ),
          Text(
            team?.team_name ?? '',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: text_12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _memberContent(Member? member) {
    return Container(
      color: kColor202330,
      // color: Colors.white,
      height: size_400_h,
      padding: EdgeInsets.symmetric(
        vertical: size_10_h,
        horizontal: size_10_w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              TwitterElipse(
                width: size_26_w,
                height: size_16_h,
                callback: () {
                  var scheme = TWITTER_URL_APP.replaceAll("{id}", member?.twitter_id?? "");
                  var url = TWITTER_URL_WEB.replaceAll("{id}", member?.twitter_id?? "");
                  launchScheme(scheme, url);
                },
              ),
              Spacer(),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayerThumbWithPrize(
                  playerThumbUrl: member?.player_thumb_url,
                  playerFrameUrl: member?.player_thumb_frame_url,
                  playerBackgourndUrl: member?.player_thumb_background_url,
                  size: size_80_w,
                  placeholderImage: 'asset/images/ic_default_avatar.png',
                ),
                Text(
                  member?.player_name ?? '',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: text_12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: (member?.player_in_game_id != "" && member?.player_in_game_id != null && this.isAuthorized! == true),
            child: Container(
              decoration: BoxDecoration(
                color: kColor2A2E43,
                borderRadius: BorderRadius.circular(size_5_r),
              ),
              padding: EdgeInsets.symmetric(
                vertical: size_5_h,
                horizontal: size_5_w,
              ),
              width: double.maxFinite,
              child: Row(
                children: [
                  SizedBox(
                    width: size_16_w,
                  ),
                  Expanded(
                    child: Text(
                      member?.player_in_game_id ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_12,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final dataUrl = ClipboardData(
                        text: member?.player_in_game_id ?? '',
                      );
                      await Clipboard.setData(dataUrl);
                      showAlertGTDialog(
                        message: txt_copy_completed,
                      );
                    },
                    child: SvgPicture.asset(
                      'asset/icons/ic_copy_chat_team.svg',
                      height: size_16_h,
                      width: size_16_w,
                    ),
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
