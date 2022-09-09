import 'dart:io';
import 'dart:typed_data';

import 'package:Gametector/app/module/network/response/chat_list_response.dart';
import 'package:Gametector/app/module/network/response/tournament_info_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class TournamentChatResultEvent extends StatelessWidget {
  final Item item;
  final TournamentInfo tournamentInfo;
  final List<double> rankThumbSize = [size_45_w, size_75_w, size_60_w, size_50_w];
  ScreenshotController screenshotController = ScreenshotController();

  TournamentChatResultEvent({
    Key? key,
    required this.item,
    required this.tournamentInfo,
  }) : super(key: key);

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
              child: Container(
                padding: EdgeInsets.symmetric(vertical: size_10_h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kColor2b2e3c,
                  borderRadius: BorderRadius.circular(size_10_r,),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(kColor2b2e3c.withOpacity(0.3), BlendMode.dstATop),
                    image: NetworkImage(tournamentInfo.game_cover_thumb_url!,),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size_10_h,),
                    Text(
                      '${tournamentInfo.tournament_name!}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      tournamentInfo.game_title_name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: text_14,
                      ),
                    ),
                    Container(
                      child: Wrap(
                        children: [
                          for (var k = 0; k <= this.item.ranking_info!.ranking!.length-1; k++) ... {
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: size_5_w),
                              width: this.rankThumbSize[0]+size_12_w,
                              child: Column(
                                children: [
                                  Container(
                                    height: size_120_h,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Positioned(
                                          bottom: size_15_h,
                                          child: PlayerThumb(
                                            playerThumbUrl: this.item.ranking_info!.ranking![k].thumb_url,
                                            placeholderImage: 'asset/images/ic_default_avatar.png',
                                            size: this.rankThumbSize[0],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size_10_h,),
                                  Text(
                                    this.item.ranking_info!.ranking![k].player_name!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: text_10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          },
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: size_10_h,),
                      child: Image.asset(
                        'asset/icons/icon_thanks.png',
                        width: size_140_w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}