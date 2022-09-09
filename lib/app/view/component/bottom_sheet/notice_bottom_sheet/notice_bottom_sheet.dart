import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/get_setting_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/notice_bottom_sheet/notice_bottom_sheet_viewmodel.dart';
import 'package:Gametector/app/view/component/common/bottom_sheet_container.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void noticeBottomSheet() {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: transparent,
    context: context,
    builder: (BuildContext builderContext) {
      // TODO : pauseの時に毎回ここが呼ばれるのでボトムシートを閉じることで暫定対応にした。やり方変更したい。
      return FractionallySizedBox(
        heightFactor: 0.95,
        child: NoticeBottomSheet(),
      );
    },
  );
}

class NoticeBottomSheet extends PageProvideNode<NoticeBottomSheetViewModel> {
  NoticeBottomSheet({Key? key,}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return _NoticeBottomSheet(viewModel,);
  }
}

class _NoticeBottomSheet extends StatefulWidget {
  final NoticeBottomSheetViewModel _noticeBottomSheetViewModel;
  const _NoticeBottomSheet(this._noticeBottomSheetViewModel, {
    Key? key
  }) : super(key: key);

  @override
  __NoticeBottomSheetState createState() => __NoticeBottomSheetState();
}

class __NoticeBottomSheetState extends State<_NoticeBottomSheet>
    with WidgetsBindingObserver {
  NoticeBottomSheetViewModel get noticeBottomSheetViewModel => widget._noticeBottomSheetViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    noticeBottomSheetViewModel.getSettingAPI();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print ("************** noticeBottomSheetViewModel.dispose ******************");
    noticeBottomSheetViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeBottomSheetViewModel>(builder: (context, value, child) {
      return BottomSheetContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      txt_notice_setting,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      txt_delay_time_apply_settings,
                      style: TextStyle(color: Colors.white, fontSize: text_10),
                    ),
                    trailing: Ink(
                      child: InkWell(
                        onTap: () async {
                          value.postSettingApi();
                        },
                        child: Wrap(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: size_16_w, vertical: size_4_h,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(size_16_r),
                                color: Colors.blue,
                              ),
                              child: Text(txt_open_notice_setting,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: text_14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: size_3_h,
              thickness: size_3_h,
              color: Colors.black,
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: kColor202330,
                  borderRadius: BorderRadius.all(Radius.circular(size_10_r)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(value.settingResponse?.list?.length?? 0,(index){
                      return Column(
                        children: [
                          index != 0 ? Divider(
                            height: size_3_h,
                            thickness: size_3_h,
                            color: Colors.black,
                          ) : Container(),
                          SettingGroup(value.settingResponse?.list?[index]),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget SettingGroup(Item? group) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size_20_w, vertical: size_20_h,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            group?.group?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: text_16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size_10_h,),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            children: group!.content!.map((e) => SettingItem(e)).toList(),
          ),
        ],
      ),
    );
  }

  Widget SettingItem(Content? item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size_5_h,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item?.title?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size_3_h,),
              item?.comment != '' ? Text(
                item?.comment?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_9,
                ),
              ) : Container(),
            ],
          ),
          Spacer(),
          Switch(
            value: item?.flg_on == 1,
            onChanged: (bool newValue) {
              widget._noticeBottomSheetViewModel.changeSetting(item?.key?? '', newValue? 1 : 0);
            },
          ),
        ],
      ),
    );
  }

  Widget TwitterSetting() {
    return ListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.only(bottom: size_10_h),
          height: size_80_h,
          width: size_200_w,
          child: SvgPicture.asset(
            'asset/images/img_notice_bottom_sheet.svg',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      subtitle: Text(
        txt_receive_mentions_on_twitter,
        style: TextStyle(color: Colors.white, fontSize: text_10),
      ),
      trailing: Switch(
        value: true,
        onChanged: (value) {},
      ),
    );
  }
}
