import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/badge_list.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_default.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_default_sub.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_game_title.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_gtrate.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_gtscore.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_title.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlayerDetail extends StatelessWidget {
  PlayerDetail({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageGameViewModel>(builder: (context, value, child) {
      return Container(
        color: kColor202330,
        child: SafeArea(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Scaffold(
              backgroundColor: kColor1D212C,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: size_10_w,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SmartRefresher(
                        physics: AlwaysScrollableScrollPhysics(),
                        enablePullUp: false,
                        enablePullDown: true,
                        header: SmartRefresherCustomHeader(),
                        scrollDirection: Axis.vertical,
                        controller: value.playerRefreshController,
                        primary: false,
                        onRefresh: () {
                          value.refreshPlayerData();
                        },
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: size_10_w),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size_10_h),
                              StatsGameTitle(
                                gameTitleName: value.playerResponse?.game_info?.game_title_name ?? '',
                                gameSubTitle: txt_player_record,
                                gameTitleUrl: value.playerResponse?.game_info?.game_thumb_url ?? '',
                                selectedSortName: value.playerResponse?.selected_sort_name ?? '',
                                sortTypeList: value.playerResponse?.sort_type_list ?? [],
                                callback: (type) {
                                  value.mypagePlayerGameApi(sortType: type);
                                },
                              ),
                              SizedBox(height: size_10_h),
                              StatsUserProfile(
                                userThumbUrl: value.playerResponse?.user_info?.user_thumb_url ?? '',
                                userThumbBackgroundUrl: value.playerResponse?.user_info?.user_thumb_background_url ?? '',
                                userThumbFrameUrl: value.playerResponse?.user_info?.user_thumb_frame_url ?? '',
                                userName: value.playerResponse?.user_info?.user_name ?? '',
                                twitterScreenName: value.playerResponse?.user_info?.twitter_screen_name ?? '',
                                introduction: value.playerResponse?.user_info?.introduction ?? '',
                                urlTwitter: value.playerResponse?.user_info?.url_twitter ?? '',
                                urlWebTwitter: value.playerResponse?.user_info?.url_web_twitter ?? '',
                              ),
                              SizedBox(height: size_10_h,),
                              _playerHeadStats(),
                              StatsTitle(
                                iconPath: 'asset/icons/ic_person_mypage.svg',
                                title: txt_individual_match,
                              ),
                              _playerIndividual(),
                              StatsTitle(
                                iconPath: 'asset/icons/ic_people_mypage.svg',
                                title: txt_team_competition,
                              ),
                              _playerTeam(),
                              StatsTitle(
                                iconPath: 'asset/icons/ic_medal_mypage.svg',
                                title: txt_badge,
                              ),
                              BadgeList(
                                gameTitleName: value.playerResponse?.game_info?.game_title_name ?? '',
                                userThumbUrl: value.playerResponse?.user_info?.user_thumb_url ?? '',
                                badges: value.playerResponse?.badge_list ?? [],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _playerHeadStats() {
    return Consumer<MyPageGameViewModel>(builder: (context, value, child) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: StatsGtrate(
                    rate: value.playerResponse!.gt_rate?.value.toString() ?? '-',
                    prize: value.playerResponse!.gt_rate?.rank ?? '-',
                    maxRate: value.playerResponse!.gt_rate?.max_value.toString() ?? '-',
                    percent: value.playerResponse!.gt_rate?.percent ?? 0,
                    isClick: value.playerResponse!.gt_rate?.clickable ?? false,
                  ),
                ),
              ),
              SizedBox(width: size_10_w,),
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: StatsGtscore(
                    score: value.playerResponse!.gt_score?.value.toString() ?? '0',
                    rank: value.playerResponse!.gt_score?.rank?.toString() ?? '-',
                    upDown: value.playerResponse!.gt_score?.up_down ?? 'up',
                    percent: value.playerResponse!.gt_score?.percent.toString() ?? '-',
                    isClick: value.playerResponse!.gt_score?.clickable ?? false,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _playerIndividual() {
    return Consumer<MyPageGameViewModel>(builder: (context, value, child) {
      return Stack(
        children: [
          StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: size_10_w,
            crossAxisSpacing: size_10_h,
            children: value.playerResponse!.number_list!.map((e) =>
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: StatsDefault(
                    title: e.title ?? '',
                    value: e.value?.toString() ?? '',
                    isClick: e.clickable ?? false,
                  ),
                )).toList() + [
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: StatsDefaultSub(
                  title: txt_current_winning_streak_record,
                  value: value.playerResponse?.consecutive_win?.value.toString() ?? "0",
                  subTitle: txt_highest_consecutive_win_record,
                  subValue: value.playerResponse?.consecutive_win?.max_value
                      .toString() ?? "0",
                  isClick: false,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: StatsDefaultSub(
                  title: txt_score_number,
                  value: value.playerResponse?.score_number?.value.toString() ?? "0",
                  subTitle: txt_average_score,
                  subValue: value.playerResponse?.score_number?.ave_value.toString() ?? "0",
                  isClick: false,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: StatsDefaultSub(
                  title: txt_loss_score_number,
                  value: value.playerResponse?.loss_number?.value.toString() ?? '0',
                  subTitle: txt_average_loss_score,
                  subValue: value.playerResponse?.loss_number?.ave_value.toString() ??
                      '0',
                  isClick: false,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _playerTeam() {
    return Consumer<MyPageGameViewModel>(builder: (context, value, child) {
      return Container(
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: size_10_w,
          crossAxisSpacing: size_10_h,
          children: value.playerResponse!.team_number_list!.map((e) =>
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StatsDefault(
                  title: e.title ?? '',
                  value: e.value?.toString() ?? '',
                  isClick: e.clickable ?? false,
                ),
              )).toList(),
        ),
      );
    });
  }
}
