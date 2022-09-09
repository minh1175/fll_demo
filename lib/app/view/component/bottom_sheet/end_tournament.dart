import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/common/bottom_sheet_container.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';

void endTournamentBottomSheet({required int tournamentId}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: transparent,
      builder: (BuildContext builderContext) {
        return FractionallySizedBox(
          heightFactor: 0.90,
          child: EndTournamentPage(
            defaultAction: defaultAction,
            tournamentId: tournamentId,
          ),
        );
      });
}

class EndTournamentPage extends PageProvideNode<TournamentControllerViewModel> {
  final int tournamentId;
  VoidCallback? defaultAction;

  EndTournamentPage({
    Key? key,
    this.defaultAction,
    required this.tournamentId
  }) : super(key: key, params: [tournamentId]);

  @override
  Widget buildContent(BuildContext context) {
    return EndTournamentBottomSheet(
      viewModel,
      key: key,
      tournamentId: tournamentId,
    );
  }
}

class EndTournamentBottomSheet extends StatefulWidget {
  VoidCallback? defaultAction;
  final TournamentControllerViewModel _tournamentControllerViewModel;
  final int tournamentId;

  EndTournamentBottomSheet(this._tournamentControllerViewModel, {
    Key? key,
    this.defaultAction,
    required this.tournamentId
  }) : super(key: key);

  @override
  State<EndTournamentBottomSheet> createState() => _EndTournamentBottomSheetState();
}

class _EndTournamentBottomSheetState extends State<EndTournamentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size_20_w, vertical: size_20_h,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: ElevatedButton(
                  child: Text(
                    txt_decision,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: text_16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kColor247EF1,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size_5_r),
                    ),
                  ),
                  onPressed: () {
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
                                widget._tournamentControllerViewModel.finishHalfwayApi(widget.tournamentId);
                              }
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: size_100_h,),
              Text(
                txt_end_tournament_explain,
                style: TextStyle(color: Colors.white, fontSize: text_16,),
              ),
            ],
          ),
        ),
    );
  }
}
