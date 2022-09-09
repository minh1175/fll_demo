import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

void showAlertGTDialog({String? message, VoidCallback? callback}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
  showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        return AlertGTDialog(
          message: message,
          defaultAction: () {
            callback!=null ? callback() : Navigator.pop(context);
          },
        );
      });
}

class AlertGTDialog extends StatelessWidget {
  final String? message;
  final String? actionString;
  VoidCallback? defaultAction;

  AlertGTDialog(
      {Key? key,
      this.message = txt_msg_error_login_twitter,
      this.actionString = txt_ok,
      this.defaultAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size_10_r),
      ),
      elevation: 0,
      insetPadding: EdgeInsets.all(30.0),
      backgroundColor: Colors.white,
      child: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size_10_r),
            ),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size_20_h,
                      horizontal: size_20_w,
                    ),
                    child: Text(
                      message ?? '',
                      textAlign: TextAlign.center,
                      style: kTSSVNGilroy.copyWith(
                        color: Colors.black,
                        fontSize: text_16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: kColorD3DDE9,
                  height: 1,
                ),
                BouncingWidget(
                  duration: Duration(milliseconds: 100),
                  scaleFactor: 1.0,
                  onPressed: () {
                    defaultAction?.call();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(size_10_r),
                          bottomRight: Radius.circular(size_10_r)),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: size_14_h),
                      child: Center(
                        child: Text(
                          actionString!,
                          style: kTSSVNGilroy.copyWith(
                              color: kColor247EF1,
                              fontSize: text_18,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
