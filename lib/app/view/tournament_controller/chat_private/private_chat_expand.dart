import 'dart:math' as math;

import 'package:Gametector/app/module/network/response/chat_private_list_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/chat_private_viewmodel.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PrivateChatExpandable extends StatefulWidget {
  final bool? isDefaultShow;
  final String? organizerThumbUrl;
  final GameInfo? gameInfo;
  const PrivateChatExpandable({
    Key? key,
    required this.isDefaultShow,
    required this.organizerThumbUrl,
    required this.gameInfo,
  }) : super(key: key);

  @override
  _PrivateChatExpandableState createState() => _PrivateChatExpandableState();
}

class _PrivateChatExpandableState extends State<PrivateChatExpandable> {
  late ChatPrivateViewModel chatPrivateViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      chatPrivateViewModel = Provider.of<ChatPrivateViewModel>(context, listen: false);
      chatPrivateViewModel.setInitialExpand(widget.isDefaultShow!);
      chatPrivateViewModel.expandableController.addListener(chatPrivateViewModel.onExpandableChanged);
    });
  }

  @override
  void dispose() {
    chatPrivateViewModel.expandableController.removeListener(chatPrivateViewModel.onExpandableChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatPrivateViewModel>(builder: (context, value, child) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kColor202330,
          border: Border(
            top: BorderSide(
              width: 0.3,
              color: Colors.white,
            ),
            bottom: BorderSide(
              width: 0.3,
              color: Colors.white,
            ),
          ),
        ),
        child: ExpandablePanel(
          controller: value.expandableController,
          theme: ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.top,
            tapBodyToExpand: true,
            tapBodyToCollapse: false,
            hasIcon: false,
          ),
          header: Container(
            height: size_30_h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.gameInfo!.open_close_title ?? '',
                  style: TextStyle(color: Colors.white, fontSize: text_10),
                ),
                ExpandableIcon(
                  theme: ExpandableThemeData(
                    expandIcon: Icons.arrow_drop_down,
                    collapseIcon: Icons.arrow_drop_up,
                    iconColor: Colors.white,
                    iconSize: size_20_w,
                    iconRotationAngle: math.pi,
                    iconPadding: EdgeInsets.only(right: size_4_w),
                    hasIcon: false,
                  ),
                ),
              ],
            ),
          ),
          collapsed: Container(),
          expanded: PrivateChatExpandableContent(
            organizerThumbUrl: widget.organizerThumbUrl,
            gameInfo: widget.gameInfo,
          ),
        ),
      );
    },);
  }
}

class PrivateChatExpandableContent extends StatelessWidget {
  final String? organizerThumbUrl;
  final GameInfo? gameInfo;

