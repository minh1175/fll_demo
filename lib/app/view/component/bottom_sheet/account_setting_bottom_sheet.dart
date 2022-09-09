import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';

void accountSettingBottomSheet({
  VoidCallback? openTerm,
  VoidCallback? openPolicy,
  VoidCallback? updateTwitterInfo,
  VoidCallback? logoutAccount,
  VoidCallback? deleteAccount,
}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;

  showModalBottomSheet(
    backgroundColor: transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext builderContext) {
      return AccountSettingBottomSheet(
        openTerm: openTerm,
        openPolicy: openPolicy,
        updateTwitterInfo: updateTwitterInfo,
        logoutAccount: logoutAccount,
        deleteAccount: deleteAccount,
      );
    },
  );
}

class AccountSettingBottomSheet extends StatelessWidget {
  VoidCallback? openTerm;
  VoidCallback? openPolicy;
  VoidCallback? updateTwitterInfo;
  VoidCallback? logoutAccount;
  VoidCallback? deleteAccount;

  AccountSettingBottomSheet({
    Key? key,
    this.openTerm,
    this.openPolicy,
    this.updateTwitterInfo,
    this.logoutAccount,
    this.deleteAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size_10_w, vertical: size_10_h,),
      // color: transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size_10_r),
              color: kCGrey165,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  heightFactor: 2.9,
                  child: Text(
                    txt_account_setting,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: text_14,
                      color: Colors.black,
                    ),
                  ),
                ),
                _divider,
                Material(
                  color: kCGrey165,
                  child: InkWell(
                    highlightColor: kColor9696a1,
                    splashColor: kColor9696a1,
                    onTap: () {
                      Navigator.pop(context);
                      openTerm?.call();
                    },
                    child: Ink(
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          heightFactor: 2.5,
                          child: Text(
                            txt_terms_of_service,
                            style: TextStyle(color: kColor247EF1, fontSize: text_16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _divider,
                Material(
                  color: kCGrey165,
                  child: InkWell(
                    highlightColor: kColor9696a1,
                    splashColor: kColor9696a1,
                    onTap: () {
                      Navigator.pop(context);
                      openPolicy?.call();
                    },
                    child: Ink(
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          heightFactor: 2.5,
                          child: Text(
                            txt_privacy_policy,
                            style: TextStyle(color: kColor247EF1, fontSize: text_16,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _divider,
                Material(
                  color: kCGrey165,
                  child: InkWell(
                    highlightColor: kColor9696a1,
                    splashColor: kColor9696a1,
                    onTap: () {
                      Navigator.pop(context);
                      updateTwitterInfo?.call();
                    },
                    child: Ink(
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          heightFactor: 2.5,
                          child: Text(
                            txt_twitter_information_update,
                            style: TextStyle(color: kColor247EF1, fontSize: text_16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _divider,
                Material(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(size_10_r),
                    bottomRight: Radius.circular(size_10_r),
                  ),
                  color: kCGrey165,
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(size_10_r),
                      bottomRight: Radius.circular(size_10_r),
                    ),
                    highlightColor: kColor9696a1,
                    splashColor: kColor9696a1,
                    onTap: () {
                      Navigator.pop(context);
                      logoutAccount?.call();
                    },
                    child: Ink(
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          heightFactor: 2.5,
                          child: Text(
                            txt_logout,
                            style: TextStyle(color: kColor247EF1, fontSize: text_16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _divider,
                Material(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(size_10_r),
                    bottomRight: Radius.circular(size_10_r),
                  ),
                  color: kCGrey165,
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(size_10_r),
                      bottomRight: Radius.circular(size_10_r),
                    ),
                    highlightColor: kColor9696a1,
                    splashColor: kColor9696a1,
                    onTap: () {
                      Navigator.pop(context);
                      deleteAccount?.call();
                    },
                    child: Ink(
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          heightFactor: 2.5,
                          child: Text(
                            txt_delete_account,
                            style: TextStyle(color: kColor247EF1, fontSize: text_16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size_10_h,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size_10_r),
              color: Colors.white,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(size_10_r),
              onTap: () {
                Navigator.pop(context);
              },
              child: Ink(
                child: Container(
                  width: double.infinity,
                  child: Center(
                    heightFactor: 2.5,
                    child: Text(
                      txt_cancel,
                      style: TextStyle(color: kColor247EF1, fontSize: text_16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider = Container(
    height: size_1_h,
    color: kColor6c6c6c,
  );
}
