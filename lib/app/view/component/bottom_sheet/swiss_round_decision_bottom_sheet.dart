import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/bottom_sheet_container.dart';
import 'package:Gametector/app/view/component/common/player_thumb.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_board_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

void SwissRoundDecisionBottomSheet({String? message, required int tournamentId, required bool isAllRoundFinish}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: transparent,
    context: context,
    builder: (BuildContext builderContext) {
      return FractionallySizedBox(
        heightFactor: 0.90,
        child: AtheletesPage(
          defaultAction: defaultAction,
          tournamentId: tournamentId,
          isAllRoundFinish: isAllRoundFinish,
        ),
      );
    },
  );
}

class AtheletesPage extends PageProvideNode<MatchBoardViewModel> {
  final VoidCallback? defaultAction;
  final int tournamentId;
  final bool isAllRoundFinish;

  AtheletesPage({
    Key? key,
    this.defaultAction,
    required this.tournamentId,
    required this.isAllRoundFinish,
  }) : super(key: key, params: [tournamentId]);

  @override
  Widget buildContent(BuildContext context) {
    return AtheletesBottomSheet(
      viewModel,
      key: key,
      defaultAction: this.defaultAction,
      tournamentId: this.tournamentId,
      isAllRoundFinish: this.isAllRoundFinish,
    );
  }
}

class AtheletesBottomSheet extends StatefulWidget {
  final VoidCallback? defaultAction;
  final int tournamentId;
  final MatchBoardViewModel _matchBoardViewModel;
  final bool isAllRoundFinish;

  const AtheletesBottomSheet(this._matchBoardViewModel, {
    Key? key,
    this.defaultAction,
    required this.tournamentId,
    required this.isAllRoundFinish,
  }) : super(key: key);

  @override
  _AtheletesBottomSheetState createState() => _AtheletesBottomSheetState();
}

class _AtheletesBottomSheetState extends State<AtheletesBottomSheet> {
  @override
  void initState() {
    widget._matchBoardViewModel.athletesParticipantsApi(widget.tournamentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchBoardViewModel>(builder: (context, value, child) {
      return BottomSheetContainer(
        child: value.athletesAbstrainResponse != null ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size_20_w, vertical: size_20_h,),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        sprintf(txt_players_participate, [widget._matchBoardViewModel.getNonRetirePlayerNum()]),
                        style: TextStyle(color: Colors.white, fontSize: text_14,),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (widget.isAllRoundFinish) {
                            showAlertGTDialog(message: txt_disable_action_finished);
                          } else {
                            // TODO : move into common component (endTournamentBottomSheet also use this widget)
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return AlertDialog(
                                  title: null,
                                  content: Text(txt_confirm_end_tournament),
                                  actions: [
                                    TextButton(
                                      child: Text(txt_cancel),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                        child: Text(txt_ok),
                                        onPressed: () {
                                          widget._matchBoardViewModel.retirePlayerApi(widget.tournamentId);
                                        }
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: size_6_h,
                            horizontal: size_10_w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size_5_r,),
                            color: kColor247EF1,
                          ),
                          child: Text(
                            txt_decision,
                            style: TextStyle(color: Colors.white, fontSize: text_12,),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size_20_h,),
                  Text(
                    value.athletesAbstrainResponse?.explain?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: size_1_h,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size_20_w, vertical: size_20_h,),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: value.athletesAbstrainResponse?.player_list?.length,
                    itemBuilder: ((context, index) {
                      var item = value.athletesAbstrainResponse?.player_list?[index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        leading: PlayerThumb(
                          playerThumbUrl: item?.thumb_url,
                          size: size_40_w,
                          placeholderImage: 'asset/images/ic_default_avatar.png',
                        ),
                        title: Text(
                          item?.player_name ?? '',
                          style: TextStyle(color: Colors.white, fontSize: text_14,),
                        ),
                        trailing: SizedBox(
                          height: size_20_w,
                          width: size_20_w,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.blue,
                            ),
                            child: Radio(
                              value: 0,
                              groupValue: item!.flg_retire,
                              toggleable: true,
                              activeColor: Colors.blue,
                              onChanged: (int? v) {
                                setState(() {
                                  item.flg_retire = (item.flg_retire == 1) ? 0 : 1;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ) : Container(),
      );
    });
  }
}
