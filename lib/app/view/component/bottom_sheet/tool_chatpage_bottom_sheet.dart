// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';

import 'package:flutter/material.dart';

void toolChatpageBottomSheet({String? message}) {
  BuildContext context =
      getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: transparent,
      context: context,
      builder: (BuildContext builderContext) {
        return FractionallySizedBox(
          heightFactor: 0.98,
          child: ToolChatpageBottomSheet(
            defaultAction: defaultAction,
          ),
        );
      });
}

class ToolChatpageBottomSheet extends StatelessWidget {
  VoidCallback? defaultAction;

  ToolChatpageBottomSheet({Key? key, this.defaultAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: size_5_h),
          alignment: Alignment.center,
          height: size_14_h,
          decoration: BoxDecoration(
              color: transparent,
              borderRadius: BorderRadius.circular(size_10_r)),
          child: Container(
            width: size_150_w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size_10_r)),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size_20_r),
              color: kColor202330,
            ),
            width: double.maxFinite,
          ),
        ),
      ],
    );
  }
}
