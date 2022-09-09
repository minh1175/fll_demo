import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:flutter/material.dart';

class IcHalfCircle extends StatelessWidget {
  const IcHalfCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size_4_w,
      height: size_20_h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(size_30_r),bottomLeft: Radius.circular(size_30_r),),
        color: kColor426cff,
      ),
    );
  }
}


