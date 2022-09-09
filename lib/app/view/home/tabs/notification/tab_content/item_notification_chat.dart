import 'package:Gametector/app/module/network/response/all_notification_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/chat_private_page.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_page.dart';
import 'package:flutter/material.dart';

class ItemNotificationChat extends StatelessWidget {
  Tournament? data;
  List<Label>? lsLabel = [];
  final Function readApi;

  ItemNotificationChat({
    Key? key,
    required this.data,
    this.lsLabel,
    required this.readApi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size_2_h),
      child: GestureDetector(
        onTap: () {
          readApi();

          if (this.data!.tournament_round_id != 0) {
            // go to private chat
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatPrivatePage(
                  tournamentId: this.data!.tournament_id!,
                  tournamentRoundId: this.data!.tournament_round_id!,
                  isDiplayTournamentButton: true,
                ),
              ),
            );
          } else {
            // go to tournament_chat
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TournamentControllerPage(
                  tournamentId: this.data!.tournament_id!,
                ),
              ),
            );
          }
        },
        child: Card(
          margin: EdgeInsets.zero,
          color: data?.flg_unread == 1 ? kColorFF313A50 : kColor2b2e3c,
          child: ListTile(
            leading: PlayerThumb(
              playerThumbUrl: data?.thumb_url,
              size: size_40_w,
              placeholderImage: 'asset/images/ic_default_avatar.png',
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 0, top: size_10_h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      data?.tournament_name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: kColorD3DDE9, fontSize: text_12),
                    ),
                  ),
                  Text(
                    data?.date ?? 'yyyy/mm/dd',
                    style: TextStyle(color: kColor9696a1, fontSize: text_10),
                  ),
                ],
              ),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size_4_h,
                ),
                Row(
                  children: [
                    (data?.label_list?.length == 0 && data?.match_text == '')
                        ? SizedBox()
                        : Visibility(
                            // Label List
                            visible: (data?.label_list == null) ? false : true,
                            child: Row(
                              children: [
                                Visibility(
                                  visible: (data?.label_list == null &&
                                          data?.match_text == null)
                                      ? false
                                      : true,
                                  child: Text(
                                    data?.match_text ?? '',
                                    style: TextStyle(
                                      color: (data?.match_text!.length == 0 &&
                                              data?.label_list == 0)
                                          ? Colors.white
                                          : kColor9696a1,
                                      fontSize: text_11,
                                    ),
                                  ),
                                ),
                                Wrap(
                                  children: lsLabel!
                                      .map((e) => _buildLabel(e))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                    Spacer(),
                    Visibility(
                      visible: data?.flg_badge_on == 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size_10_w,
                          vertical: size_2_h,
                        ),
                        decoration: BoxDecoration(
                          color: kColorD0021C,
                          borderRadius: BorderRadius.circular(size_10_r),
                        ),
                        child: Text(
                          data?.badge_text ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: text_10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size_10_h),
                  child: Text(
                    data?.message ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_12,
                    ),
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(Label itemLabel) {
    return Wrap(
      children: [
        SizedBox(
          width: size_4_w,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size_6_w,
            vertical: size_2_h,
          ),
          color: (itemLabel.color_type == 1) ? kColor2947C3 : kColor39393A,
          child: Text(
            itemLabel.text ?? '',
            style: TextStyle(
              color: itemLabel.color_type == 3 ? kColorB7B7B7 : Colors.white,
              fontSize: text_10,
            ),
          ),
        ),
      ],
    );
  }
}
