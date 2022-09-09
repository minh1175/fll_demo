import 'package:Gametector/app/module/network/response/mypage_response.dart';
import 'package:Gametector/app/module/common/res/style.dart';
import 'package:Gametector/app/view/component/common/game_thumb.dart';
import 'package:Gametector/app/view/component/custom/ic_halfcircle.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameListView extends StatelessWidget {
  GameListView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageViewModel>(
      builder: (context, value, child) {
        return ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: value.myPageResponse!.game_list!.map((e) => ItemGameList(context, e,)).toList(),
        );
      },
    );
  }

  Widget ItemGameList(BuildContext context, Game? dataGame) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyPageGame(gameTitleId: dataGame!.game_title_id!),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
        leading: GameThumb(
          gameThumbUrl: dataGame?.game_thumb_url ?? '',
          size: size_40_w,
          placeholderImage: 'asset/images/gray04.png',
        ),
        title: Container(
          height: size_50_h,
          padding: EdgeInsets.only(
            left: size_10_w,
          ),
          decoration: BoxDecoration(
            color: kColor252A37,
            borderRadius: BorderRadius.circular(size_10_r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                dataGame?.game_title_name ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IcHalfCircle(),
            ],
          ),
        ),
      ),
    );
  }
}
