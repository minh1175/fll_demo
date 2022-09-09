import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_board_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchFilter extends StatelessWidget {
  const MatchFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchBoardViewModel>(builder: (context, value, child) {
      return Container(
        margin: EdgeInsets.only(top: size_20_h),
        child: SizedBox(
          height: size_40_h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('asset/icons/ic_shadow_left.png'),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.lsFilter.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      Container(
                        margin: EdgeInsets.only(right: size_10_w,),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (value.selectedFilterIdx != index){
                                      value.matchBoardListApi(tabIdx: index,);
                                    }
                                  },
                                  child: Container(
                                    color: value.selectedFilterIdx == index ? kColor2947C3 : kColor373C4A,
                                    padding: EdgeInsets.symmetric(
                                      vertical: size_6_h,
                                      horizontal: size_10_w,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          value.lsFilter[index].title!,
                                          style: TextStyle(
                                            fontSize: text_12,
                                            color: kWhiteAlpha,
                                          ),
                                        ),
                                        SizedBox(width: size_6_w,),
                                        Container(
                                          padding: EdgeInsets.all(size_6_h,),
                                          decoration: BoxDecoration(color: Colors.black,),
                                          child: Text(
                                            value.lsFilter[index].count!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: text_12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: (value.lsFilter[index].flg_badge_on == 1),
                              child: Positioned(
                                top: size_2_h,
                                right: size_4_w,
                                child: Icon(
                                  Icons.brightness_1,
                                  size: 10.0,
                                  color: kColorD0021C,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

