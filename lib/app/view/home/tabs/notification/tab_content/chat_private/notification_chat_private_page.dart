import 'dart:async';

import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../item_notification_chat.dart';
import 'notification_chat_private_viewmodel.dart';

class NotificationChatPrivatePage extends PageProvideNode<NotificationChatPrivateViewModel> {

  NotificationChatPrivatePage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return _NotificationChatPrivateContent(
      viewModel,
      key: key,
    );
  }
}

class _NotificationChatPrivateContent extends StatefulWidget {
  final NotificationChatPrivateViewModel _notificationChatPrivateViewModel;

  _NotificationChatPrivateContent(this._notificationChatPrivateViewModel,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationChatPrivateContentState();
}

class _NotificationChatPrivateContentState extends State<_NotificationChatPrivateContent> {
  NotificationChatPrivateViewModel get notificationChatPrivateViewModel => widget._notificationChatPrivateViewModel;
  late StreamSubscription pushUpdateAllNotificationEventSubscription;

  @override
  void initState() {
    notificationChatPrivateViewModel.refreshData();
    pushUpdateAllNotificationEventSubscription = eventBus.on<PushUpdateAllNotificationEvent>().listen((event) {
      if (event.pushUpdateAllNotification.type != 2) return;
      notificationChatPrivateViewModel.refreshData();
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
    return Consumer<NotificationChatPrivateViewModel>(
      builder: (context, value, child) {
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
                value.refreshData();
              },
              onLoading: () {
                value.notificationChatPrivateListApi();
              },
              child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: value.scrollController,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return ItemNotificationChat(
                          data: value.lsData[index],
                          lsLabel: value.lsData[index].label_list,
                          readApi: () =>  value.noticeReadApi(index),
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
      },
    );
  }
}
