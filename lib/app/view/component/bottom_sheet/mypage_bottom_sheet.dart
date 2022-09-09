import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/organizer/mypage_game_organizer_page.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/player/mypage_game_player_page.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void MypageBottomSheet({
  int? gameTitleId,
  int? userId,
  String? type,
}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: transparent,
    context: context,
    builder: (BuildContext builderContext) {
      return FractionallySizedBox(
        heightFactor: 0.95,
        child: MyPageGameBottomSheet(
          gameTitleId: gameTitleId,
          userId: userId,
          type: type,
        ),
      );
    },
  );
}

class MyPageGameBottomSheet extends PageProvideNode<MyPageGameViewModel> {
  final int? gameTitleId;
  final int? userId;
  final String? type;

  MyPageGameBottomSheet({
    Key? key,
    required this.gameTitleId,
    required this.userId,
    required this.type,
  }) : super(key: key, params: [userId, gameTitleId]);

  @override
  Widget buildContent(BuildContext context) {
    return _mypageBottomSheet(
      viewModel,
      type: this.type,
      key: key,
    );
  }
}

class _mypageBottomSheet extends StatefulWidget {
  final MyPageGameViewModel _mypageGameViewModel;
  final String? type;

  const _mypageBottomSheet(this._mypageGameViewModel, {
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  __mypageBottomSheetState createState() => __mypageBottomSheetState();
}

class __mypageBottomSheetState extends State<_mypageBottomSheet>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  MyPageGameViewModel get mypageGameViewModel => widget._mypageGameViewModel;
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    mypageGameViewModel.mypageOrganizerGameApi();
    mypageGameViewModel.mypagePlayerGameApi();
    _tabController = TabController(vsync: this, length: 2);
    if (widget.type != 'player') {
      setState(() {
        _tabController.index = 1;
        _selectedIndex = 1;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(size_10_r),
        ),
        color: kColor202330,
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size_14_w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(size_10_r),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'asset/icons/ic_close.svg',
                      width: size_24_w,
                      height: size_24_w,
                    ),
                  ),
                  TabBar(
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: size_5_w,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size_10_w,
                    ),
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
                            color: this._selectedIndex == 0
                                ? Colors.blue
                                : kColor252A37,
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
                            color: this._selectedIndex == 1
                                ? Colors.blue
                                : kColor252A37,
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
    );
  }
}
