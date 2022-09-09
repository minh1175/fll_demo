import 'package:Gametector/app/module/network/response/mypage_game_response.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/component/dialog/congratulation_badge_dialog.dart';
import 'package:flutter/material.dart';


class BadgeList extends StatelessWidget {
  final String gameTitleName;
  final String userThumbUrl;
  final List<Badge> badges;

  const BadgeList({
    Key? key,
    required this.gameTitleName,
    required this.userThumbUrl,
    required this.badges,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          padding: EdgeInsets.only(bottom: size_10_h),
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: size_10_h,
          crossAxisSpacing: size_10_w,
          children: List.generate(
            this.badges.length,
            (index) => GestureDetector(
              onTap: () {
                showCongratulationBadgeDialog(
                  userThumbUrl: this.userThumbUrl,
                  gameTitle: this.gameTitleName,
                  badgeThumbUrl: this.badges[index].thumb_file_url,
                  badgeTitle: this.badges[index].title,
                  acquisitionDate: this.badges[index].acquisition_date,
                  category: this.badges[index].category,
                  gameCoverUrl: this.badges[index].game_cover_url,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size_10_w),
                child: Image.network(
                  this.badges[index].thumb_file_url?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}