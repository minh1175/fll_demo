import 'dart:ui';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/game_thumb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';


class TournamentHeader extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? gameThumbUrl;
  const TournamentHeader({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.gameThumbUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: size_10_h),
      color: kColor202330,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(size_10_w,),
              child: SvgPicture.asset(
                'asset/icons/ic_back_arrow.svg',
                height: size_24_w,
                width: size_24_w,
              ),
            ),
          ),
          SizedBox(width: size_10_w,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  this.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: text_14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  this.subTitle!,
                  style: TextStyle(
                    color: kWhiteAlpha,
                    fontSize: text_10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: size_10_w,),
          GameThumb(
            gameThumbUrl: this.gameThumbUrl!,
            size: size_30_w,
            placeholderImage: 'asset/images/gray04.png',
          ),
          SizedBox(width: size_10_w,),
        ],
      ),
    );
  }
}