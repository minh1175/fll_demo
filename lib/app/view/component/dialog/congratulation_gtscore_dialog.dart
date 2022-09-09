import 'dart:io';
import 'dart:typed_data';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/start_response.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/component/common/game_thumb.dart';
import 'package:Gametector/app/view/component/common/player_thumb_with_prize.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:screenshot/screenshot.dart';

import 'dismissible_widget.dart';

void showCongratulationGtscoreDialog({BattleReport? battleReport}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
  showDialog(
    context: context,
    builder: (BuildContext builderContext) {
      return CongratulationGtscoreDialog(
        battleReport: battleReport,
        defaultAction: () {
          Navigator.pop(context);
        },
      );
    }
  );
}

class CongratulationGtscoreDialog extends StatelessWidget {
  final BattleReport? battleReport;
  final VoidCallback? defaultAction;
  ScreenshotController screenshotController = ScreenshotController();

  CongratulationGtscoreDialog({
    Key? key,
    this.battleReport,
    this.defaultAction,
  }) : super(key: key);

  Future<void> shareFile() async {
    screenshotController.capture().then((Uint8List? image) async {
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(image!);
      Share.shareFiles([(file.path)], text: '#ゲームテクター #戦績速報');
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26.withOpacity(0.6),
      body: Column(
        children:[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DismissibleWidget(
                  onDismissed: () {
                    defaultAction?.call();
                  },
                  minScale: 0.2,
                  child: Screenshot(
                    controller: screenshotController,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: size_30_h, bottom: size_20_h, left: size_40_w, right: size_40_w),
                          padding: EdgeInsets.only(top: size_30_h, bottom: 0, left: 0, right: 0),
                          decoration: BoxDecoration(
                            color: Color(0xFF202430),
                            borderRadius: BorderRadius.circular(size_15_r,),
                          ),
                          child: Column(
                            children: [
                              Row(
                                  children: [
                                    SizedBox(width: size_25_w,),
                                    GameThumb(
                                      gameThumbUrl: this.battleReport!.game_title_thumb!,
                                      size: size_40_w,
                                      placeholderImage: 'asset/images/gray04.png',
                                    ),
                                    SizedBox(width: size_14_w,),
                                    Text(
                                      this.battleReport!.game_title?? '',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]
                              ),
                              SizedBox(height: size_5_h,),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(size_10_w,),
                                    child: Image.asset(
                                      'asset/images/congratulation_bkg_rate.png',
                                    ),
                                  ),
                                  Positioned(
                                    top: size_50_h,
                                    left: size_45_w,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: size_75_w,
                                      child: Text(
                                        this.battleReport!.before_rate?.toString()?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: size_50_h,
                                    right: size_45_w,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: size_75_w,
                                      child: Text(
                                        this.battleReport!.after_rate?.toString()?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: size_50_h,
                                    right: size_20_w,
                                    child: (() {
                                      if (this.battleReport!.after_rate! > this.battleReport!.before_rate!) {
                                        return Text(
                                          '▲',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (this.battleReport!.after_rate! < this.battleReport!.before_rate!) {
                                        return Text(
                                          '▼',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          '▶︎',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    })(),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: this.battleReport!.up_basic_prize_name != "",
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: size_20_w, right:size_20_w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: PlayerThumbWithPrize(
                                              playerThumbUrl: this.battleReport!.before_player_thumb_url,
                                              playerFrameUrl: this.battleReport!.before_player_thumb_frame_url,
                                              playerBackgourndUrl: this.battleReport!.before_player_thumb_background_url,
                                              size: size_65_w,
                                              placeholderImage: 'asset/images/ic_default_avatar.png',
                                            ),
                                          ),
                                          Text(
                                            '→',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: PlayerThumbWithPrize(
                                              playerThumbUrl: this.battleReport!.after_player_thumb_url,
                                              playerFrameUrl: this.battleReport!.after_player_thumb_frame_url,
                                              playerBackgourndUrl: this.battleReport!.after_player_thumb_background_url,
                                              size: size_65_w,
                                              placeholderImage: 'asset/images/ic_default_avatar.png',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size_5_h,),
                                    Padding(
                                      padding: EdgeInsets.only(left: size_20_w, right:size_20_w,),
                                      child: Row(
                                        children: [
                                          Text(
                                            '🎉',
                                            style: TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                          Expanded(
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                    TextSpan(text: '称号が'),
                                                    TextSpan(
                                                      text: '  '+this.battleReport!.up_basic_prize_name!+'  ',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(text: 'へ '),
                                                    TextSpan(text: 'UP', style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    )),
                                                    TextSpan(text: ' しました\nおめでとうございます'),
                                                  ],
                                                )
                                            ),
                                          ),
                                          Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.rotationY(3.1415),
                                            child: Text(
                                              '🎉',
                                              style: TextStyle(
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size_30_h),
                                  ],
                                ),
                              ),
                              Container(
                                transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(size_10_w,),
                                      child: Image.asset(
                                        'asset/images/congratulation_bkg_score.png',
                                      ),
                                    ),
                                    Positioned(
                                      bottom: size_30_h,
                                      left: size_45_w,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: size_75_w,
                                        child: Text(
                                          this.battleReport!.before_score?.toString()?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: size_30_h,
                                      right: size_45_w,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: size_75_w,
                                        child: Text(
                                          this.battleReport!.after_score?.toString()?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            '戦績速報',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: size_16_h,),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(size_50_r,),
                          ),
                          width: size_100_w,
                          height: size_30_h,
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    shareFile();
                  },
                  child: Icon(Icons.ios_share),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: const CircleBorder(),
                  ),
                ),
                Text(
                  'この画像をスクショしてシェアしよう',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: size_30_h),
            child: GestureDetector(
              onTap: () => defaultAction?.call(),
              child: Text(
                '閉じる',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}