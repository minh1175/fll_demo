import 'package:Gametector/app/module/network/response/participants_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/edit_participants_bottom_sheet.dart';
import 'package:Gametector/app/view/component/common/player_thumb_with_prize.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/participant_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

class ParticipantPlayerList extends StatelessWidget {
  const ParticipantPlayerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ParticipantListViewModel>(builder: (context, value, child) {
      final List<Player>? playerList = value.participantResponse?.player_list;
      return Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: playerList!.length,
            itemBuilder: (ctx, index) {
              var player = playerList[index];
              return ListTile(
                shape: BorderDirectional(
                  top: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
                tileColor: kColor202330,
                leading: Opacity(
                  opacity: player.entry_status == 3 ? 0.3 : 1,
                  child: Container(
                    child: PlayerThumbWithPrize(
                      playerThumbUrl: player.player_thumb_url,
                      playerFrameUrl: player.player_thumb_frame_url,
                      playerBackgourndUrl: player.player_thumb_background_url,
                      size: size_60_w,
                      placeholderImage: 'asset/images/ic_default_avatar.png',
                    ),
                  ),
                ),
                title: Opacity(
                  opacity: player.entry_status == 3 ? 0.3 : 1,
                  child: Text(
                    player.player_name,
                    style: TextStyle(color: Colors.white, fontSize: text_14, fontWeight: FontWeight.bold,),
                  ),
                ),
                subtitle: Opacity(
                  opacity: player.entry_status == 3 ? 0.3 : 1,
                  child: Text(
                    sprintf(txt_rate_score, [player.gt_rate_class, (player.gt_score == null) ? "-" : player.gt_score.toString()]),
                    style: TextStyle(color: Colors.white, fontSize: text_9,),
                  ),
                ),
                trailing: Wrap(
                  children: [
                    (player.is_manageable == true)
                        ? GestureDetector(
                            onTap: () {
                              print ('tapped : '+ player.player_id.toString());
                              editParticipantsBottomSheet(
                                status: player.entry_status,
                                type: '参加者',
                                excludeCallback: () {
                                  int status = player.entry_status == 3 ? 2 : 3;
                                  value.excludePlayerApi(player.player_id, status, 1);
                                },
                                deleteCallback: () {
                                  value.deletePlayerApi(player.player_id, 1);
                                },
                              );
                            },
                            child: SizedBox(
                              width: size_20_w,
                              height: size_20_w,
                              child: SvgPicture.asset(
                                'asset/icons/ic_delete.svg',
                                color: Colors.blueAccent,
                              ),
                            ),
                          )
                        : SizedBox(width: size_20_w,),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}