import 'dart:io';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/chat_private_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/score_input/score_input_page.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_chat_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class ChatPrivateFooter extends StatelessWidget {
  final int tournamentId;
  final int tournamentRoundId;
  final String? roundBoxStr;
  final int? organizerUserId;
  final int myUserId;
  final bool? isScorePostBtnAvailable;
  final String? organizerThumbUrl;
  final List<String>? messages;

  ChatPrivateFooter({
    Key? key,
    required this.tournamentId,
    required this.tournamentRoundId,
    required this.roundBoxStr,
    required this.organizerUserId,
    required this.myUserId,
    required this.isScorePostBtnAvailable,
    required this.organizerThumbUrl,
    required this.messages,
  }) : super(key: key);

  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: kColor2c2f3e, width: 0),
    borderRadius: BorderRadius.circular(size_24_r),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatPrivateViewModel>(builder: (context, value, child) {
      return GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Visibility(
              visible: this.messages?.length != 0 && value.isKeyboardFocus,
              child: _suggestChat(this.messages),
            ),
            Container(
              color: kColor212430,
              padding: EdgeInsets.symmetric(
                horizontal: size_10_w,
                vertical: size_10_h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Visibility(
                        visible: (this.organizerUserId != this.myUserId),
                        child: GestureDetector(
                          onTap: () {
                            value.changeIsOrganizerCall();
                          },
                          child: Container(
                            height: size_40_h,
                            padding: EdgeInsets.only(
                              left: size_5_w,
                              right: size_15_w,
                            ),
                            decoration: BoxDecoration(
                              color: value.isOrganizerCall
                                  ? kColorF0485D
                                  : kColor373C4A,
                              borderRadius: BorderRadius.circular(size_20_r),
                            ),
                            child: Row(
                              children: [
                                PlayerThumb(
                                  playerThumbUrl: this.organizerThumbUrl ?? null,
                                  size: size_24_w,
                                  placeholderImage: 'asset/images/ic_default_avatar.png',
                                ),
                                SizedBox(width: size_5_w,),
                                Text(
                                  txt_organizer_call,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: text_12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: this.organizerUserId != this.myUserId ? size_10_w : 0.0,),
                      GestureDetector(
                        onTap: () {
                          if (this.isScorePostBtnAvailable == true) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ScoreInputPage(
                                  tournamentRoundId: this.tournamentRoundId,
                                  title: this.roundBoxStr!,
                                  tournamentId: this.tournamentId,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: size_40_h,
                          padding: EdgeInsets.symmetric(horizontal: size_15_w,),
                          decoration: BoxDecoration(
                            color: this.isScorePostBtnAvailable == true ? kColor373C4A : kColor727272,
                            borderRadius: BorderRadius.circular(size_20_r),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: SvgPicture.asset(
                                  'asset/icons/icon_score.svg',
                                  width: size_16_h,
                                  height: size_16_h,
                                ),
                              ),
                              SizedBox(width: size_5_w,),
                              Text(
                                txt_report_input_score,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: text_12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size_10_h,),
                  (value.image != null) ? Container(
                    padding: EdgeInsets.only(bottom: size_10_h,),
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
                        Image.file(
                          value.image,
                          height: size_100_h,
                          width: size_100_w,
                        ),
                      ],
                    ),
                  ) : Container(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          child: TextField(
                            onChanged: (txt) {
                              value.postDataTyping(this.tournamentRoundId);
                            },
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 3,
                            controller: value.privateChatController,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: text_16,
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
                              hintStyle: TextStyle(color: kColoraaaaaa),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: size_5_h,),
                        child: Row(
                          children: [
                            SizedBox(
                              width: value.isKeyboardFocus ? size_10_w : 0.0,
                            ),
                            Visibility(
                              visible: value.isKeyboardFocus,
                              child: FooterIconButton(
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
                            ),
                            SizedBox(
                              width: size_10_w,
                            ),
                            FooterIconButton(
                              iconImage: 'asset/icons/ic_send.svg',
                              size: size_20_w,
                              onTap: () async {
                                await value.privateChatPostSocket(
                                  value.privateChatController.text,
                                  this.tournamentRoundId,
                                  this.tournamentId,
                                );
                                value.updateUIChat();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _suggestChat(List<String>? messages) {
    return Consumer<ChatPrivateViewModel>(builder: (context, value, child) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: size_10_h, horizontal: size_10_w,
        ),
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
                itemBuilder: (context, index) =>
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size_2_w,),
                      child: InkWell(
                        onTap: () {
                          Text txt = Text(messages?[index] ?? '');
                          value.setText(txt.data.toString());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size_10_r,),
                            color: kColor2c2f3e,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: size_10_w, vertical: size_6_h,),
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
            ),
          ],
        ),
      );
    });
  }
}