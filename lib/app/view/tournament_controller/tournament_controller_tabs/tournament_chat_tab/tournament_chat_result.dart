import 'dart:io';
import 'dart:typed_data';

import 'package:Gametector/app/module/network/response/chat_list_response.dart';
import 'package:Gametector/app/module/network/response/tournament_info_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_result_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class TournamentChatResult extends StatefulWidget {
  final Item item;
  final TournamentInfo tournamentInfo;
  TournamentChatResult({
    Key? key,
    required this.item,
    required this.tournamentInfo,
  }) : super(key: key);

  @override
  _TournamentChatResultState createState() => _TournamentChatResultState();
}

class _TournamentChatResultState extends State<TournamentChatResult> {
  final List<String> medalImage = ['','asset/icons/icon_medal1.svg', 'asset/icons/icon_medal2.svg', 'asset/icons/icon_medal3.svg'];
  final List<double> rankThumbSize = [size_45_w, size_75_w, size_60_w, size_50_w];
  late List<ItemRank> rankItem;
  List<String> rankEmoji = ['','🥇', '🥈', '🥉'];
  ScreenshotController screenshotController = ScreenshotController();

  void initState() {
    if (widget.item.ranking_info!.ranking!.length <= 2) {
      rankItem = widget.item.ranking_info!.ranking!;
    } else {
      List<int> order = [1,0,2,3];
      List<ItemRank> tempRank = [];
      for (var k = 0; k <= widget.item.ranking_info!.ranking!.length-1; k++) {
        tempRank.add(widget.item.ranking_info!.ranking![order[k]]);
      }
      rankItem = tempRank;
    }
    super.initState();
  }

  Future<void> shareFile() async {
    screenshotController.capture().then((Uint8List? image) async {
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(image!);
      HapticFeedback.heavyImpact();
      Share.shareFiles([(file.path)], text: '');
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size_10_h,),
      child: Column(
        children: [
          GestureDetector(
            onLongPress: () {
              shareFile();
            },
            child: Screenshot(
              controller: screenshotController,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: size_10_h),
                    width: double.infinity,
                    height: size_300_h,
                    decoration: BoxDecoration(
                      color: kColor2b2e3c,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(kColor2b2e3c.withOpacity(0.3), BlendMode.dstATop),
                        image: NetworkImage(widget.tournamentInfo.game_cover_thumb_url!,),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size_10_h,),
                        Text(
                          widget.tournamentInfo.tournament_name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: text_16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size_4_h,),
                        Text(
                          widget.tournamentInfo.game_title_name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: text_14,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(bottom: size_20_h, left: size_5_w, right: size_5_w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var k = 0; k <= this.rankItem.length-1; k++) ... {
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: size_5_w),
                                    width: this.rankThumbSize[this.rankItem[k].rank!]+size_12_w,
                                    child: Column(
                                      children: [
                                        Expanded(child: Container(),),
                                        Container(
                                          height: size_120_h,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Positioned(
                                                bottom: size_15_h,
                                                child: PlayerThumb(
                                                  playerThumbUrl: this.rankItem[k].thumb_url,
                                                  placeholderImage: 'asset/images/ic_default_avatar.png',
                                                  size: this.rankThumbSize[this.rankItem[k].rank!],
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                child: SvgPicture.asset(
                                                  this.medalImage[this.rankItem[k].rank!],
                                                  width: size_20_w,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size_10_h,),
                                      ],
                                    ),
                                  ),
                                },
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: size_20_h,),
                          child: SvgPicture.asset(
                            'asset/icons/icon_winner.svg',
                            width: size_140_w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: size_16_h,bottom: size_16_h,left: size_16_w,right: size_16_w),
                    color: kColor2b2e3c,
                    child: Column(
                      children: [
                        for (var k = 0; k <= widget.item.ranking_info!.ranking!.length-1; k++) ... {
                          SizedBox(height: size_4_h,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                this.rankEmoji[widget.item.ranking_info!.ranking![k].rank!] + ' ' + widget.item.ranking_info!.ranking![k].player_name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: text_14,
                                ),
                              )
                          ),
                          SizedBox(height: size_4_h,),
                        }
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size_2_h,),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TournamentResultWebview(
                    tournamentName: widget.tournamentInfo.tournament_name,
                    rankingUrl: widget.item.ranking_info!.ranking_url,
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: size_16_h, horizontal: size_10_w),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(size_10_r,),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: kColor2b2e3c,
              ),
              child: Text(
                txt_confirm_result,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}