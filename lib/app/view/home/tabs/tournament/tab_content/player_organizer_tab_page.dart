import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/component/custom/custom_sliver_grid_delegate.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/home/tabs/tournament/tab_content/player_organizer_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'empty_tournament.dart';
import 'item_tournament_home.dart';

class PlayerOrganizerTabPage extends PageProvideNode<PlayerOrganizerViewModel> {
  PlayerOrganizerTabPage({
    Key? key,
    int tabType = 2,
    int filterType = 1
  }) : super(key: key, params: [tabType, filterType]);

  @override
  Widget buildContent(BuildContext context) {
    return _PlayerOrganizerPageContent(
      viewModel,
      key: key,
    );
  }
}

class _PlayerOrganizerPageContent extends StatefulWidget {
  final PlayerOrganizerViewModel _playerOrganizerViewModel;

  _PlayerOrganizerPageContent(this._playerOrganizerViewModel, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerOrganizerPageContentState();
}

class _PlayerOrganizerPageContentState extends State<_PlayerOrganizerPageContent>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  PlayerOrganizerViewModel get playerOrganizerViewModel => widget._playerOrganizerViewModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    playerOrganizerViewModel.listApi();
  }

  // Don't need to dispose ViewModel

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerOrganizerViewModel>(
      builder: (context, value, child) {
        switch (value.loadingState) {
          case LoadingState.LOADING:
            return BuildProgressLoading();
          case LoadingState.DONE:
            if (value.lsData.length == 0) {
              return EmptyTournament();
            } else {
              return SmartRefresher(
                physics: AlwaysScrollableScrollPhysics(),
                enablePullUp: (value.flagLastPage == 0),
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
                  value.listApi();
                },
                child: CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: value.scrollController,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.all(size_6_w),
                      sliver: SliverGrid(
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                          crossAxisCount: 2,
                          crossAxisSpacing: size_6_w,
                          mainAxisSpacing: size_6_w,
                          height: value.tabType == 2 ? size_290_h : size_300_h,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) => ItemTournament(
                            itemData: value.lsData[index],
                          ),
                          childCount: value.lsData.length,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          default:
            return Container();
        }
      },
    );
  }
}
