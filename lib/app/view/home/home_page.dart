import 'dart:async';
import 'dart:io';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/common/res/style.dart';
import 'package:Gametector/app/view/component/bottom_sheet/entry_bottom_sheet.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/base_viewmodel.dart';
import 'tabs/home_main/home_main_page.dart';
import 'tabs/my_page/my_page.dart';
import 'tabs/notification/all_notification_page.dart';
import 'tabs/notification/all_notification_viewmodel.dart';
import 'tabs/tournament/tournament_home_page.dart';
import 'package:Gametector/app/viewmodel/life_cycle_base.dart';

class HomePage extends PageProvideNode<AllNotificationViewModel> {
  HomePage({Key? key}) : super(key: key, params: []);

  @override
  Widget buildContent(BuildContext context) {
    return _HomePage(viewModel);
  }
}

class _HomePage extends StatefulWidget {
  final AllNotificationViewModel _allNotificationViewModel;

  _HomePage(this._allNotificationViewModel);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends LifecycleState<_HomePage> {
  AllNotificationViewModel get allNotificationViewModel => widget._allNotificationViewModel;
  int _currentIndex = 0;

  List<Widget> _children = [
    HomeMainPage(),
    TournamentHomePage(key: Key('tournament-player'), tabType: 2),
    TournamentHomePage(key: Key('tournament-organizer'), tabType: 1),
    AllNotificationPage(),
    MyPage(),
  ];

  @override
  void initState() {
    if (getIt<NavigationService>().currentHomeIndex != -1) {
      _currentIndex = getIt<NavigationService>().currentHomeIndex;
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<NavigationService>().currentHomeIndex = -1;
    });
    allNotificationViewModel.badgeCountApi();
    initDynamicLinks();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void initDynamicLinks() {
    // アプリ起動時
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final deepLink = dynamicLinkData.link;
      if (deepLink != null) {
        var user = getIt<UserSharePref>().getUser();
        if (user != null && user.user_id != 0) {
          var params = Uri.parse(deepLink.toString()).queryParameters;
          if (params["type"] == "entry") {
            Future.delayed(
              Duration(milliseconds: 1000), () {
              if (params["type"] == "entry") {
                showEntryBottomSheet(params);
              };
            },
            );
          }
        } else {
          // TODO : when user did not login, open entry modal after login!!!!!!
        }
      }
    }).onError((error) {
    });

    // when app is not running
    if(Platform.isAndroid) {
      Future.delayed(Duration.zero, () async {
        final dynamicLink = await FirebaseDynamicLinks.instance.getInitialLink();
        final deepLink = dynamicLink?.link;
        var user = getIt<UserSharePref>().getUser();
        if (user != null && user.user_id != 0) {
          if (deepLink != null) {
            Future.delayed(
              Duration(milliseconds: 3000), () {
              var params = Uri
                  .parse(deepLink.toString())
                  .queryParameters;
              if (params["type"] == "entry") {
                showEntryBottomSheet(params);
              }
            },
            );
          }
        } else {
          // TODO : when user did not login, open entry modal after login!!!!!!
        }
      });
    }
  }

  void showEntryBottomSheet(params) {
    var url = URL_ENTRY.replaceAll('{tournamentId}', params["tournament_id"]!).replaceAll('{deviceType}', 'flutter');
    url = url + (url.contains("?") ? "&" : "?") + "entry_key=" + params["entry_key"];
    if (params.containsKey("team_key")) {
      url = url + "&team_key=" + params["team_key"];
    }
    entryBottomSheet(url: url);
  }

  void onTabBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllNotificationViewModel>(
      builder: (context, value, child) {
        return Container(
          color: kColor202330,
          child: SafeArea(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Scaffold(
                body: _children[_currentIndex],
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    color: kColor202330,
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.75),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size_4_h),
                    child: BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: kColor202330,
                      selectedItemColor: kCGrey247,
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      selectedFontSize: text_11,
                      unselectedFontSize: text_11,
                      type: BottomNavigationBarType.fixed,
                      unselectedItemColor: kCGrey60141,
                      items: [
                        BottomNavigationBarItem(
                          icon: Container(
                            width: size_20_w,
                            height: size_20_w,
                            child: SvgPicture.asset(
                              'asset/icons/ic_tab_home.svg',
                              color: _currentIndex == 0 ? kCGrey247 : kCGrey60141,
                            ),
                          ),
                          label: txt_home,
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            width: size_20_w,
                            height: size_20_w,
                            child: SvgPicture.asset(
                              'asset/icons/ic_tab_tournament_player.svg',
                              color: _currentIndex == 1 ? kCGrey247 : kCGrey60141,
                            ),
                          ),
                          label: txt_tournament_list_player,
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            width: size_20_w,
                            height: size_20_w,
                            child: SvgPicture.asset(
                              'asset/icons/ic_tab_tournament_organizer.svg',
                              color: _currentIndex == 2 ? kCGrey247 : kCGrey60141,
                            ),
                          ),
                          label: txt_tournament_list_organizer,
                        ),
                        BottomNavigationBarItem(
                          icon: Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Container(
                                width: size_40_w,
                                height: size_20_w,
                                child: SvgPicture.asset(
                                  'asset/icons/ic_tab_notice.svg',
                                  color: _currentIndex == 3 ? kCGrey247 : kCGrey60141,
                                ),
                              ),
                              Visibility(
                                visible: value.flgBadgeOn,
                                child: Positioned(  // draw a red marble
                                  top: 0.0,
                                  right: 0.0,
                                  child: Icon(
                                    Icons.brightness_1,
                                    size: 14.0,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          label: txt_all_notification,
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            width: size_20_w,
                            height: size_20_w,
                            child: SvgPicture.asset(
                              'asset/icons/ic_tab_mypage.svg',
                              color: _currentIndex == 4 ? kCGrey247 : kCGrey60141,
                            ),
                          ),
                          label: txt_my_page,
                        ),
                      ],
                      currentIndex: _currentIndex,
                      onTap: onTabBar,
                    ),
                  ),
                ),
                backgroundColor: kColor202330,
              ),
            ),
          ),
        );
      },
    );
  }
}
