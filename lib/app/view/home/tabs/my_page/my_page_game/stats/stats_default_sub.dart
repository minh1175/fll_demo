import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/custom/ic_halfcircle.dart';
import 'package:flutter/material.dart';

class StatsDefaultSub extends StatelessWidget {
  final String title;
  final String value;
  final String subTitle;
  final String subValue;
  final bool isClick;

  const StatsDefaultSub({
    Key? key,
    required this.title,
    required this.value,
    required this.isClick,
    required this.subTitle,
    required this.subValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kColor252A37,
        borderRadius: BorderRadius.circular(size_10_r,),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size_14_h,
                top: size_14_w,
              ),
              child: Text(
                this.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_14,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: size_14_h,
                top: size_14_w,
              ),
              child: Text(
                this.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size_14_h,
                bottom: size_14_w,
              ),
              child: Text(
                this.subTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_12,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: size_14_h,
                bottom: size_14_w,
              ),
              child: Text(
                this.subValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              child: this.isClick == true ? IcHalfCircle() : Container(),
            ),
          ),
        ],
      ),
    );
  }
}