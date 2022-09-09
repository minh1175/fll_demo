import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'player_detail.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageGameViewModel>(
      builder: (context, value, child) {
        switch (value.loadingPlayerState) {
          case LoadingState.LOADING:
            return BuildProgressLoading();
          case LoadingState.DONE:
            return PlayerDetail();
          default:
            return Container();
        }
      },
    );
  }
}
