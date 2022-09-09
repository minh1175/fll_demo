import 'package:Gametector/app/module/network/response/mypage_game_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/mypage_sort_bottom_sheet.dart';
import 'package:Gametector/app/view/component/common/game_thumb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatsGameTitle extends StatelessWidget {
  final String gameTitleName;
  final String gameSubTitle;
  final String gameTitleUrl;
  final String selectedSortName;
  final List<SortType> sortTypeList;
  final Function(int) callback;

  const StatsGameTitle({
    Key? key,
    required this.gameTitleName,
    required this.gameSubTitle,
    required this.gameTitleUrl,
    required this.selectedSortName,
    required this.sortTypeList,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size_12_r,),
            color: kColor252A37,
          ),
          width: double.infinity,
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -2),
            leading: GameThumb(
              gameThumbUrl: this.gameTitleUrl,
              size: size_40_w,
              placeholderImage: 'asset/images/gray04.png',
            ),
            title: Text(
              this.gameTitleName,
              style: TextStyle(color: Colors.white, fontSize: text_14,),
            ),
            subtitle: Text(
              this.gameSubTitle,
              style: TextStyle(color: Colors.white, fontSize: text_12,),
            ),
            trailing: GestureDetector(
              onTap: () {
                mypageSortBottomSheet(
                  callback: (type) {
                    this.callback(type);
                  },
                  sortTypeList: this.sortTypeList,
                );
              },
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size_14_h,
                      width: size_14_h,
                      child: SvgPicture.asset(
                        'asset/icons/ic_filter.svg',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: size_4_w,),
                    Text(
                      this.selectedSortName,
                      style: TextStyle(color: Colors.white, fontSize: text_11,),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}