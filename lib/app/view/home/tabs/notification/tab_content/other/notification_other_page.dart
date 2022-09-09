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
import 'notification_other_item.dart';
import 'notification_other_viewmodel.dart';

class NotificationOtherPage
    extends PageProvideNode<NotificationOtherViewModel> {
  NotificationOtherPage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return _NotificationOtherContent(
      viewModel,
      key: key,
    );
  }
}

class _NotificationOtherContent extends StatefulWidget {
  final NotificationOtherViewModel _notificationOtherViewModel;

  _NotificationOtherContent(this._notificationOtherViewModel, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationOtherContentState();
}

class _NotificationOtherContentState extends State<_NotificationOtherContent> {
  NotificationOtherViewModel get notificationOtherViewModel => widget._notificationOtherViewModel;
  late StreamSubscription pushUpdateAllNotificationEventSubscription;

  @override
  void initState() {
    notificationOtherViewModel.refreshData();
    pushUpdateAllNotificationEventSubscription = eventBus.on<PushUpdateAllNotificationEvent>().listen((event) {
      if (event.pushUpdateAllNotification.type != 3) return;
      notificationOtherViewModel.refreshData();
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
    return Consumer<NotificationOtherViewModel>(
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
                value.notificationOtherListApi();
              },
              child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: value.scrollController,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return ItemOther(
                          data: value.lsOther[index],
                          lsLabel: value.lsOther[index].label_list,
                          readApi: () {value.noticeReadApi(index);},
                        );
                      },
                      childCount: value.lsOther.length,
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
