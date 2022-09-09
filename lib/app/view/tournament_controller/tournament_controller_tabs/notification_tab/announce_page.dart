import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/notification_tab/notification_viewmodel.dart';

class AnnounceListPage extends PageProvideNode<NotificationViewModel> {
  final int tournamentId;

  AnnounceListPage({Key? key, this.tournamentId = 0})
      : super(key: key, params: [tournamentId]);

  @override
  Widget buildContent(BuildContext context) {
    return _AnnounceListContentPage(viewModel,);
  }
}

class _AnnounceListContentPage extends StatefulWidget {
  final NotificationViewModel _notificationViewModel;
  _AnnounceListContentPage(this._notificationViewModel, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => __AnnounceListContentPageState();
}

class __AnnounceListContentPageState extends State<_AnnounceListContentPage>
    with SingleTickerProviderStateMixin {

  NotificationViewModel get notificationViewModel => widget._notificationViewModel;

  @override
  void initState() {
    notificationViewModel.announceListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationViewModel>(
      builder: (context, value, child) {
        return Container(
          color: kColor202330,
          child: SafeArea(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Scaffold(
                body: Container(
                  color: kColor202330,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
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
                            Text(
                              '全体アナウンス',
                              style: TextStyle(color: Colors.white, fontSize: text_15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: kColor33353F,
                      ),
                      Container(
                        width: double.infinity,
                        color: transparent,
                        padding: EdgeInsets.all(size_14_h),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(size_14_h),
                              color: kColor2b2e3e,
                              child: Text('大会主催者、ゲームテクター運営からのアナウンスを表示します',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: text_12)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                              itemCount: value.lsAnnounce.length,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: size_10_h, horizontal: size_14_w),
                                color: transparent,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: size_10_h),
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: size_14_h, right: size_14_h, bottom: size_14_h, top: size_5_h),
                                        color: kColor2b2e3e,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              dense: true,
                                              horizontalTitleGap: 0,
                                              contentPadding: EdgeInsets.zero,
                                              visualDensity: VisualDensity(horizontal: 2, vertical: 0),
                                              leading: PlayerThumb(
                                                playerThumbUrl: value.lsAnnounce[index].thumb_url,
                                                size: size_32_w,
                                                placeholderImage: 'asset/images/ic_default_avatar.png',
                                              ),
                                              title: Text(
                                                value.lsAnnounce[index].user_name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: text_12),
                                              ),
                                              subtitle: Text(
                                                DateFormat("MM月dd日 H:m").format(DateTime.fromMillisecondsSinceEpoch(value.lsAnnounce[index].notice_unix_time * 1000)).toString(),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: text_10),
                                              ),
                                            ),
                                            SelectableLinkify(
                                              onOpen: (link) => launchURL(link.url),
                                              text: value.lsAnnounce[index].message,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: text_14,
                                              ),
                                            ),
                                            Container(
                                              height: 15,
                                              color: Colors.transparent,
                                            ),
                                            value.lsAnnounce[index].image_url == ""
                                                ? SizedBox.shrink()
                                                : Container(
                                                    width: size_250_h,
                                                    height: size_250_h,
                                                    color: kColor1D212C,
                                                    child: Image(
                                                      image: NetworkImage(value.lsAnnounce[index].image_url),
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: size_10_w,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: size_2_h, horizontal: size_10_w,),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(size_10_r,),
                                          color: kColor4f5157,
                                        ),
                                        child: Text(
                                          value.lsAnnounce[index].icon_text,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: text_9,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




