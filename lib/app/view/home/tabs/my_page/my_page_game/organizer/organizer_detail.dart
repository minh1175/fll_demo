import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/badge_list.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_default.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_default_sub.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_game_title.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_gtscore.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_organizer_prize.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_title.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/stats/stats_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrganizerDetail extends StatelessWidget {
  const OrganizerDetail({Key? key,}) : super(key: key);

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
                        controller: value.organizerRefreshController,
                        primary: false,
                        onRefresh: () {
                          value.refreshOrganizerData();
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
                                gameTitleName: value.organizerResponse?.game_info?.game_title_name?? '',
                                gameSubTitle: txt_organizer_achievements,
                                gameTitleUrl: value.organizerResponse?.game_info?.game_thumb_url?? '',
                                selectedSortName: value.organizerResponse?.selected_sort_name?? '',
                                sortTypeList: value.organizerResponse?.sort_type_list?? [],
                                callback: (type) {
                                  value.mypageOrganizerGameApi(sortType: type);
                                },
                              ),
                              SizedBox(height: size_10_h,),
                              StatsUserProfile(
                                userThumbUrl: value.organizerResponse?.user_info?.user_thumb_url ?? '',
                                userThumbBackgroundUrl: value.organizerResponse?.user_info?.user_thumb_background_url ?? '',
                                userThumbFrameUrl: value.organizerResponse?.user_info?.user_thumb_frame_url ?? '',
                                userName: value.organizerResponse?.user_info?.user_name ?? '',
                                twitterScreenName: value.organizerResponse?.user_info?.twitter_screen_name ?? '',
                                introduction: value.organizerResponse?.user_info?.introduction ?? '',
                                urlTwitter: value.organizerResponse?.user_info?.url_twitter ?? '',
                                urlWebTwitter: value.organizerResponse?.user_info?.url_web_twitter ?? '',
                              ),
                              SizedBox(height: size_10_h,),
                              _organizerHeadStats(),
                              SizedBox(height: size_10_h),
                              _organizerStats(),
                              StatsTitle(
                                iconPath: 'asset/icons/ic_medal_mypage.svg',
                                title: txt_badge,
                              ),
                              BadgeList(
                                gameTitleName: value.organizerResponse?.game_info?.game_title_name ?? '',
                                userThumbUrl: value.organizerResponse?.user_info?.user_thumb_url ?? '',
                                badges: value.organizerResponse?.badge_list ?? [],
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

  Widget _organizerHeadStats() {
    return Consumer<MyPageGameViewModel>(builder: (context, value, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1.2,
              child: StatsOrganizerPrize(
                prizeEn: value.organizerResponse?.organizer_prize?.value_en ?? '-',
                prizeJa: value.organizerResponse?.organizer_prize?.value_ja ?? '-',
                percent: value.organizerResponse?.organizer_prize?.percent ?? 0,
                isClick: value.organizerResponse?.organizer_prize?.clickable ?? false,
              ),
            ),
          ),
          SizedBox(width: size_10_w,),
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1.2,
              child: StatsGtscore(
                score: value.organizerResponse?.gt_score?.value.toString() ?? '0',
                rank: value.organizerResponse?.gt_score?.rank?.toString() ?? '-',
                upDown: value.organizerResponse?.gt_score?.up_down.toString() ?? 'up',
                percent: value.organizerResponse?.gt_score?.percent.toString() ?? '-',
                isClick: value.organizerResponse?.gt_rate?.clickable ?? false,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _organizerStats() {
    return Consumer<MyPageGameViewModel>(builder: (context, value, child) {
      return Container(
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: size_10_w,
          crossAxisSpacing: size_10_h,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: StatsDefault(
                title: txt_number_of_tournaments_held,
                value: value.organizerResponse?.tournament_number?.value.toString()?? '0',
                isClick: value.organizerResponse?.tournament_number?.clickable ?? false,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: StatsDefault(
                title: txt_the_number_of_participants,
                value: value.organizerResponse?.entry_number?.value.toString() ?? '0',
                isClick: false,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: StatsDefault(
                title: txt_total_number_of_games,
                value: value.organizerResponse?.match_number?.value.toString() ?? '0',
                isClick: false,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: StatsDefaultSub(
                title: txt_maximum_tournament_scale,
                value: value.organizerResponse?.tournament_scale?.max_value.toString()?? '0',
                subTitle: txt_average_tournament_scale,
                subValue: value.organizerResponse?.tournament_scale?.ave_value
                    .toString() ?? '0',
                isClick: false,
              ),
            ),
          ],
        ),
      );
    },);
  }
}
