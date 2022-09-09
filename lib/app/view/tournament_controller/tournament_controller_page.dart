import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/component/dialog/push_permission_dialog.dart';
import 'package:Gametector/app/view/tournament_controller/event_page.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/notification_tab/notification_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_chat_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_page.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'tournament_controller_tabs/match_board_tab/match_board_viewmodel.dart';

class TournamentControllerPage extends PageProvideNode<TournamentControllerViewModel> {
  final int tournamentId;

  TournamentControllerPage({
    Key? key,
    required this.tournamentId,
  }) : super(key: key, params: [tournamentId]);

  @override
  Widget buildContent(BuildContext context) {
    return _TournamentControllerPage(
      viewModel,
      key: key,
      tournamentId: tournamentId,
    );
  }
}

class _TournamentControllerPage extends StatefulWidget {
  final TournamentControllerViewModel _tournamentControllerViewModel;
  final int tournamentId;

  _TournamentControllerPage(this._tournamentControllerViewModel, {
    Key? key,
    required this.tournamentId,
  }) : super(key: key);

  @override
  __TournamentControllerPageState createState() => __TournamentControllerPageState();
}

class __TournamentControllerPageState extends State<_TournamentControllerPage> {
  TournamentControllerViewModel get tournamentControllerViewModel => widget._tournamentControllerViewModel;

  @override
  void initState() {
    tournamentControllerViewModel.tournamentInfoApi();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var prmissionStatus = await Permission.notification.status;
      if (!prmissionStatus.isGranted) {
        pushPermissionDialog();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    print ("************** tournamentControllerViewModel.dispose ******************");
    tournamentControllerViewModel.dispose();
    // TODO : disposeのやり方を再検討する
    getIt<MatchBoardViewModel>(param1: [widget.tournamentId]).diposeSelf();
    getIt<NotificationViewModel>(param1: [widget.tournamentId]).diposeSelf();
    getIt<TournamentChatViewModel>(param1: [widget.tournamentId]).diposeSelf();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentControllerViewModel>(builder: (context, value, child){
      switch (value.loadingState) {
        case LoadingState.LOADING:
          return LoadingScreen(context);
        case LoadingState.DONE:
          switch (value.tournamentInfo?.competition_type) {
            case 99:
              return EventPage();
            case 1:
            case 2:
              return TournamentPage();
            default:
              return Container();
          }
        default:
          return LoadingScreen(context);
      }
    });
  }

  Widget LoadingScreen(BuildContext context) {
    return Container(
      color: kColor202330,
      child: SafeArea(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: Scaffold(
            backgroundColor: kColor212430,
            body: BuildProgressLoading(),
          ),
        ),
      ),
    );
  }
}
