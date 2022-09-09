import 'dart:async';

import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/network/response/tournament_info_response.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/header_bulk_score.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_board_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_filter.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_list.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MatchBoardTab extends PageProvideNode<MatchBoardViewModel> {
  final int tournamentId;
  final TournamentInfo tournamentInfo;
  final bool isAllRoundFinish;

  MatchBoardTab({
    Key? key,
    required this.tournamentId,
    required this.tournamentInfo,
    required this.isAllRoundFinish,
  }) : super(key: key, params: [tournamentId]);

  @override
  Widget buildContent(BuildContext context) {
    return _MatchBoardTab(
      viewModel,
      tournamentInfo: this.tournamentInfo,
      isAllRoundFinish: this.isAllRoundFinish,
    );
  }
}

class _MatchBoardTab extends StatefulWidget {
  final MatchBoardViewModel _matchBoardViewModel;
  final TournamentInfo tournamentInfo;
  final bool isAllRoundFinish;

  const _MatchBoardTab(this._matchBoardViewModel, {
    Key? key,
    required this.tournamentInfo,
    required this.isAllRoundFinish,
  }) : super(key: key);

  @override
  __MatchBoardTabState createState() => __MatchBoardTabState();
}

class __MatchBoardTabState extends State<_MatchBoardTab> {
  MatchBoardViewModel get matchBoardViewModel => widget._matchBoardViewModel;
  late StreamSubscription pushReflectMatchResultEventSubscription;
  late StreamSubscription pushUpdateMatchBoardEventSubscription;
  late StreamSubscription pushReflectMatchResultBulkEventSubscription;

  @override
  void initState() {
    matchBoardViewModel.refreshData();

    pushReflectMatchResultEventSubscription = eventBus.on<PushReflectMatchResultEvent>().listen((event) {
      // TODO : not refreshData?
      if (event.pushReflectMatchResult.tournament_id != matchBoardViewModel.tournamentId) return;
      matchBoardViewModel.refreshData();
    });

    pushUpdateMatchBoardEventSubscription = eventBus.on<PushUpdateMatchBoardEvent>().listen((event) {
      if (event.tourId != matchBoardViewModel.tournamentId) return;
      matchBoardViewModel.refreshData();
    });

    pushReflectMatchResultBulkEventSubscription = eventBus.on<PushReflectMatchResultBulkEvent>().listen((event) {
      // TODO : not refreshData?
      if (event.pushReflectMatchResultBulk.tournament_id != matchBoardViewModel.tournamentId) return;
      matchBoardViewModel.refreshData();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pushReflectMatchResultEventSubscription.cancel();
    pushUpdateMatchBoardEventSubscription.cancel();
    pushReflectMatchResultBulkEventSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchBoardViewModel>(builder: (context, value, child) {
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
              value.matchBoardListApi();
            },
            child: SingleChildScrollView(
              controller: value.scrollController,
              child: Column(
                children: [
                  MatchFilter(),
                  widget.tournamentInfo.organizer_user_id == value.myUserId
                      ? HeaderBulkScore(
                          competitionType: widget.tournamentInfo.competition_type!,
                          leagueType: widget.tournamentInfo.league_type,
                          isAllRoundFinish: widget.isAllRoundFinish,
                        )
                      : Container(),
                  MatchList(),
                ],
              ),
            ),
          );
        default:
          return Container();
      }
    });
  }
}
