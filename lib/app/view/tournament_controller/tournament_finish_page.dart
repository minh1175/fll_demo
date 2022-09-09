import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class TournamentFinishPage extends PageProvideNode<TournamentControllerViewModel> {
  final int tournamentId;
  final int competitionType;

  TournamentFinishPage({
    Key? key,
    required this.tournamentId,
    this.competitionType = 0,
  }) : super(key: key, params: [tournamentId, competitionType]);

  @override
  Widget buildContent(BuildContext context) {
    return _TournamentFinishPage(
      viewModel,
      tournamentId: this.tournamentId,
      competitionType: this.competitionType,
      key: key,
    );
  }
}

class _TournamentFinishPage extends StatefulWidget {
  final int tournamentId;
  final int competitionType;
  final TournamentControllerViewModel _tournamentControllerViewModel;

  const _TournamentFinishPage(this._tournamentControllerViewModel, {
    Key? key,
    required this.tournamentId,
    required this.competitionType,
  }) : super(key: key);

  @override
  __TournamentFinishPageState createState() => __TournamentFinishPageState();
}

class __TournamentFinishPageState extends State<_TournamentFinishPage> {
  int progressStatus = 1;
  final List<String> medalImage = ['', 'asset/icons/icon_medal1.svg', 'asset/icons/icon_medal2.svg', 'asset/icons/icon_medal3.svg'];
  TournamentControllerViewModel get tournamentControllerViewModel => widget._tournamentControllerViewModel;
  final textController = TextEditingController();

  @override
  void initState() {
    progressStatus = widget.competitionType == 99 ? 2 : 1;
    tournamentControllerViewModel.rankListApi(widget.tournamentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColor202330,
      child: SafeArea(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: size_50_h,
              elevation: 0,
              backgroundColor: kColor202330,
              leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(size_10_h),
                  child: SvgPicture.asset(
                    'asset/icons/ic_close.svg',
                    height: size_24_h,
                    width: size_24_h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              title: Text(
                widget.competitionType == 99 ? "イベントを終了しましょう" : "大会を終了しましょう",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_14,
                ),
              ),
            ),
            body: Container(
              width: double.infinity,
              color: kColorFF2A2E43,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: progressStatus * MediaQuery.of(context).size.width / 3,
                    height: size_5_h,
                    color: Colors.blue,
                  ),
                  Expanded(
                    child: (() {
                      switch(progressStatus) {
                        case 1:
                          return _PlayerRank();
                        case 2:
                          return _InputComment();
                        case 3:
                          return _Complete();
                        default:
                          return Container();
                      }
                    })(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _Complete() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: size_30_h, horizontal: size_30_w,),
      child: Column(
        children: [
          Text(
            widget.competitionType == 99 ? "イベントの運営お疲れ様でした" : "大会の運営お疲れ様でした",
            style: TextStyle(
              color: Colors.white,
              fontSize: text_16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size_30_h,),
          Text(
            widget.competitionType == 99
                ? "イベントを終了すると情報の編集はできません。\nまだイベントの熱が冷めない内に結果のツイートをしましょう。"
                : "大会を終了すると情報の編集はできません。\nまだ試合の熱が冷めない内に賞金/賞品の授与、大会結果のツイートをしましょう。",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: text_14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                tournamentControllerViewModel.tournamentFinishApi(widget.tournamentId, textController.text);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(size_50_r),
              ),
              padding: EdgeInsets.symmetric(vertical: size_10_h,),
              width: size_150_w,
              child: Text(
                txt_ok,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _InputComment() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: size_30_h, horizontal: size_30_w,),
      child: Column(
        children: [
          Text(
            "参加者の皆さんへコメントしましょう",
            style: TextStyle(
              color: Colors.white,
              fontSize: text_14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size_30_h,),
          TextField(
            controller: textController,
            maxLines: null,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              hintText: 'コメントを入力してください。',
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                progressStatus = 3;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(size_50_r),
              ),
              padding: EdgeInsets.symmetric(vertical: size_10_h,),
              width: size_150_w,
              child: Text(
                txt_ok,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_14,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _PlayerRank() {
    return Consumer<TournamentControllerViewModel>(builder: (context, value, child) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: size_30_h, horizontal: size_10_w,),
        child: Column(
          children: [
            Text(
              "順位を確認しましょう",
              style: TextStyle(
                color: Colors.white,
                fontSize: text_14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size_30_h,),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey,),
                ),
              ),
              child: ListTile(
                leading: Text(
                  "順位",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: text_12,
                  ),
                ),
                title: Text(
                  "選手",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: text_12,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: value.responseTournamentRankList?.ranking_list?.length?? 0,
                itemBuilder: (ctx, index) {
                  var e = value.responseTournamentRankList!.ranking_list![index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey,),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: size_5_h, horizontal: size_5_w,),
                      leading: Container(
                        width: size_50_w,
                        child: e.rank! <= 3 ? SvgPicture.asset(
                          medalImage[e.rank!],
                          height: size_40_h,
                          width: size_40_h,
                          fit: BoxFit.scaleDown,
                        ) : Text(
                          '#'+(e.rank!).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: text_14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          PlayerThumb(
                            playerThumbUrl: e.thumb_url!,
                            size: size_32_w,
                            placeholderImage: 'asset/images/ic_default_avatar.png',
                          ),
                          SizedBox(width: size_20_w,),
                          Expanded(
                            child: Text(
                              e.player_name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: text_14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
            SizedBox(height: size_10_h,),
            GestureDetector(
              onTap: () {
                setState(() {
                  progressStatus = 2;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(size_50_r),
                ),
                padding: EdgeInsets.symmetric(vertical: size_10_h,),
                width: size_150_w,
                child: Text(
                  txt_ok,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: text_14,
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
