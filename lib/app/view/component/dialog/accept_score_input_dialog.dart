import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';

import '../../../module/common/res/colors.dart';

void acceptScoreInputDialog() {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
  showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        return AcceptScoreInput();
      });
}

class AcceptScoreInput extends StatelessWidget {
  const AcceptScoreInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColor202330,
      child: SafeArea(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: Scaffold(
            backgroundColor: Colors.black26.withOpacity(0.5),
            body:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF202430),
                    borderRadius: BorderRadius.circular(size_10_r),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: size_30_w,),
                  padding: EdgeInsets.symmetric(vertical: size_30_h, horizontal: size_30_w,),
                  child: Column(
                    children: [
                      Image.asset("asset/images/dialog_before_score_approval.png"),
                      SizedBox(height: size_50_h,),
                      Text(
                        txt_check,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: text_14,
                        ),
                      ),
                      SizedBox(height: size_5_h,),
                      Text(
                        txt_accept_score_input,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: text_18,
                        ),
                      ),
                      SizedBox(height: size_30_h,),
                      Text(
                        txt_describe_score_input,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: text_13,
                        ),
                      ),
                      SizedBox(height: size_30_h,),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(size_10_r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: size_15_h,),
                          width: double.infinity,
                          child: Text(
                            "OK",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: text_14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
