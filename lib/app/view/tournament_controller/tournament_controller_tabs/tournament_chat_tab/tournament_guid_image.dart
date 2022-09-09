import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';

class GuidImage extends StatelessWidget {
  const GuidImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size_10_h, horizontal: size_20_w),
      padding: EdgeInsets.only(left: size_10_w, right: size_10_w, bottom: size_10_h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size_5_r,),
        color: kColor2b2e3c,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: size_10_w,),
            color: Colors.grey,
            child: Text(
              txt_let_check_the_flow_of_the_tournament,
              style: TextStyle(color: Colors.white,fontSize: text_11,),
            ),
          ),
          Image.asset(
            'asset/images/text_chat_flow.png',
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
