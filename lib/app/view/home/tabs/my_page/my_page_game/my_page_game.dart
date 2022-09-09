import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/login_response.dart';
import 'package:Gametector/app/module/common/res/style.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/organizer/mypage_game_organizer_page.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/player/mypage_game_player_page.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyPageGame extends PageProvideNode<MyPageGameViewModel> {
  final int gameTitleId;
  final String type;

  MyPageGame({
    Key? key,
    required this.gameTitleId,
    this.type = "player",
  }) : super(key: key, params: [getIt<UserSharePref>().getUser()!.user_id, gameTitleId]);

  @override
  Widget buildContent(BuildContext context) {
    return _MyPageGame(
      viewModel,
      type: this.type,
      key: key,
    );
  }
}

class _MyPageGame extends StatefulWidget {
  final MyPageGameViewModel _mypageGameViewModel;
  final String type;
  const _MyPageGame(this._mypageGameViewModel, {
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _MyPageGameState createState() => _MyPageGameState();
}

class _MyPageGameState extends State<_MyPageGame>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  MyPageGameViewModel get mypageGameViewModel => widget._mypageGameViewModel;
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    mypageGameViewModel.mypageOrganizerGameApi();
    mypageGameViewModel.mypagePlayerGameApi();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(vsync: this, length: 2);
    if (widget.type != 'player') {
      setState(() {
        _tabController.index = 1;
        _selectedIndex = 1;
      });
    }
  }

  // TODO : pauseの時に毎回ここが呼ばれるのでボトムシートを閉じることで暫定対応にした。やり方変更したい。
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print ("************** MyPageGameViewModel.dispose ******************");
    mypageGameViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColor202330,
      child: SafeArea(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: Scaffold(
            backgroundColor: kColor202330,
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: size_5_h, left: size_5_w),
                    color: kColor202330,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(size_10_w,),
                            child: SvgPicture.asset(
                              'asset/icons/ic_back_arrow.svg',
                              color: Colors.white,
                              fit: BoxFit.fitWidth,
                              height: size_24_w,
                              width: size_24_w,
                            ),
                          ),
                        ),
                        TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: size_5_w,),
                          padding: EdgeInsets.symmetric(horizontal: size_10_w,),
                          controller: _tabController,
                          indicator: BoxDecoration(),
                          isScrollable: true,
                          onTap: (index) {
                            setState(() {
                              _selectedIndex = _tabController.index;
                            });
                          },
                          tabs: [
                            Tab(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size_14_w,
                                  vertical: size_6_h,
                                ),
                                decoration: BoxDecoration(
                                  color: this._selectedIndex == 0 ? Colors.blue : kColor252A37,
                                  borderRadius: BorderRadius.circular(size_50_r),
                                ),
                                child: Text(
                                  txt_player_record,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: text_12,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size_14_w,
                                  vertical: size_6_h,
                                ),
                                decoration: BoxDecoration(
                                  color: this._selectedIndex == 1 ? Colors.blue : kColor252A37,
                                  borderRadius: BorderRadius.circular(size_50_r),
                                ),
                                child: Text(
                                  txt_organizer_achievements,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: text_12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          child: PlayerPage(),
                        ),
                        Container(
                          child: OrganizerPage(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
