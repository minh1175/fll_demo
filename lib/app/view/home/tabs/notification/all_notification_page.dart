import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/notice_bottom_sheet/notice_bottom_sheet.dart';
import 'package:Gametector/app/view/home/tabs/notification/tab_content/chat/notification_chat_page.dart';
import 'package:Gametector/app/view/home/tabs/notification/tab_content/chat_private/notification_chat_private_page.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'all_notification_viewmodel.dart';
import 'tab/notification_tab.dart';
import 'tab_content/other/notification_other_page.dart';

class AllNotificationPage extends PageProvideNode<AllNotificationViewModel> {
  AllNotificationPage({Key? key}) : super(key: key, params: []);

  @override
  Widget buildContent(BuildContext context) {
    return _AllNotificationContent(
      viewModel,
      key: key,
    );
  }
}

class _AllNotificationContent extends StatefulWidget {
  final AllNotificationViewModel _notificationViewModel;

  _AllNotificationContent(this._notificationViewModel, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllNotificationContentState();
}

class _AllNotificationContentState extends State<_AllNotificationContent>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AllNotificationViewModel get allNotificationViewModel => widget._notificationViewModel;

  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    allNotificationViewModel.init(TabController(length: 3, vsync: this));
    super.initState();
  }

  // Don't need to dispose ViewModel

  @override
  Widget build(BuildContext context) {
    return Consumer<AllNotificationViewModel>(builder: (context, value, child) {
      return Container(
        color: kColor202330,
        child: SafeArea(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Scaffold(
              backgroundColor: kColor202330,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: kColor202330,
                    padding: EdgeInsets.only(
                      left: size_20_w,
                      right: size_20_w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          txt_notice,
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () => noticeBottomSheet(),
                          child: Text(
                            txt_notice_setting,
                            style: TextStyle(color: kCGrey141, fontSize: text_12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: kColor202330,
                            padding: EdgeInsets.symmetric(horizontal: size_10_w),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: kColor2b2e3e,
                                      borderRadius: BorderRadius.circular(size_10_r),),
                                    height: size_40_h,
                                    child: TabBar(
                                      controller: value.tabController,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicator: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(size_10_r),
                                        ),
                                        color: kColor4A5261,
                                      ),
                                      isScrollable: false,
                                      tabs: [
                                        NotificationPageTab(txtTab: tab_chat, badgeCount: value.tabBadgeCount[0]),
                                        NotificationPageTab(txtTab: txt_private_chat, badgeCount: value.tabBadgeCount[1]),
                                        NotificationPageTab(txtTab: txt_others, badgeCount: value.tabBadgeCount[2]),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size_10_h,),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: size_2_h,
                            color: kColor2b2e3c,
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: value.tabController,
                              children: [
                                NotificationChatPage(),
                                NotificationChatPrivatePage(),
                                NotificationOtherPage(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
