import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String? message;
  NavigationService get _navigationService => getIt<NavigationService>();

  ErrorPage({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, //disable back press
      child: Container(
        color: kColor202330,
        child: SafeArea(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Scaffold(
              backgroundColor: kColor202330,
              body: Container(
                padding:
                EdgeInsets.symmetric(vertical: size_20_w, horizontal: size_20_w),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        this.message!,
                        textAlign: TextAlign.center,
                        style: kTSSVNGilroy.copyWith(
                          color: kWhite,
                          fontSize: text_16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(
                        height: size_10_h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size_40_w),
                        child: BouncingWidget(
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.0,
                          onPressed: () {
                            _navigationService.refreshApp();
                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: size_10_h),
                              child: Center(
                                child: Text(
                                  txt_refresh,
                                  style: kTSSVNGilroy.copyWith(
                                      color: kColor247EF1,
                                      fontSize: text_16,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
