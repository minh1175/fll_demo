import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/custom/ic_halfcircle.dart';
import 'package:flutter/material.dart';

class StatsOrganizerPrize extends StatelessWidget {
  final String prizeEn;
  final String prizeJa;
  final int percent;
  final bool isClick;

  const StatsOrganizerPrize({
    Key? key,
    required this.prizeEn,
    required this.prizeJa,
    required this.percent,
    required this.isClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size_10_r),
        color: kColor252A37,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: size_14_h,
                left: size_14_w,
              ),
              child: Text(
                txt_gt_title,
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
                top: size_14_h,
                right: size_14_w,
              ),
              child: Text(
                this.prizeEn,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: text_20,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: size_14_w, bottom: size_14_h),
              child: Text(
                this.prizeJa,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_10,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: size_14_h,
                left: size_14_w,
                right: size_14_w,
              ),
              child: Container(
                padding: EdgeInsets.only(top: size_10_h,),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size_12_r,),
                  child: LinearProgressIndicator(
                    minHeight: size_8_h,
                    backgroundColor: Colors.black,
                    value: this.percent / 100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue,),
                  ),
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
