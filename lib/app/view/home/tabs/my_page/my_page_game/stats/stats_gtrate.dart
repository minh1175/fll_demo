import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/custom/ic_halfcircle.dart';
import 'package:flutter/material.dart';

class StatsGtrate extends StatelessWidget {
  final String rate;
  final String prize;
  final String maxRate;
  final int percent;
  final bool isClick;

  const StatsGtrate({
    Key? key,
    required this.rate,
    required this.prize,
    required this.maxRate,
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
                top: size_14_w,
                left: size_14_h,
              ),
              child: Text(
                txt_title_gt_rate,
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
                top: size_14_w,
                right: size_14_h,
              ),
              child: Text(
                this.rate,
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
              padding: EdgeInsets.only(right: size_14_h,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    txt_rate_value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_10,
                    ),
                  ),
                  SizedBox(width: size_5_w,),
                  Text(
                    this.prize,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        txt_highest_rate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: text_10,
                        ),
                      ),
                      Spacer(),
                      Text(this.maxRate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: text_16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Center(
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
                ],
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
