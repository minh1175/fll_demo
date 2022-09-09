import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:flutter/material.dart';

class BuildProgressLoading extends StatelessWidget {
  const BuildProgressLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: size_26_w,
              height: size_26_w,
              child: CircularProgressIndicator(
                strokeWidth: 2.8,
                valueColor: AlwaysStoppedAnimation<Color>(kColor247EF1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
