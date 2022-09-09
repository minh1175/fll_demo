import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/custom/ic_halfcircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatsGtscore extends StatelessWidget {
  final String score;
  final String rank;
  final String upDown;
  final String percent;
  final bool isClick;

  const StatsGtscore({
    Key? key,
    required this.score,
    required this.rank,
    required this.upDown,
    required this.percent,
    required this.isClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size_10_r,),
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
                txt_title_gt_score,
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
                this.score,
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
                    this.rank,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: size_5_w,),
                  Text(
                    txt_score_rank,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: size_14_h,
                left: size_14_w,
                right: size_14_w,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(size_10_r,),
                  color: Colors.black,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size_30_w,
                      width: size_30_w,
                      child: this.upDown == 'up' ? SvgPicture.asset(
                        'asset/icons/ic_arrow_up.svg',
                        color: Colors.blue,
                      ) : SvgPicture.asset(
                        'asset/icons/ic_arrow_down.svg',
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      this.percent,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: size_2_w,),
                    Text(
                      '%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_10,
                      ),
                    ),
                  ],
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
