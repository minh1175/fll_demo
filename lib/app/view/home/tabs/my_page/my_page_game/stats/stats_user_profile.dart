import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/component/common/player_thumb_with_prize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';

class StatsUserProfile extends StatelessWidget {
  final String userThumbUrl;
  final String userThumbBackgroundUrl;
  final String userThumbFrameUrl;
  final String userName;
  final String twitterScreenName;
  final String introduction;
  final String urlTwitter;
  final String urlWebTwitter;

  const StatsUserProfile({
    Key? key,
    required this.userThumbUrl,
    required this.userThumbBackgroundUrl,
    required this.userThumbFrameUrl,
    required this.userName,
    required this.twitterScreenName,
    required this.introduction,
    required this.urlTwitter,
    required this.urlWebTwitter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size_12_r,),
        color: kColor252A37,
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 0,),
            leading: PlayerThumbWithPrize(
              playerThumbUrl: this.userThumbUrl,
              playerFrameUrl: this.userThumbFrameUrl,
              playerBackgourndUrl: this.userThumbBackgroundUrl,
              size: size_75_w,
              placeholderImage: 'asset/images/ic_default_avatar.png',
            ),
            title: Text(
              this.userName,
              style: TextStyle(color: Colors.white,),
            ),
            subtitle: InkWell(
              onTap: () {
                launchScheme(this.urlTwitter, this.urlWebTwitter);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size_15_w,
                    height: size_15_w,
                    child: SvgPicture.asset('asset/icons/ic_twitter.svg',),
                  ),
                  SizedBox(width: size_4_w,),
                  Text(
                    this.twitterScreenName,
                    style: TextStyle(color: kColor4A90E2,),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (this.introduction != ""),
            child: Padding(
              padding: EdgeInsets.only(left: size_90_w, right: size_10_w, bottom: size_20_h,),
              child: Linkify(
                onOpen: (link) => launchURL(link.url),
                text: this.introduction,
                style: TextStyle(color: Colors.white,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
