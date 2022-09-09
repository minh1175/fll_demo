import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_board_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MatchList extends StatelessWidget {
  const MatchList({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchBoardViewModel>(builder: (context, value, child) {
      return ListView.builder(
        itemCount: value.lsMatch.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: size_10_h,
              horizontal: size_8_w,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  size_5_r,
                ),
                color: kColor2b2e3e,
              ),
              child: MatchCard(
                gameTitleId: value.resMatchList!.game_title_id!,
                tournamentId: value.tournamentId,
                match: value.lsMatch[index],
                // data: value.resMatchList,
                // data: value.lsMatch[index].tournament_id,
              ),
            ),
          );
        },
      );
    });
  }
}
