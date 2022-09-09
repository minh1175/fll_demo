import 'package:Gametector/app/module/network/response/tournament_list_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/game_thumb.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemTournament extends StatelessWidget {
  ItemTourPlayerOrganizer? itemData;

  ItemTournament({
    Key? key,
    required this.itemData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TournamentControllerPage(tournamentId: this.itemData?.tournament_id ?? 0,),
          ),
        );
      },
      child: Card(
        color: kColor2b2f3c,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size_14_r),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: size_100_h,
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(size_14_r),
                            topRight: Radius.circular(size_14_r),
                          ),
                          // child: CachedNetworkImage(
                          //   fit: BoxFit.fitWidth,
                          //   imageUrl: itemData?.tournament_thumb_url ?? '',
                          //   placeholder: (context, url) => Image.asset(fit: BoxFit.fitWidth, 'asset/images/bkg_gt.png',),
                          //   errorWidget: (context, url, error) => Image.asset(fit: BoxFit.fitWidth, 'asset/images/bkg_gt.png',),
                          // ),
                          child: FadeInImage(
                            image: NetworkImage( itemData?.tournament_thumb_url ?? '',),
                            placeholder: AssetImage('asset/images/bkg_gt.png'),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'asset/images/bkg_gt.png',
                                fit: BoxFit.fitWidth,
                              );
                            },
                            fit: BoxFit.fitWidth,
                          ),
                      ),
                    ),
                    Positioned(
                      top: size_2_h,
                      left: size_6_w,
                      child: Card(
                        color: kColorB3000000,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size_2_h, horizontal: size_3_h,),
                          child: Text(
                            itemData?.tournament_status ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kColorFF2A2E43,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(size_14_r),
                      bottomRight: Radius.circular(size_14_r),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: size_64_h, top: size_5_h),
                        child: Text(
                          itemData?.schedule_ymdhis ?? '',
                          style:
                              TextStyle(color: Colors.white, fontSize: text_11),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: size_10_w, top: size_10_h),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: size_48_h,
                          ),
                          child: Text(
                            itemData?.tournament_name ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: text_12),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: size_10_w, top: size_14_h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: itemData?.tournament_type_str != '',
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: size_2_h, horizontal: size_6_w),
                                margin: EdgeInsets.only(right: size_4_w,),
                                color: kCGrey60141,
                                child: Center(
                                  child: Text(
                                    itemData?.tournament_type_str ?? '',
                                    style: TextStyle(color: Colors.white, fontSize: text_9),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: itemData?.match_type_str != '',
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: size_2_h, horizontal: size_6_w,),
                                margin: EdgeInsets.only(right: size_4_w,),
                                color: kCGrey60141,
                                child: Center(
                                  child: Text(
                                    itemData?.match_type_str ?? '',
                                    style: TextStyle(
                                      color: Colors.white, fontSize: text_9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size_16_h,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: size_10_w,),
                          PlayerThumb(
                            playerThumbUrl: itemData?.organizer_thumb_url ?? '',
                            size: size_22_w,
                            placeholderImage: 'asset/images/ic_default_avatar.png',
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: size_10_w, right: size_10_w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      itemData?.organizer_name ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: text_11,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size_5_h,
                                  ),
                                  Visibility(
                                    visible: (itemData?.role_type == 'both' || itemData?.role_type == 'organizer'),
                                    child: Wrap(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size_4_w,
                                            vertical: size_2_h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(size_12_r),
                                            color: Colors.pinkAccent,
                                          ),
                                          child: Center(
                                            child: Text(
                                              txt_you_are_hosting,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: text_8,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: size_10_w,
              top: size_80_h,
              child: Card(
                color: transparent,
                elevation: 1,
                child: GameThumb(
                  gameThumbUrl: itemData?.game_icon_thumb_url?? '',
                  size: size_32_w,
                  placeholderImage: 'asset/images/gray04.png',
                ),
              ),
            ),
            Visibility(
              visible: (itemData?.flg_tournament_badge_on == 1 ||
                  itemData?.flg_match_board_badge_on == 1 ||
                  itemData?.flg_notice_badge_on == 1),
              child: Positioned(
                top: 0,
                right: 0,
                child: Container(
                  height: size_16_h,
                  width: size_16_h,
                  decoration: BoxDecoration(
                    color: kColorD0021C,
                    borderRadius: BorderRadius.circular(size_16_r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
