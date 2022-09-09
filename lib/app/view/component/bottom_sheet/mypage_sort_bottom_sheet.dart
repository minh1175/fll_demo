import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/mypage_game_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';

void mypageSortBottomSheet({
  required List<SortType> sortTypeList,
  required Function(int) callback,
}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;

  showModalBottomSheet(
    backgroundColor: transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext builderContext) {
      return MypageSortBottomSheet(
        sortTypeList: sortTypeList,
        callback: callback,
      );
    },
  );
}

class MypageSortBottomSheet extends StatelessWidget {
  List<SortType> sortTypeList;
  Function(int) callback;

  MypageSortBottomSheet({
    Key? key,
    required this.sortTypeList,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size_10_w, vertical: size_10_h,),
      // color: transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size_10_r),
              color: kCGrey165,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  heightFactor: 2.9,
                  child: Text(
                    txt_display_sort_period,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: text_14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Column(
                  children: sortTypeList.map((e) => _content(context, e)).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: size_10_h,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size_10_r),
              color: Colors.white,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(size_10_r),
              onTap: () {
                Navigator.pop(context);
              },
              child: Ink(
                child: Container(
                  width: double.infinity,
                  child: Center(
                    heightFactor: 2.5,
                    child: Text(
                      txt_cancel,
                      style: TextStyle(color: kColor247EF1, fontSize: text_16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context, SortType sortType) {
    return Column(
      children: [
        Container(
          height: size_1_h,
          color: kColor6c6c6c,
        ),
        InkWell(
          highlightColor: kColor9696a1,
          splashColor: kColor9696a1,
          onTap: () {
            this.callback(sortType.sort_type?? 0);
            Navigator.pop(context);
          },
          child: Ink(
            child: Container(
              width: double.infinity,
              child: Center(
                heightFactor: 2.5,
                child: Text(
                  sortType.sort_name?? '',
                  style: TextStyle(color: kColor247EF1, fontSize: text_16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}