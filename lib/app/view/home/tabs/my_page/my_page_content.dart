import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/common/res/style.dart';
import 'package:Gametector/app/view/component/bottom_sheet/account_setting_bottom_sheet.dart';
import 'package:Gametector/app/view/component/bottom_sheet/profile_bottom_sheet.dart';
import 'package:Gametector/app/view/component/common/twitter_elipse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'banner_gridview.dart';
import 'game_listview.dart';
import 'my_page_viewmodel.dart';

class MyPageContent extends StatelessWidget {
  MyPageContent({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageViewModel>(
      builder: (context, value, child) {
        return Container(
          color: kColor202330,
          child: SafeArea(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Scaffold(
                backgroundColor: kColor202330,
                body: Container(
                  padding: EdgeInsets.only(
                    left: size_10_w,
                    right: size_10_w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: size_10_h,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                value.myPageResponse?.user_name ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: text_18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: size_10_w,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      accountSettingBottomSheet(
                                        openTerm: () => value.showTerm(),
                                        openPolicy: () => value.showPolicy(),
                                        updateTwitterInfo: () => value.twitterInfoUpdateApi(),
                                        logoutAccount: () => value.logoutApi(context),
                                        deleteAccount: () => value.deleteAccount(),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        size_5_w,
                                      ),
                                      child: SvgPicture.asset(
                                        'asset/icons/ic_more_mypage_fix.svg',
                                        color: Colors.white,
                                        width: size_24_w,
                                        height: size_24_w,
                                        alignment: Alignment.center,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      profileBottomSheet();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        size_5_w,
                                      ),
                                      child: SvgPicture.asset(
                                        'asset/icons/ic_edit_mypage.svg',
                                        fit: BoxFit.fill,
                                        color: Colors.blue,
                                        width: size_24_w,
                                        height: size_24_w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size_5_w,
                                  ),
                                  TwitterElipse(
                                    width: size_30_w,
                                    height: size_20_h,
                                    callback: () {
                                      launchScheme(value.myPageResponse!.twitter_url!, value.myPageResponse!.twitter_web_url!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                vertical: size_20_h,
                              ),
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Linkify(
                                      onOpen: (link) => launchURL(link.url),
                                      text: value.myPageResponse?.introduction ?? '',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size_20_h,),
                                  GameListView(),
                                  SizedBox(height: size_20_h,),
                                  BannerGridView(),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: size_20_h),
                              alignment: Alignment.bottomCenter,
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(size_30_h),
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(size_14_r),
                                  onTap: () {
                                    launchURL(URL_USERS);
                                  },
                                  child: Ink(
                                    height: size_40_h,
                                    width: size_160_w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('asset/images/my_page_create_tournament.png'),
                                        // fit: BoxFit.fill,
                                      ),
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
