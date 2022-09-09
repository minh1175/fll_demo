import 'package:Gametector/app/module/network/response/participants_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/edit_participants_bottom_sheet.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/component/common/player_thumb_with_prize.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/participant_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

class ParticipantTeamList extends StatelessWidget {
  const ParticipantTeamList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ParticipantListViewModel>(builder: (context, value, child) {
      final List<Team>? teamList = value.participantResponse?.team_list;
      return Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: teamList!.length,
              itemBuilder: (context, index) {
                var team = teamList[index];
                return ExpansionTile(
                  backgroundColor: kColor202330,
                  leading: Opacity(
                    opacity: team.entry_status == 3 ? 0.3 : 1,
                    child: Container(
                      child: PlayerThumb(
                        playerThumbUrl: team.team_thumb_url,
                        placeholderImage: 'asset/images/ic_default_avatar.png',
                        size: size_40_w,
                      ),
                    ),
                  ),
                  title: Opacity(
                    opacity: team.entry_status == 3 ? 0.3 : 1,
                    child: Text(
                      team.team_name,
                      style: TextStyle(color: Colors.white, fontSize: text_14,),
                    ),
                  ),
                  subtitle: Opacity(
                    opacity: team.entry_status == 3 ? 0.3 : 1,
                    child: Text(
                      sprintf(txt_team_member_number, [team.member_list!.length]),
                      style: TextStyle(color: Colors.white, fontSize: text_12,),
                    ),
                  ),
                  trailing: Wrap(
                    children: [
                      team.is_manageable == true
                          ? SizedBox(
                        width: size_20_w,
                        height: size_20_w,
                        child: GestureDetector(
                          onTap: () {
                            editParticipantsBottomSheet(
                              status: team.entry_status,
                              type: 'チーム',
                              excludeCallback: () {
                                int status = team.entry_status == 3 ? 2 : 3;
                                value.excludePlayerApi(
                                  team.team_player_id,
                                  status,
                                  1,
                                );
                              },
                              deleteCallback: () {
                                value.deletePlayerApi(team.team_player_id, 1);
                              },
                            );
                          },
                          child: SvgPicture.asset(
                            'asset/icons/ic_edit_mypage.svg',
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                          : SizedBox(width: size_20_w,),
                      SizedBox(width: size_20_w,),
                      SizedBox(
                        width: size_20_w,
                        height: size_20_w,
                        child: SvgPicture.asset(
                          value.customTileExpanded[index]
                              ? 'asset/icons/ic_arrow_up.svg'
                              : 'asset/icons/ic_arrow_down.svg',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onExpansionChanged: (bool expanded) {
                    value.changeCustomExtend(index, expanded);
                  },
                  children: <Widget>[
                    for ( var member in team.member_list! )
                      ListTile(
                        shape: BorderDirectional(
                          top: BorderSide(color: Colors.black),
                          bottom: BorderSide(color: Colors.black),
                        ),
                        tileColor: kColor202330,
                        leading: Opacity(
                          opacity: member.entry_status == 3 ? 0.3 : 1,
                          child: Container(
                            child: PlayerThumbWithPrize(
                              playerThumbUrl: member.player_thumb_url,
                              playerFrameUrl: member.player_thumb_frame_url,
                              playerBackgourndUrl: member.player_thumb_background_url,
                              size: size_60_w,
                              placeholderImage: 'asset/images/ic_default_avatar.png',
                            ),
                          ),
                        ),
                        title: Opacity(
                          opacity: member.entry_status == 3 ? 0.3 : 1,
                          child: Text(
                            member.player_name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Opacity(
                          opacity: member.entry_status == 3 ? 0.3 : 1,
                          child: Text(
                            sprintf(txt_rate_score, [
                              member.gt_rate_class,
                              (member.gt_score == null) ? "-" : member.gt_score.toString()
                            ]),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_9,
                            ),
                          ),
                        ),
                        trailing: Wrap(
                          children: [
                            (member.is_manageable == true)
                                ? GestureDetector(
                              onTap: () {
                                print('tapped : ' + member.player_id.toString());
                                editParticipantsBottomSheet(
                                  status: member.entry_status,
                                  type: 'メンバー',
                                  excludeCallback: () {
                                    int status = member.entry_status == 3 ? 2 : 3;
                                    value.excludePlayerApi(
                                        member.player_id, status, 2);
                                  },
                                  deleteCallback: () {
                                    value.deletePlayerApi(member.player_id, 2);
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
                      ),
                  ],
                );
              }
          ),
        ),
      );
    });
  }
}