import 'dart:convert';
import 'dart:io';
import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/response/score_info_response.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/result_input_history.dart';
import 'package:Gametector/app/view/component/bottom_sheet/show_chat_image_bottom_sheet.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/component/dialog/accept_score_input_dialog.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:Gametector/app/view/component/dialog/suggest_finish_tournament_dialog.dart';
import 'package:Gametector/app/view/tournament_controller/score_input/score_input_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScoreInputPage extends PageProvideNode<ScoreInputViewModel> {
  final int tournamentId;
  final int tournamentRoundId;
  final String title;

  ScoreInputPage({
    Key? key,
    required this.tournamentId,
    required this.tournamentRoundId,
    required this.title,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return _ScoreInputContent(
      viewModel,
      tournamentId: this.tournamentId,
      tournamentRoundId: this.tournamentRoundId,
      title: this.title,
      key: key,
    );
  }
}

class _ScoreInputContent extends StatefulWidget {
  final ScoreInputViewModel _scoreInputViewModel;
  final int tournamentId;
  final int tournamentRoundId;
  final String title;

  const _ScoreInputContent(this._scoreInputViewModel, {
    Key? key,
    required this.tournamentId,
    required this.tournamentRoundId,
    required this.title,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScoreInputContentState();
}

class _ScoreInputContentState extends State<_ScoreInputContent>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ScoreInputViewModel get scoreInputViewModel => widget._scoreInputViewModel;
  NavigationService _navigationService = getIt<NavigationService>();
  late WebViewController _controller;
  final String _appToken = getIt<UserSharePref>().getAppToken();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    scoreInputViewModel.tournamentInfoApi(widget.tournamentId);
    scoreInputViewModel.scoreInfoAPI(widget.tournamentRoundId);
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  void dispose() {
    super.dispose();
    print ("************** scoreInputViewModel.dispose ******************");
    scoreInputViewModel.dispose();
  }

  TextStyle _textStylePlayerName = TextStyle(
    color: Colors.white,
    fontSize: text_10,
    fontWeight: FontWeight.bold,
  );

  TextStyle _textStyleTitle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: text_14,
  );

  TextStyle _textStyleDescription = TextStyle(
    color: Colors.white,
    fontSize: text_9,
  );