  const PrivateChatExpandableContent({
    Key? key,
    required this.organizerThumbUrl,
    required this.gameInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: size_10_w,
            right: size_10_w,
            bottom: size_10_h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: size_10_w,
            vertical: size_10_h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              size_5_r,
            ),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(kColor2b2e3c.withOpacity(0.3), BlendMode.dstATop),
              image: NetworkImage(this.gameInfo?.game_thumb_url?? "",),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 1,
                color: kColor592b2e3e,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: size_16_h,
                    horizontal: size_20_w,
                  ),
                  alignment: Alignment.center,
                  color: kColor591C1F28,
                  child: Column(
                    children: [
                      Text(
                        txt_message_chat_between_opponent,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: text_13,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size_12_h,
                      ),
                      Text(
                        gameInfo?.match_explanation ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: text_12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size_15_h,
              ),
              Text(
                txt_trouble_occurs,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size_5_h,
              ),
              Container(
                height: size_30_h,
                padding: EdgeInsets.only(
                  left: size_5_w,
                  right: size_15_w,
                ),
                decoration: BoxDecoration(
                  color: kColor373C4A,
                  borderRadius: BorderRadius.circular(size_20_r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PlayerThumb(
                      playerThumbUrl: this.organizerThumbUrl ?? null,
                      size: size_16_w,
                      placeholderImage: 'asset/images/ic_default_avatar.png',
                    ),
                    SizedBox(
                      width: size_5_w,
                    ),
                    Text(
                      txt_organizer_call,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_11,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size_5_h,
              ),
              Text(
                txt_please_press_to_comment,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // 1 : ID交換
        gameInfo?.game_match_type == 1
            ? Container(
                margin: EdgeInsets.only(
                  left: size_10_w,
                  right: size_10_w,
                  bottom: size_10_h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size_10_w,
                  vertical: size_10_h,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    size_5_r,
                  ),
                  color: kColor2b2e3e,
                ),
                child: Column(
                  children: [
                    Text(
                      gameInfo?.type_id_exchange_explanation ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_13,
                      ),
                    ),
                    SizedBox(
                      height: size_10_h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(size_4_r),
                              color: kColor373C4A,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: size_6_w,
                              vertical: size_8_h,
                            ),
                            child: Row(
                              children: [
                                PlayerThumb(
                                  playerThumbUrl: gameInfo?.type_id_exchange_player_thumb_left ?? null,
                                  size: size_16_w,
                                  placeholderImage: 'asset/images/ic_default_avatar.png',
                                ),
                                SizedBox(
                                  width: size_10_h,
                                ),
                                Text(
                                  gameInfo?.type_id_exchange_in_game_id_left ?? '',
                                  style: TextStyle(color: Colors.white, fontSize: text_11),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    final dataUrl = ClipboardData(
                                      text: gameInfo?.type_id_exchange_in_game_id_left ?? '',
                                    );
                                    await Clipboard.setData(dataUrl);
                                    showAlertGTDialog(
                                      message: txt_copy_completed,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    'asset/icons/ic_copy_chat_team.svg',
                                    height: size_20_h,
                                    width: size_20_w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size_4_w,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(size_4_r),
                              color: kColor373C4A,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: size_6_w,
                              vertical: size_8_h,
                            ),
                            child: Row(
                              children: [
                                PlayerThumb(
                                  playerThumbUrl: gameInfo?.type_id_exchange_player_thumb_right ?? null,
                                  size: size_16_w,
                                  placeholderImage: 'asset/images/ic_default_avatar.png',
                                ),
                                SizedBox(
                                  width: size_10_h,
                                ),
                                Text(
                                  gameInfo?.type_id_exchange_in_game_id_right ?? '',
                                  style: TextStyle(color: Colors.white, fontSize: text_11),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    final dataUrl = ClipboardData(
                                      text: gameInfo?.type_id_exchange_in_game_id_right ?? '',
                                    );
                                    await Clipboard.setData(dataUrl);
                                    showAlertGTDialog(
                                      message: txt_copy_completed,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    'asset/icons/ic_copy_chat_team.svg',
                                    height: size_20_h,
                                    width: size_20_w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
        // 2 : ホスト
        gameInfo?.game_match_type == 2
            ? Container(
                margin: EdgeInsets.only(
                  left: size_10_w,
                  right: size_10_w,
                  bottom: size_10_h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size_10_w,
                  vertical: size_10_h,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    size_5_r,
                  ),
                  color: kColor2b2e3e,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gameInfo?.type_host_explanation1 ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_12,
                            ),
                          ),
                          SizedBox(
                            height: size_5_h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size_6_w,
                              vertical: size_8_h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(size_4_r),
                              color: kColor373C4A,
                            ),
                            child: Row(
                              children: [
                                PlayerThumb(
                                  playerThumbUrl:
                                      gameInfo?.type_host_player_thumb_url,
                                  size: size_15_w,
                                  placeholderImage:
                                      'asset/images/ic_default_avatar.png',
                                ),
                                SizedBox(
                                  width: size_6_w,
                                ),
                                Flexible(
                                  child: Text(
                                    gameInfo?.type_host_player_name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: text_12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size_5_h,
                          ),
                          Text(
                            gameInfo?.type_host_explanation2 ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: size_5_w,
                        ),
                        child: FadeInImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(
                            gameInfo?.type_host_game_thumb_url ?? '',
                          ),
                          placeholder: AssetImage(
                            'asset/images/winning_eleven_cover.png',
                          ),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'asset/images/winning_eleven_cover.png',
                              fit: BoxFit.fitWidth,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        // 3 : 合言葉
        gameInfo?.game_match_type == 3
            ? Container(
                margin: EdgeInsets.only(
                  left: size_10_w,
                  right: size_10_w,
                  bottom: size_10_h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size_10_w,
                  vertical: size_10_h,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    size_5_r,
                  ),
                  color: kColor2b2e3e,
                ),
                child: Column(
                  children: [
                    Text(
                      gameInfo?.type_password_explanation ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_13,
                      ),
                    ),
                    SizedBox(
                      height: size_10_h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size_6_w,
                        vertical: size_8_h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size_4_r),
                        color: kColor373C4A,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              gameInfo?.type_password_text ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: text_12),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final dataUrl = ClipboardData(
                                text: gameInfo?.type_password_text ?? '',
                              );
                              await Clipboard.setData(dataUrl);
                              showAlertGTDialog(
                                message: txt_copy_completed,
                              );
                            },
                            child: SvgPicture.asset(
                              'asset/icons/ic_copy_chat_team.svg',
                              height: size_20_h,
                              width: size_20_w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
          // 99 : その他
      ],
    );
  }
}
