import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/network/response/profile_info_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/bottom_sheet_container.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void profileBottomSheet() {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  showModalBottomSheet(
    backgroundColor: transparent,
    context: context,
    enableDrag: true,
    isDismissible: false,
    isScrollControlled: true,
    builder: (BuildContext builderContext) {
      return makeDismissible(
          child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (BuildContext context, ScrollController scrollController) {
          return ProfileBottomSheet(
            scrollController: scrollController,
          );
        },
      ));
    },
  );
}

// TODO : PageProvideNodeを無くしたい
class ProfileBottomSheet extends PageProvideNode<MyPageViewModel> {
  ScrollController scrollController;

  ProfileBottomSheet({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return _ProfileBottomSheet(
      viewModel,
      scrollController: scrollController,
    );
  }
}

class _ProfileBottomSheet extends StatefulWidget {
  final MyPageViewModel _myPageViewModel;
  ScrollController scrollController;

  _ProfileBottomSheet(this._myPageViewModel, {
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  __ProfileBottomSheetState createState() => __ProfileBottomSheetState();
}

class __ProfileBottomSheetState extends State<_ProfileBottomSheet> {
  @override
  void initState() {
    widget._myPageViewModel.profileAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageViewModel>(builder: (context, value, child) {
      return BottomSheetContainer(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: widget.scrollController,
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size_20_w,
                  vertical: size_20_h,
                ),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PlayerThumb(
                            playerThumbUrl: value.loginResponse?.thumb_url ?? '',
                            size: size_40_w,
                            placeholderImage:
                                'asset/images/ic_default_avatar.png',
                          ),
                          SizedBox(
                            height: size_10_h,
                          ),
                          Text(
                            value.myPageResponse?.user_name ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size_20_h,
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            txt_new_item_is_added,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_12,
                            ),
                          ),
                          Text(
                            txt_enrich_your_profile,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_12,
                            ),
                          ),
                          SizedBox(
                            height: size_10_h,
                          ),
                          Text(
                            txt_edit_later,
                            style: TextStyle(
                                color: Colors.white, fontSize: text_12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size_20_h,
                    ),
                    ProfileForm(context),
                    SizedBox(
                      height: size_20_h,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Text(
                        txt_profile_remark,
                        style:
                            TextStyle(fontSize: text_12, color: kColoraaaaaa),
                      ),
                    ),
                    SizedBox(height: size_150_h),
                  ],
                ),
              ),
            ),
            ProfileButton(context),
          ],
        ),
      );
    });
  }

  Widget ProfileForm(BuildContext context) {
    OutlineInputBorder _textFieldStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(size_10_r),
      borderSide: BorderSide(color: kColor14161E, width: 0),
    );
    BoxDecoration _selectBoxStyle = BoxDecoration(
      color: kColor14161E,
      borderRadius: BorderRadius.circular(size_10_r),
    );
    return Consumer<MyPageViewModel>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              txt_username,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size_10_h,
            ),
            TextField(
              enabled: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: size_20_h,
                  horizontal: size_20_w,
                ),
                border: _textFieldStyle,
                enabledBorder: _textFieldStyle,
                focusedBorder: _textFieldStyle,
                filled: true,
                fillColor: kColor14161E,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: text_14,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              controller: value.textNameEditingController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.multiline,
              maxLength: 50,
              maxLines: 1,
              onChanged: (text) {
                value.setEditNameIntroduction(text);
              },
            ),
            SizedBox(
              height: size_50_h,
            ),
            Text(
              txt_self_introduction,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size_10_h,
            ),
            TextField(
              enabled: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: size_20_h,
                  horizontal: size_20_w,
                ),
                border: _textFieldStyle,
                enabledBorder: _textFieldStyle,
                focusedBorder: _textFieldStyle,
                filled: true,
                fillColor: kColor14161E,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: text_14,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              controller: value.textProfileEditingController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (text) {
                value.setEditProfileIntroduction(text);
              },
            ),
            SizedBox(
              height: size_15_h,
            ),
            Text(
              txt_location,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size_10_h,
            ),
            GestureDetector(
              onTap: () {
                _cupertinoPicker(
                  context,
                  value.profileResponse?.location_list ?? [],
                  "_location",
                  value.setEditProfileDisplay,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: size_20_h,
                  horizontal: size_20_w,
                ),
                alignment: Alignment.centerLeft,
                decoration: _selectBoxStyle,
                child: Text(
                  value.editDisplayLocation?.display ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size_15_h,
            ),
            Text(
              txt_birth_day,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size_10_h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _cupertinoPicker(
                        context,
                        value.profileResponse?.birth_year_list ?? [],
                        "_birthYear",
                        value.setEditProfileDisplay,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size_20_h),
                      alignment: Alignment.center,
                      decoration: _selectBoxStyle,
                      child: Text(
                        value.editDisplayBirthYear?.display ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size_10_w,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _cupertinoPicker(
                        context,
                        value.profileResponse?.birth_month_list ?? [],
                        "_birthMonth",
                        value.setEditProfileDisplay,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size_20_h),
                      alignment: Alignment.center,
                      decoration: _selectBoxStyle,
                      child: Text(
                        value.editDisplayBirthMonth?.display ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size_10_w,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _cupertinoPicker(
                        context,
                        value.profileResponse?.birth_day_list ?? [],
                        "_birthDay",
                        value.setEditProfileDisplay,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size_20_h),
                      alignment: Alignment.center,
                      decoration: _selectBoxStyle,
                      child: Text(
                        value.editDisplayBirthDay?.display ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _cupertinoPicker(BuildContext context, List<ProfileItem> list, String target, decision) {
    int _selectedIndex = 0;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: size_300_h,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size_10_w,
                ),
                child: Row(
                  children: [
                    TextButton(
                        child: const Text('閉じる'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Spacer(),
                    TextButton(
                      child: const Text('決定'),
                      onPressed: () {
                        decision(target, list[_selectedIndex]);
                        Navigator.of(context).pop(list[_selectedIndex]);
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: CupertinoPicker(
                  looping: false,
                  itemExtent: size_40_h,
                  children: list.map((item) => new Text(item.display!)).toList(),
                  onSelectedItemChanged: (index) {
                    _selectedIndex = index;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget ProfileButton(BuildContext context) {
    return Consumer<MyPageViewModel>(
      builder: (context, value, child) {
        return Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: kColor2A313F,
                padding: EdgeInsets.all(size_10_h),
                width: double.maxFinite,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        value.introductionPostApi();
                      },
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size_10_r),
                          color: kColor426CFF,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: size_20_w, vertical: size_10_h),
                        child: Center(
                          child: Text(
                            txt_update,
                            style:
                            TextStyle(fontSize: text_14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size_5_h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.maxFinite,
                        color: transparent,
                        padding: EdgeInsets.symmetric(
                            horizontal: size_20_w, vertical: size_10_h,),
                        child: Center(
                          child: Text(
                            txt_cancel,
                            style: TextStyle(fontSize: text_14, color: Colors.grey,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
