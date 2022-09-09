import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/header/tournament_header_tab_content.dart';
import 'package:Gametector/app/view/tournament_controller/header/tournament_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'tournament_controller_tabs/notification_tab/notification_tab.dart';
import 'tournament_controller_tabs/rule_overview_tab/rule_overview_tab.dart';
import 'tournament_controller_tabs/tournament_chat_tab/tournament_chat_tab.dart';

class EventPage extends StatefulWidget {
  const EventPage({
    Key? key,
  }) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    _tabController!.addListener(_unChangeTab);
    super.initState();
  }

  void _unChangeTab() {
    if (_tabController!.previousIndex == 0 && keyboardVisibilityController.isVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_unChangeTab);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentControllerViewModel>(builder: (context, value, child) {
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
                  TournamentHeader(
                    title: value.tournamentInfo?.tournament_name ?? "",
                    subTitle: value.tournamentInfo?.tournament_type_str ?? "",
                    gameThumbUrl: value.tournamentInfo?.game_icon_thumb_url ?? "",
                  ),
                  TabBar(
                    controller: _tabController,
                    labelPadding: EdgeInsets.zero,
                    indicatorColor: Colors.white,
                    tabs: [
                      TournamentHeadTabContent(index: 1, title: tab_chat, badgeCount: 0),
                      TournamentHeadTabContent(index: 2, title: tab_notifycation, badgeCount: value.tournamentInfo?.notice_badge_count ?? 0,),
                      TournamentHeadTabContent(index: 3, title: tab_rule_overview, badgeCount: 0),
                    ].map((element) =>
                        Tab(
                          height: size_40_h,
                          child: element,
                        ),).toList(),
                  ),
                  Container(
                    height: 1,
                    color: kColor2c2f3e,
                  ),
                  Expanded(
                    child: Builder(
                      builder: (BuildContext context) {
                        return TabBarView(
                          controller: _tabController,
                          children: [
                            TournamentChatTab(
                              tournamentId: value.tournamentId,
                              tournamentInfo: value.tournamentInfo,
                            ),
                            NotificationTab(tournamentId: value.tournamentId,),
                            RuleOverviewTab(),
                          ],
                        );
                      },
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


