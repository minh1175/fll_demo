import 'dart:async';

import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/res/style.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/chat_private_page.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/notification_tab/notification_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'announce_page.dart';

class NotificationTab extends PageProvideNode<NotificationViewModel> {
  final int tournamentId;
  NotificationTab({
    Key? key,
    required this.tournamentId,
  }) : super(key: key, params: [tournamentId]);

  @override
  Widget buildContent(BuildContext context) {
    return _NotificationTab(viewModel,);
  }
}

class _NotificationTab extends StatefulWidget {
  final NotificationViewModel _notificationViewModel;

  const _NotificationTab(this._notificationViewModel, {
    Key? key,
  }) : super(key: key);

  @override
  State<_NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<_NotificationTab>{
  NotificationViewModel get notificationViewModel => widget._notificationViewModel;
  late StreamSubscription pushUpdateNotificationEventSubscription;

  @override
  void initState() {
    notificationViewModel.noticeListApi();

    pushUpdateNotificationEventSubscription = eventBus.on<PushUpdateNotificationEvent>().listen((event) {
      if (event.tourId != notificationViewModel.tournamentId) return;
      notificationViewModel.noticeListApi();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pushUpdateNotificationEventSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationViewModel>(builder: (context, value, child) {
      switch (value.loadingState) {
        case LoadingState.LOADING:
          return BuildProgressLoading();
        case LoadingState.DONE:
          return SmartRefresher(
            physics: AlwaysScrollableScrollPhysics(),
            enablePullUp: false,
            enablePullDown: true,
            header: SmartRefresherCustomHeader(),
            scrollDirection: Axis.vertical,
            controller: value.refreshController,
            primary: false,
            onRefresh: () {
              value.refreshData();
            },
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: value.lsItem.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) =>
                  Column(
                    children: [
                      (index == 0) ? Container(
                        height: size_2_h,
                        color: kColor1a1c27,
                      ) : Container(),
                      Container(
                        color: value.lsItem[index].flg_unread == 1 ? kColorFF313A50 : kColor2b2e3c,
                        padding: EdgeInsets.only(bottom: size_4_h),
                        child: ListTile(
                          dense: true,
                          leading: PlayerThumb(
                            playerThumbUrl: value.lsItem[index].thumb_url,
                            size: size_40_w,
                            placeholderImage: 'asset/images/ic_default_avatar.png',
                          ),
                          title: Text(
                            value.lsItem[index].title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: kColorD3DDE9,
                              fontSize: text_14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            value.lsItem[index].message!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kColoraaaaaa, fontSize: text_12),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                value.lsItem[index].notice_time!,
                                style: TextStyle(color: kColoraaaaaa, fontSize: text_11,),
                              ),
                              SizedBox(height: size_2_h,),
                              SizedBox(
                                width: size_100_w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _unreadCallBadge(value.lsItem[index].notice_type == 3),
                                    _unreadBadge(value.lsItem[index].notice_type == 1 && value.lsItem[index].flg_unread == 1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            value.noticeReadApi(index);
                            if (value.lsItem[index].tournament_round_id == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnnounceListPage(tournamentId: value.tournamentId,),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChatPrivatePage(
                                    tournamentId: value.tournamentId,
                                    tournamentRoundId: value.lsItem[index].tournament_round_id!,
                                    isDiplayTournamentButton: false,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        height: size_2_h,
                        color: kColor1a1c27,
                      ),
                    ],
                  ),
            ),
          );
        default:
          return Container();
      }
    });
  }

  Widget _unreadBadge(bool isDisplay) {
    return (isDisplay == true)
        ? Container(
          width: size_14_h,
          height: size_14_h,
          decoration: BoxDecoration(
            color: kColor880000,
            borderRadius: BorderRadius.circular(size_14_h,),
          ),
        )
        : Container();
  }

  Widget _unreadCallBadge(bool isDisplay) {
    return (isDisplay == true)
        ? Container(
          padding: EdgeInsets.symmetric(
            horizontal: size_10_w,
            vertical: size_2_h,
          ),
          decoration: BoxDecoration(
            color: kColor880000,
            borderRadius: BorderRadius.circular(size_10_r),
          ),
          child: Text(
            txt_call,
            style: TextStyle(
              color: Colors.white,
              fontSize: text_9,
            ),
          ),
        )
        : Container();
  }
}