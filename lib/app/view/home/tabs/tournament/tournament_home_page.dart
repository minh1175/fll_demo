import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/tournament/tournament_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab/player_organizer_tab_bar.dart';
import 'tab_content/player_organizer_tab_page.dart';

class TournamentHomePage extends PageProvideNode<TournamentHomeViewModel> {
  TournamentHomePage({Key? key, int tabType = 2})
      : super(key: key, params: [tabType]);

  @override
  Widget buildContent(BuildContext context) {
    return _TournamentHomeContentPage(
      viewModel,
      key: key,
    );
  }
}

class _TournamentHomeContentPage extends StatefulWidget {
  final TournamentHomeViewModel _tournamentHomeViewModel;

  _TournamentHomeContentPage(this._tournamentHomeViewModel, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TournamentHomeContentState();
}

class _TournamentHomeContentState extends State<_TournamentHomeContentPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TournamentHomeViewModel get tournamentHomeViewModel => widget._tournamentHomeViewModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    tournamentHomeViewModel.filterMenuListApi();
    super.initState();
  }

  // Don't need to dispose ViewModel

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentHomeViewModel>(
      builder: (context, value, child) {
        return DefaultTabController(
          length: value.lsFilter.length,
          child: Container(
            color: kColor202330,
            child: SafeArea(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: Scaffold(
                  backgroundColor: kColor202330,
                  key: _scaffoldKey,
                  body: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: size_24_h,
                                bottom: size_10_h,
                                left: size_10_w,
                                right: size_10_w,
                              ),
                              child: Image.asset(
                                'asset/images/logo.png',
                                width: size_180_w,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TabBar(
                                    indicatorColor: Colors.white,
                                    isScrollable: false,
                                    labelPadding: EdgeInsets.zero,
                                    tabs: value.lsFilter
                                        .map((e) => PlayerPageTab(txtTab: e.title ?? '',))
                                        .toList(),
                                  ),
                                  Container(
                                    height: size_2_h,
                                    color: kCGrey102,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: value.lsFilter
                                .map((e) => PlayerOrganizerTabPage(
                              key: Key('${widget.key}-${e.title}') ,
                              tabType: value.tabType,
                              filterType: e.type ?? 1,
                            )).toList(),
                          ),
                        ),
                      ],
                    ),
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
