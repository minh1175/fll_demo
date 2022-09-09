// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';

void settingBottomSheet({String? message}) {
  BuildContext context =
      getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;
  showModalBottomSheet(
      backgroundColor: transparent,
      context: context,
      builder: (BuildContext builderContext) {
        return SettingBottomSheet(
          defaultAction: defaultAction,
        );
      });
}

class SettingBottomSheet extends StatelessWidget {
  VoidCallback? defaultAction;

  SettingBottomSheet({Key? key, this.defaultAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     color: transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size_10_w),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size_10_r),
                color: kCGrey165,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(heightFactor: 2.5, child: Text(txt_account_setting,
                      style:TextStyle(fontSize: text_16,color: kColorA6000000))),
                  Container(
                    height: size_1_h,
                    color: Colors.black,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                          heightFactor: 2.5,
                          child: Text(
                            txt_terms_of_service,
                            style: TextStyle(color: kColor247EF1,fontSize: text_16),
                          )),
                    ),
                  ),
                  Container(
                    height: size_1_h,
                    color: kCGrey102,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                          heightFactor: 2.5,
                          child: Text(txt_privacy_policy,
                              style: TextStyle(color: kColor247EF1,fontSize: text_16))),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                          heightFactor: 2.5,
                          child: Text(txt_twitter_information_update,
                              style: TextStyle(color: kColor247EF1,fontSize: text_16))),
                    ),
                  ),
                  Container(
                    height: size_1_h,
                    color: kCGrey102,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                          heightFactor: 2.5,
                          child: Text(txt_logout,
                              style: TextStyle(color: kColor247EF1,fontSize: text_16))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size_10_w,vertical: size_10_h),
            child: Container(
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(size_10_r)),
              width: double.maxFinite,
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Center(
                      heightFactor: 2.5,
                      child: Text(txt_cancel,
                          style: TextStyle(
                              color: kColor247EF1,
                              fontWeight: FontWeight.w600,fontSize: text_16)))),
            ),
          )
        ],
      ),
    );
  }
}
