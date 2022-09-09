import 'dart:async';
import 'dart:io';

import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/bot_help_bottom_sheet.dart';
import 'package:Gametector/app/view/component/bottom_sheet/manage_participants_bottom_sheet.dart';
import 'package:Gametector/app/view/component/bottom_sheet/voice_chat_bottom_sheet.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_chat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TournamentChatFooter extends StatefulWidget {
  List<String>? fixedMessages;
  int tournamentId;
  TournamentChatViewModel tournamentChatViewModel;
  bool isEvent;

  TournamentChatFooter({
    Key? key,
    required this.tournamentChatViewModel,
    required this.fixedMessages,
    required this.tournamentId,
    required this.isEvent,
  }) : super(key: key);

  @override
  State<TournamentChatFooter> createState() => _TournamentChatFooterState();
}

class _TournamentChatFooterState extends State<TournamentChatFooter> with SingleTickerProviderStateMixin {
  TextEditingController chatTextController = TextEditingController();
  TournamentChatViewModel get tournamentChatViewModel => widget.tournamentChatViewModel;

  bool isFocus = false;
  KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  late AnimationController _animationController;
  late Animation<double> animation_1;
  late Animation<double> animation_2;
  late Animation<double> animation_3;
  late StreamSubscription<bool> keyboardSubscription;

  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(size_24_r),
    borderSide: BorderSide(
      color: kColor2c2f3e,
      width: 0,
    ),
  );

  @override
  void initState() {
    chatTextController = TextEditingController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) => onKeyboardVisibilityChanged(visible));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: false);

    animation_1 = _animationController.drive(
      Tween<double>(
        begin: 0.5,
        end: 1.5,
      ),
    );

    animation_2 = _animationController.drive(
      Tween<double>(
        begin: 0.5,
        end: 1.0,
      ),
    );

    animation_3 = _animationController.drive(
      Tween<double>(
        begin: 1.0,
        end: 0.0,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    chatTextController.dispose();
    keyboardSubscription.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void onKeyboardVisibilityChanged(bool visible) {
    setState(() {
      isFocus = visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentChatViewModel>(builder: (context, value, child) {
      return GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // fixedMessages
            Visibility(
              visible: widget.fixedMessages?.length != 0 && isFocus,
              child: _suggestChat(widget.fixedMessages),
            ),
            // image thumbnail
            Visibility(
              visible: (value.image != null),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      value.setImage(null);
                    },
                    child: SvgPicture.asset(
                      'asset/icons/ic_x.svg',
                      height: size_15_w,
                      width: size_15_w,
                    ),
                  ),
                  (value.image != null)
                      ? Image.file(
                          value.image!,
                          height: size_100_h,
                          width: size_100_w,
                        )
                      : Container(),
                ],
              ),
            ),
            Visibility(
              visible: (isFocus == true && value.tournamentInfo!.organizer_user_id == value.myUserId),
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(right: size_50_h),
                child: value.isAnnounce == false
                    ? Image.asset(
                        'asset/images/balloon_broadcast_off.png',
                        height: size_22_h,
                        width: size_100_w,
                      )
                    : Image.asset(
                        'asset/images/balloon_broadcast_on.png',
                        height: size_22_h,
                        width: size_100_w,
                      ),
                ),
            ),
            // Footer
            Container(
              padding: EdgeInsets.only(
                top: isFocus == false ? size_10_h : 0,
                left: size_10_w,
                right: size_10_w,
                bottom: size_10_h,
              ),
              width: MediaQuery.of(context).size.width,
              color: kColor212430,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isFocus == false,
                    child: Container(
                      width: size_120_w,
                      child: Stack(
                        children: [
                          // voice chat
                          FooterIconButton(
                            iconImage: 'asset/icons/ic_voice_chat.svg',
                            size: size_30_w,
                            onTap: () {
                              voiceChatBottomSheet(
                                url: value.responseChatList?.parallel_url,
                              );
                            },
                          ),
                          // focus animation1
                          Visibility(
                            visible: widget.isEvent,
                            child: Positioned(
                              left: size_40_w,
                              child: ScaleTransition(
                                scale: animation_1,
                                child: FadeTransition(
                                  opacity:animation_3,
                                  child: Container(
                                    height: size_36_w,
                                    width: size_36_w,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.isEvent,
                            child: Positioned(
                              left: size_40_w,
                              child: ScaleTransition(
                                scale: animation_2,
                                child: FadeTransition(
                                  opacity: animation_3,
                                  child: Container(
                                    height: size_36_w,
                                    width: size_36_w,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // bot
                          Positioned(
                            left: size_40_w,
                            child: FooterIconButton(
                              iconImage: 'asset/icons/ic_bot.svg',
                              size: size_30_w,
                              onTap: () {
                                botHelpBottomSheet(
                                  url: value.responseChatList?.bot_url,
                                  tournamentId: widget.tournamentId,
                                );
                              },
                            ),
                          ),
                          // member_management
                          Positioned(
                            left: size_80_w,
                            child: FooterIconButton(
                              iconImage: 'asset/icons/ic_group_member.svg',
                              size: size_30_w,
                              onTap: () {
                                manageParticipantsBottomSheet(
                                  tournamentId: value.tournamentId,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // text area
                  Expanded(
                    child: Stack(
                      children: [
                        TextField(
                          onChanged: (txt) {
                            value.postDataTyping(widget.tournamentId);
                          },
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: isFocus == true ? 3 : 1,
                          controller: chatTextController,
                          // focusNode: node,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: text_18,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: size_20_w,
                              vertical: size_6_h,
                            ),
                            border: _outlineInputBorder,
                            enabledBorder: _outlineInputBorder,
                            focusedBorder: _outlineInputBorder,
                            filled: true,
                            fillColor: kColor2c2f3e,
                            hintText: txt_enter_comment,
                            hintStyle: TextStyle(color: kColoraaaaaa,),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                        Visibility(
                          visible: (isFocus == true && value.tournamentInfo!.organizer_user_id == value.myUserId),
                          child: Positioned(
                            right: size_3_h,
                            bottom: size_3_h,
                            child: GestureDetector(
                              onTap: () {
                                value.changeIsAnnounce();
                              },
                              child: SvgPicture.asset(
                                value.isAnnounce == false
                                    ? 'asset/icons/ic_broadcast_off.svg'
                                    : 'asset/icons/ic_broadcast_on.svg',
                                height: size_30_w,
                                width: size_30_w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // photo
                  Visibility(
                    visible: isFocus == true,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: size_5_h,),
                      child: Row(
                        children: [
                          SizedBox(width: size_10_w,),
                          // select image
                          FooterIconButton(
                            iconImage: 'asset/icons/icon_photo.svg',
                            size: size_20_w,
                            onTap: () async {
                              try {
                                final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if (image == null) return;
                                value.setImage(File(image.path));
                              } on PlatformException catch (e) {
                                print('pick failed $e !!');
                              }
                            },
                          ),
                          SizedBox(width: size_10_w,),
                          //send msg
                          FooterIconButton(
                            iconImage: 'asset/icons/ic_send.svg',
                            size: size_20_w,
                            onTap: () async {
                              //send msg
                              await value.chatPostSocket(
                                chatTextController.text,
                                widget.tournamentId,
                              );
                              updateUIChat();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void updateUIChat() {
    FocusManager.instance.primaryFocus?.unfocus();
    chatTextController.clear();
  }

  Widget _suggestChat(List<String>? messages) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size_10_h, horizontal: size_10_w,),
      color: kColor4D000000,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'asset/icons/ic_chat_suggest.svg',
                width: size_20_w,
                height: size_14_h,
              ),
              SizedBox(width: size_5_w,),
              Text(
                txt_suggest_chat,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_11,
                ),
              ),
            ],
          ),
          Container(
            height: size_40_h,
            width: double.infinity,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: messages?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(horizontal: size_2_w,),
                child: InkWell(
                  onTap: () {
                    Text txt = Text(messages?[index] ?? '');
                    var value = txt.data;
                    setState(() {
                      chatTextController.text = chatTextController.text + value.toString();
                      chatTextController.selection = TextSelection.fromPosition(TextPosition(offset: chatTextController.text.length));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size_10_r,),
                      color: kColor2c2f3e,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: size_10_w, vertical: size_6_h,),
                    child: Text(
                      messages?[index] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: text_14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FooterIconButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? iconImage;
  final double? size;

  const FooterIconButton({
    Key? key,
    required this.onTap,
    required this.iconImage,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: this.onTap,
        child: Padding(
          padding: EdgeInsets.all(size_3_w,),
          child: SvgPicture.asset(
            this.iconImage!,
            width: this.size,
            height: this.size,
          ),
        ),
      ),
    );
  }
}
