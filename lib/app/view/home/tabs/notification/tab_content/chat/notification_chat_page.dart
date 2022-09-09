import 'dart:async';

import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/home/tabs/notification/tab_content/chat/notification_chat_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../item_notification_chat.dart';

class NotificationChatPage extends PageProvideNode<NotificationChatViewModel> {
  NotificationChatPage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return _NotificationChatContent(
      viewModel,
      key: key,
    );
  }
}

class _NotificationChatContent extends StatefulWidget {
  final NotificationChatViewModel _notificationChatViewModel;

  _NotificationChatContent(this._notificationChatViewModel,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationChatContentState();
}

class _NotificationChatContentState extends State<_NotificationChatContent> {
  NotificationChatViewModel get notificationChatViewModel => widget._notificationChatViewModel;
  late StreamSubscription pushUpdateAllNotificationEventSubscription;

  @override
  void initState() {
    notificationChatViewModel.refreshData();
    pushUpdateAllNotificationEventSubscription = eventBus.on<PushUpdateAllNotificationEvent>().listen((event) {
      if (event.pushUpdateAllNotification.type != 1) return;
      notificationChatViewModel.refreshData();
    });
    super.initState();
  }

  // Don't need to dispose ViewModel
  @override
  void dispose() {
    pushUpdateAllNotificationEventSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationChatViewModel>(builder: (context, value, child) {
      switch (value.loadingState) {
        case LoadingState.LOADING:
          return BuildProgressLoading();
        case LoadingState.DONE:
          return SmartRefresher(
            physics: AlwaysScrollableScrollPhysics(),
            enablePullUp: (value.flgLastPage == 0),
            enablePullDown: true,
            header: SmartRefresherCustomHeader(),
            footer: SmartRefresherCustomFooter(),
            scrollDirection: Axis.vertical,
            controller: value.refreshController,
            primary: false,
            onRefresh: () {
              notificationChatViewModel.refreshData();
            },
            onLoading: () {
              notificationChatViewModel.notificationChatListApi();
            },
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              controller: value.scrollController,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return ItemNotificationChat(
                        data: value.lsData[index],
                        lsLabel: value.lsData[index].label_list,
                        readApi: () => notificationChatViewModel.noticeReadApi(index),
                      );
                    },
                    childCount: value.lsData.length,
                  ),
                ),
              ],
            ),
          );
        default:
          return Container();
      }
    });
  }
}