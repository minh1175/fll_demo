import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatsTitle extends StatelessWidget {
  final String iconPath;
  final String title;
  const StatsTitle({
    Key? key,
    required this.iconPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: size_20_h, bottom: size_10_h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size_16_h,
            width: size_16_h,
            child: SvgPicture.asset(
              this.iconPath,
              color: Colors.white,
            ),
          ),
          SizedBox(width: size_4_w,),
          Text(
            this.title,
            style: TextStyle(color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