  TextStyle _textStyleDefaultScore = TextStyle(
    color: Colors.white,
    fontSize: text_10,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreInputViewModel>(
      builder: (context, value, child) {
        return Container(
          color: kColor202330,
          child: SafeArea(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Scaffold(
                backgroundColor: kColor202330,
                body: DefaultTabController(
                  length: value.lsItem.length,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: size_5_h,
                          bottom: size_5_h,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.all(size_10_w),
                                child: SvgPicture.asset(
                                  'asset/icons/ic_close.svg',
                                  height: size_24_w,
                                  width: size_24_w,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            SizedBox(width: size_10_w,),
                            Text(
                              widget.title,
                              style: TextStyle(color: Colors.white, fontSize: text_15),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                resultInputHistoryBottomSheet(value.responseScoreInfo?.score_history_url ?? '');
                              },
                              child: Container(
                                padding: EdgeInsets.all(size_10_w),
                                child: Text(
                                  txt_registration_history,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: text_14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.01,
                        child: value.responseTournamentInfo?.tournament_info?.competition_type! != 1
                            ? null
                            : WebView(
                                initialUrl: URL_ORGANIZER_POST_SCORE.replaceAll('{tournamentId}', widget.tournamentId.toString())+'?app_token=$_appToken',
                                javascriptMode: JavascriptMode.unrestricted,
                                onWebViewCreated: (WebViewController controller) {
                                  _controller = controller;
                                },
                                javascriptChannels: Set.from([
                                  JavascriptChannel(
                                    name: "postComplete",
                                    onMessageReceived: (JavascriptMessage result) {
                                      Map resultJson = json.decode(result.message);
                                      print (resultJson);
                                      if (resultJson["success"]) {
                                        eventBus.fire(PushUpdateMatchBoardEvent(widget.tournamentId));
                                        Navigator.pop(context);
                                        if (scoreInputViewModel.isOrganizer() && resultJson["is_all_round_finish"] == true) {
                                          suggestFinishTournamentDialog(widget.tournamentId, );
                                        } else {
                                          acceptScoreInputDialog();
                                        }
                                      } else {
                                        _navigationService.gotoErrorPage();
                                      }
                                    },
                                  ),
                                ]),
                              ),
                      ),
                      Container(
                        color: kColor202330,
                        width: double.maxFinite,
                        child: TabBar(
                          isScrollable: true,
                          labelPadding: EdgeInsets.all(size_6_w),
                          indicatorColor: Colors.white,
                          indicatorPadding: EdgeInsets.only(top: size_4_h),
                          padding: EdgeInsets.symmetric(horizontal: size_5_w),
                          unselectedLabelColor: kColor5b5e65,
                          labelStyle: TextStyle(color: Colors.white, fontSize: text_11),
                          tabs: value.lsItem.map((e) => Container(
                            width: size_50_h,
                            child: Column(
                              children: [
                                Text(txt_winner,),
                                SizedBox(height: size_5_h,),
                                PlayerThumb(
                                  playerThumbUrl: e.winner_thumb_url ?? null,
                                  size: size_16_w,
                                  placeholderImage: 'asset/images/ic_default_avatar.png',
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                      ),
                      Container(
                        color: kColor33353F,
                        height: size_1_h,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: value.lsItem.map((e) {
                            return Container(
                              decoration: BoxDecoration(color: kColor202330),
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                      left: size_10_w,
                                      right: size_10_w,
                                      bottom: size_80_h,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: size_40_h,),
                                          child: Text(
                                            e.explain ?? '',
                                            style: TextStyle(
                                              fontSize: text_12,
                                              color: kWhiteAlpha,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            _playerDetails(e),
                                            SizedBox(height: size_2_h,),
                                            _scoreCount(e, value.responseScoreInfo!.score_title!),
                                            SizedBox(height: size_2_h,),
                                            value.responseScoreInfo!.game_type! == 2
                                                ? _optionScoreCount(e, value.responseScoreInfo!.option_score_title!, value.responseScoreInfo!.option_score_explain!)
                                                : Container(),
                                            SizedBox(height: size_2_h,),
                                            _scoreResultImage(
                                              context,
                                              e,
                                              value.isOrganizer(),
                                            ),
                                            SizedBox(height: size_2_h,),
                                            _defaultCount(e),
                                            // CustomRadioButton?
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: IgnorePointer(
                                      ignoring: e.flg_enable != 1 ? true : false,
                                      child: GestureDetector(
                                        onTap: () {
                                          var params = scoreInputViewModel.getTournamentScoreInputParam(e.battle_no!);
                                          // Draw is not allowed in tournament.
                                          if (value.responseTournamentInfo?.tournament_info?.competition_type! == 1 && params[3] == "7") {
                                            showAlertGTDialog(message: "トーナメント形式では引き分けでの登録はできません。");
                                            return;
                                          }

                                          // POST score
                                          if (value.responseTournamentInfo?.tournament_info?.competition_type! == 1 && value.isOrganizer()) {
                                            var paramsStr = params.map<String>((value) => value.toString()).join(',');
                                            _controller.runJavascript("postScoreForFlutter("+paramsStr+");");
                                          } else {
                                            scoreInputViewModel.scorePostApi(e.battle_no!, _imageFile);
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(vertical: size_20_h,),
                                          color: e.flg_enable != 1 ? Colors.grey : kColor426CFF,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'asset/icons/icon_score.svg',
                                                height: size_20_h,
                                                width: size_20_h,
                                              ),
                                              SizedBox(width: size_10_w,),
                                              Text(
                                                txt_post,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: text_11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()),
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

  Widget _playerDetails(ScoreItem e) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size_30_h),
      color: kColor2b2e3e,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlayerThumb(
                  playerThumbUrl: e.player_thumb_left ?? null,
                  size: size_45_w,
                  placeholderImage: 'asset/images/ic_default_avatar.png',
                ),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size_10_w,),
                  child: Text(
                    e.player_name_left ?? '',
                    style: _textStylePlayerName,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlayerThumb(
                  playerThumbUrl: e.player_thumb_right ?? null,
                  size: size_45_w,
                  placeholderImage: 'asset/images/ic_default_avatar.png',
                ),
                SizedBox(height: 5,),
                Text(
                  e.player_name_right ?? '',
                  style: _textStylePlayerName,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scoreButton(bool isUp, bool isLeft, int battleNo, bool isOptionScore) {
    return InkWell(
      onTap: () {
        if (isOptionScore ) {
          scoreInputViewModel.changeOptionScoreValue(isUp, isLeft, battleNo);
        } else {
          scoreInputViewModel.changeScoreValue(isUp, isLeft, battleNo);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size_10_w),
        child: Text(
          isUp ? '+' : '-',
          style: TextStyle(
            color: Colors.white,
            fontSize: text_30,
          ),
        ),
      ),
    );
  }

  Widget _scoreDisplay(int val) {
    return Container(
      alignment: Alignment.center,
      height: size_40_h,
      width: size_80_w,
      color: kColor212430,
      child: Text(
        val.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: text_20,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.visible,
      ),
    );
  }

  Widget _scoreCount(ScoreItem e, String title) {
    return IgnorePointer(
      ignoring: e.flg_enable == 1 && e.win_lose_type_left != '3' && e.win_lose_type_left != '4' ? false : true,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size_30_h),
        color: kColor2b2e3e,
        child: Opacity(
          opacity: e.flg_enable == 1 && e.win_lose_type_left != '3' && e.win_lose_type_left != '4' ? 1.0 : 0.5,
          child: Column(
            children: [
              Text(
                title,
                style: _textStyleTitle,
              ),
              SizedBox(height: size_20_h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _scoreButton(false, true, e.battle_no!, false),
                        _scoreDisplay(e.score_left!),
                        _scoreButton(true, true, e.battle_no!, false),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _scoreButton(false, false, e.battle_no!, false),
                        _scoreDisplay(e.score_right!),
                        _scoreButton(true, false, e.battle_no!, false),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionScoreCount(ScoreItem e, String title, String explain) {
    return IgnorePointer(
      ignoring: (e.flg_enable == 1) && (e.score_left == e.score_right) && e.win_lose_type_left != '3' && e.win_lose_type_left != '4' ? false : true,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size_30_h),
        color: kColor2b2e3e,
        child: Opacity(
          opacity: (e.flg_enable == 1) && (e.score_left == e.score_right) && e.win_lose_type_left != '3' && e.win_lose_type_left != '4' ? 1.0 : 0.5,
          child: Column(
            children: [
              Text(
                title,
                style: _textStyleTitle,
              ),
              SizedBox(height: size_10_h),
              Text(
                explain,
                style: _textStyleDescription,
              ),
              SizedBox(height: size_20_h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _scoreButton(false, true, e.battle_no!, true),
                        _scoreDisplay(e.pk_score_left!),
                        _scoreButton(true, true, e.battle_no!, true),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _scoreButton(false, false, e.battle_no!, true),
                        _scoreDisplay(e.pk_score_right!),
                        _scoreButton(true, false, e.battle_no!, true),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(battleNo) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    scoreInputViewModel.setImage(pickedFile!.path, battleNo);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget _scoreResultImage(BuildContext context, ScoreItem e, bool isOrganizer) {
    bool flgEnable = !(isOrganizer && (e.flg_enable == 1));
    return Container(
      padding: EdgeInsets.symmetric(vertical: size_30_h),
      width: double.maxFinite,
      color: kColor2b2e3e,
      child: Container(
        child: (e.win_certification_url == "" || e.win_certification_url == null)
            ? IgnorePointer(
              ignoring: flgEnable ? false : true,
              child: Opacity(
                opacity: flgEnable ? 1.0 : 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      txt_attach_proof_photo,
                      style: _textStyleDescription,
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickImage(e.battle_no);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: size_20_h, horizontal: size_20_w,),
                        child: SvgPicture.asset(
                          'asset/icons/icon_photo.svg',
                          height: size_40_h,
                          width: size_40_h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            : Align(
              alignment: Alignment.center,
              child: Container(
                width: size_100_w+size_30_h,
                height: size_180_h,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: size_15_h),
                      child: Container(
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: size_5_h, horizontal: size_5_w),
                        width: size_100_w,
                        height: size_150_h,
                        child: GestureDetector(
                          onTap: () {
                            showImageChatBottomSheet(e.win_certification_url!, type: (_imageFile == null) ? 1 : 2,);
                          },
                          child: _imageFile == null
                              ? Image.network(e.win_certification_url!)
                              : Image.file(File(e.win_certification_url!),),
                        ),
                      ),
                    ),
                    isOrganizer
                        ? Container()
                        : Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              scoreInputViewModel.setImage(null, e.battle_no!);
                              setState(() {
                                _imageFile = null;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(size_50_r),
                              ),
                              width: size_30_h,
                              height: size_30_h,
                              child: SvgPicture.asset(
                                'asset/icons/ic_close.svg',
                                height: size_24_h,
                                width: size_24_h,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Widget _defaultCount(ScoreItem e) {
    return IgnorePointer(
      ignoring: e.flg_enable == 1 ? false : true,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size_30_h),
        width: double.maxFinite,
        color: kColor2b2e3e,
        child: Opacity(
          opacity: e.flg_enable == 1 ? 1.0 : 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                txt_win_by_default,
                style: _textStyleTitle,
              ),
              SizedBox(height: size_10_h),
              Text(
                txt_the_entered_score_will_not_be_reflected,
                style: _textStyleDescription,
              ),
              SizedBox(height: size_30_h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size_30_w,),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          scoreInputViewModel.chagneDefaultScoreValue(1, e.battle_no!);
                        },
                        child: Container(
                          height: size_40_h,
                          decoration: BoxDecoration(
                            color: e.win_lose_type_left == "3" ? Colors.grey : kColor202330,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size_20_r),
                              bottomLeft: Radius.circular(size_20_r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              PlayerThumb(
                                playerThumbUrl: e.player_thumb_left ?? null,
                                size: size_28_w,
                                placeholderImage: 'asset/images/ic_default_avatar.png',
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    txt_win_by_default,
                                    style: _textStyleDefaultScore,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          scoreInputViewModel.chagneDefaultScoreValue(2, e.battle_no!);
                        },
                        child: Container(
                          height: size_40_h,
                          alignment: Alignment.center,
                          color: e.win_lose_type_left == "4" && e.win_lose_type_right == "4" ? Colors.grey : kColor202330,
                          child: Text(
                            txt_loser_both,
                            style: _textStyleDefaultScore,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          scoreInputViewModel.chagneDefaultScoreValue(3, e.battle_no!);
                        },
                        child: Container(
                          height: size_40_h,
                          decoration: BoxDecoration(
                            color: e.win_lose_type_right == "3" ? Colors.grey : kColor202330,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size_20_r),
                              bottomRight: Radius.circular(size_20_r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    txt_win_by_default,
                                    style: _textStyleDefaultScore,
                                  ),
                                ),
                              ),
                              PlayerThumb(
                                playerThumbUrl: e.player_thumb_right ?? null,
                                size: size_28_w,
                                placeholderImage: 'asset/images/ic_default_avatar.png',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              SizedBox(height: size_20_h),
              GestureDetector(
                onTap: (){
                  scoreInputViewModel.chagneDefaultScoreValue(4, e.battle_no!);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: size_10_h,),
                  width: size_150_w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: (e.win_lose_type_left != "3" && e.win_lose_type_left != "4") ? kColor2b2e3e : kColor202330,
                    borderRadius: BorderRadius.circular(size_50_r),
                  ),
                  child: Text(
                    txt_cancel_win_by_default,
                    style: TextStyle(color: kWhiteAlpha, fontSize: text_11,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
