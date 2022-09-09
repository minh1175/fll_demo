import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/network/response/all_notification_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game.dart';
import 'package:flutter/material.dart';

class ItemOther extends StatelessWidget {
  Tournament? data;
  List<Label>? lsLabel = [];
  final Function readApi;

  ItemOther({Key? key, required this.data, this.lsLabel, required this.readApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size_2_h),
      child: GestureDetector(
        onTap: () {
          readApi();

          switch (data!.url_type) {
            case 0:
              launchURL(data!.url ?? '');
              break;
            case 1:
              print(data!.option!.game_title_id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPageGame(
                    gameTitleId: data!.option!.game_title_id!,
                    type: data!.option!.type!,
                  ),
                ),
              );
              break;
            default:
              print("invalid url_type");
          }
        },
        child: ListTile(
          dense: true,
          tileColor: data?.flg_unread == 1 ? kColorFF313A50 : kColor2b2e3c,
          leading: SizedBox(
            height: size_32_w,
            width: size_32_w,
            child: Stack(
              children: [
                PlayerThumb(
                  playerThumbUrl: data?.icon_url_main,
                  size: size_28_w,
                  placeholderImage: 'asset/images/ic_default_avatar.png',
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(size_2_h),
                    width: size_18_h,
                    height: size_18_h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size_20_r),
                      color: kColor2b2e3e,
                    ),
                    child: PlayerThumb(
                      playerThumbUrl: data?.icon_url_sub,
                      size: size_12_w,
                      placeholderImage: 'asset/images/ic_default_avatar.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: size_5_h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data?.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  data?.date ?? 'yyyy/mm/dd',
                  style: TextStyle(
                    color: kColor9696a1,
                    fontSize: text_10,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(bottom: size_5_h),
            child: Text(
              data?.message ?? '',
              style: TextStyle(
                color: kColor9696a1,
                fontSize: text_10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
