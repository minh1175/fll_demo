import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/component/common/game_thumb.dart';
import 'package:Gametector/app/view/home/tabs/home_main/home_main_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_webview_page.dart';

class HomeMainPage extends PageProvideNode<HomeMainViewModel> {
  @override
  Widget buildContent(BuildContext context) => _HomeMainContentPage(viewModel);
}

class _HomeMainContentPage extends StatefulWidget {
  HomeMainViewModel _homeMainViewModel;

  _HomeMainContentPage(this._homeMainViewModel, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<_HomeMainContentPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  HomeMainViewModel get homeMainViewModel => widget._homeMainViewModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    homeMainViewModel.homeApi();
    super.initState();
  }

  // Don't need to dispose homeMainViewModel

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMainViewModel>(builder: (context, value, child) {
      return DefaultTabController(
        length: value.gameThumbs.length,
        initialIndex: value.selectedIdx,
        child: Container(
          color: kColor202330,
          child: SafeArea(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Scaffold(
                backgroundColor: kColor202330,
                body: Container(
                  child: Column(
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
                      Theme(
                        data: ThemeData(splashFactory: NoSplash.splashFactory),
                        child: TabBar(
                          onTap: (int index) {
                            value.changeGameTitleId(value.gameThumbs[index].game_title_id!, index);
                          },
                          labelPadding: EdgeInsets.only(left: size_5_w, right: size_5_w,),
                          indicatorColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 2.0,
                          isScrollable: true,
                          tabs: value.gameThumbs.map((e) => Tab(
                            child: GameThumb(
                              gameThumbUrl: e.thumb_url ?? '',
                              size: size_40_w,
                              placeholderImage: 'asset/images/gray04.png',
                            ),
                          )).toList(),
                        ),
                      ),
                      Container(
                        height: size_2_h,
                        color: kCGrey102,
                      ),
                      Expanded(
                        child: HomeWebviewPage(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
