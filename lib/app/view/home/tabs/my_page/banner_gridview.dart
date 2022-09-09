import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/network/response/mypage_response.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerGridView extends StatelessWidget {
  BannerGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageViewModel>(
      builder: (context, value, child) {
        return GridView.count(
          padding: EdgeInsets.only(bottom: size_70_h),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: size_14_h,
          crossAxisSpacing: size_10_w,
          childAspectRatio: 1.68,
          children: value.myPageResponse!.banner_list!
              .map((e) => ItemBanner(
                    context,
                    e,
                  ))
              .toList(),
        );
      },
    );
  }

  Widget ItemBanner(BuildContext context, MyPageBanner? dataBanner) {
    return GestureDetector(
      onTap: () {
        launchURL(dataBanner?.web_url ?? '');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size_14_r),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size_14_r),
            color: Colors.white,
          ),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            width: size_40_w,
            height: size_40_w,
            imageUrl: dataBanner?.thumb_url ?? '',
            placeholder: (context, url) => Image.asset(fit: BoxFit.fill, 'asset/images/bkg_gt.png',),
            errorWidget: (context, url, error) => Image.asset(fit: BoxFit.fill, 'asset/images/bkg_gt.png',),
          ),
        ),
      ),
    );
  }
}
