import 'dart:ui';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TournamentHeadTabContent extends StatelessWidget {
  final int index;
  final String title;
  final int badgeCount;

  const TournamentHeadTabContent({
    Key? key,
    required this.index, required this.title, required this.badgeCount
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          this.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: text_9,
          ),
        ),
        Visibility(
          visible: (this.badgeCount > 0),
          child: Align(
            alignment: Alignment.topRight,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  margin: EdgeInsets.all(size_5_h),
                  child: Icon(
                    Icons.brightness_1,
                    size: size_12_h,
                    color: kColorD0021C,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}