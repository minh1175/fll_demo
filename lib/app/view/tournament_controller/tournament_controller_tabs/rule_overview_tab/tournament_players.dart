import 'package:Gametector/app/module/network/response/player_list_response.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/component/bottom_sheet/mypage_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';

import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/rule_overview_tab/tournament_player_viewmodel.dart';

class TournamentPlayers extends PageProvideNode<TournamentPlayerViewModel> {
  final int? gameTitleId;
  final int tournamentId;

  TournamentPlayers({
    Key? key,
    required this.gameTitleId,
    this.tournamentId = 0,
  }) : super(key: key, params: [tournamentId]);

  @override
  Widget buildContent(BuildContext context) {
    return _TournamentPlayers(
      viewModel,
      key: key,
      gameTitleId: gameTitleId,
      tournamentId: tournamentId,
    );
  }
}

class _TournamentPlayers extends StatefulWidget {
  final int? gameTitleId;
  final int tournamentId;
  final TournamentPlayerViewModel _tournamentPlayerViewModel;

  _TournamentPlayers(this._tournamentPlayerViewModel, {
    Key? key,
    required this.gameTitleId,
    this.tournamentId = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TournamentPlayersState();
}

class _TournamentPlayersState extends State<_TournamentPlayers>
    with SingleTickerProviderStateMixin {
  TournamentPlayerViewModel get tournamentPlayerViewModel => widget._tournamentPlayerViewModel;

  @override
  void initState() {
    tournamentPlayerViewModel.playerListApi(widget.tournamentId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    print ("************** tournamentPlayerViewModel.dispose ******************");
    tournamentPlayerViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentPlayerViewModel>(
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
                  padding: EdgeInsets.only(top: size_5_h),
                  color: kColor212430,
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
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: size_40_w,),
                                child: Text(
                                  '参加者',
                                  style: TextStyle(color: Colors.white, fontSize: text_15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: kColor33353F,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: ListView.builder(
                            itemCount: value.lsPlayer.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => getItem(value.lsPlayer[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget getItem(Player player) {
    return GestureDetector(
      onTap: (){
        MypageBottomSheet(
          gameTitleId: widget.gameTitleId,
          userId: player.user_id,
          type: "player",
        );
      },
      child: Container(
        color: transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10,),
              child: Row(
                children: [
                  Container(
                    width: 42.0,
                    height: 42.0,
                    child: CircleAvatar(
                      backgroundColor: kColor212430,
                      backgroundImage: NetworkImage(player.player_thumb_url!),
                    ),
                  ),
                  SpaceBox.width(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player.player_name!,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white, fontSize: text_16,
                          ),
                        ),
                        SpaceBox.height(6),
                        Text(
                          player.last_access_time!,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kColoraaaaaa, fontSize: text_13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SpaceBox.width(20),
                  SvgPicture.asset(
                    'asset/icons/ic_right_arrow.svg',
                    width: 18,
                    height: 18,
                  ),
                  SpaceBox.width(12),
                ],
              ),
            ),
            Container(
                width: double.infinity,
                height: 1,
                color: kCGrey60141,
                // margin: const EdgeInsets.fromLTRB(0, 00, 0, 20)
            ),
          ],
        ),
      ),
    );
  }
}

class SpaceBox extends SizedBox {
  SpaceBox({double width = 8, double height = 8}) : super(width: width, height: height);
  SpaceBox.width([double value = 8]) : super(width: value);
  SpaceBox.height([double value = 8]) : super(height: value);
}