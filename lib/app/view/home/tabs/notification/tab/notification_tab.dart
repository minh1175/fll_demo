import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/colors.dart';

class NotificationPageTab extends StatelessWidget {
  String txtTab;
  int badgeCount;

  NotificationPageTab(
      {Key? key, required this.txtTab, required this.badgeCount, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: new Stack(children: [
        Container(
          alignment: Alignment.center,
          child: Text(txtTab, style: TextStyle(fontSize: text_12)),
        ),
        Container(
          // 赤のコンテナだけを右下に配置する
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: size_3_h),
          child: badgeCount == 0
              ? Container()
              : Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: size_20_h,
                      width: size_20_h,
                      decoration: BoxDecoration(
                        color: kColor880000,
                        borderRadius: BorderRadius.circular(size_10_r),
                      ),
                    ),
                    Text(
                      badgeCount.toString(),
                      style: TextStyle(fontSize: text_12),)
                    ,
                  ],
                ),
        )
      ]),
    );
  }
}
