import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/view/component/common/smart_refresher_custom.dart';
import 'package:Gametector/app/view/home/tabs/tournament/tab_content/player_organizer_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmptyTournament extends StatelessWidget {
  EmptyTournament({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerOrganizerViewModel>(
      builder: (context, value, child) {
        return SmartRefresher(
          physics: AlwaysScrollableScrollPhysics(),
          enablePullUp: false,
          enablePullDown: true,
          header: SmartRefresherCustomHeader(),
          scrollDirection: Axis.vertical,
          controller: value.refreshController,
          primary: false,
          onRefresh: () {
            value.refreshData();
          },
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            // physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - size_200_h,
              child: Column(
                children: [
                  Container(
                    height: size_60_h,
                    margin: EdgeInsets.only(
                        top: size_30_h, left: size_20_w, right: size_20_w),
                    decoration: BoxDecoration(
                      color: kColor2b2e3c,
                      borderRadius: BorderRadius.all(
                          Radius.circular(size_4_r)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: size_12_h),
                        child: Text(txt_no_upcoming_tournament,
                            style:
                            TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}