import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:flutter/material.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;

  const BottomSheetContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size_10_r),
        color: kColor202330,
      ),
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 1, bottom: 5),
            child: SizedBox(
              width: 80,
              child: Divider(
                thickness: 3,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: this.child,
          ),
        ],
      ),
    );
  }
}
