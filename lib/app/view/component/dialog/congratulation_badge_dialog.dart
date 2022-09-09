import 'dart:io';
import 'dart:typed_data';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/component/dialog/dismissible_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:screenshot/screenshot.dart';


void showCongratulationBadgeDialog({
  String? userThumbUrl,
  String? gameTitle,
  String? badgeThumbUrl,
  String? badgeTitle,
  String? acquisitionDate,
  String? category,
  String? gameCoverUrl,
}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
  showDialog(
    context: context,
    builder: (BuildContext builderContext) {
      return CongratulationBadgeDialog(
        userThumbUrl: userThumbUrl,
        gameTitle: gameTitle,
        badgeThumbUrl: badgeThumbUrl,
        badgeTitle: badgeTitle,
        acquisitionDate: acquisitionDate,
        category: category,
        gameCoverUrl: gameCoverUrl,
        defaultAction: () {
          Navigator.pop(context);
        },
      );
    },
  );
}

class CongratulationBadgeDialog extends StatelessWidget {
  final String? userThumbUrl;
  final String? gameTitle;
  final String? badgeThumbUrl;
  final String? badgeTitle;
  final String? acquisitionDate;
  final String? category;
  final String? gameCoverUrl;
  final VoidCallback? defaultAction;
  ScreenshotController screenshotController = ScreenshotController();

  CongratulationBadgeDialog({
    Key? key,
    this.userThumbUrl,
    this.gameTitle,
    this.badgeThumbUrl,
    this.badgeTitle,
    this.acquisitionDate,
    this.defaultAction,
    this.category,
    this.gameCoverUrl,
  }) : super(key: key);

  Future<void> shareFile() async {
    screenshotController.capture().then((Uint8List? image) async {
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(image!);
      Share.shareFiles([(file.path)], text: '#ゲームテクター #バッチ');
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26.withOpacity(0.8),
      body: Column(
        children: [
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
                      child: Container(
                        margin:
                        EdgeInsets.only(top: 30, bottom: 20, left: 40, right: 40),
                        padding:
                        EdgeInsets.only(top: 25, bottom: 25, left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFF202430),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                            image: NetworkImage(
                              gameCoverUrl ?? '',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'バッジ獲得',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 20),
                            FadeInImage(
                              fit: BoxFit.fitWidth,
                              height: size_200_h,
                              width: size_200_h,
                              image: NetworkImage(
                                badgeThumbUrl ?? '',
                              ),
                              placeholder: AssetImage(
                                'asset/images/ic_default_avatar.png',
                              ),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'asset/images/ic_default_avatar.png',
                                  fit: BoxFit.fill,
                                  height: size_240_h,
                                  width: size_240_h,
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              '$category',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '$gameTitleで$badgeTitleを達成しました',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
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
            margin: EdgeInsets.only(bottom: 25),
            child: GestureDetector(
              onTap: () => defaultAction?.call(),
              child: Container(
                padding: EdgeInsets.all(size_10_w,),
                child: Text(
                  '閉じる',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
