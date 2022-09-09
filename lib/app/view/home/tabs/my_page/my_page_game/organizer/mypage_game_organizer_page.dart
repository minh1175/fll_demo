import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'organizer_detail.dart';

class OrganizerPage extends StatefulWidget {
  const OrganizerPage({Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrganizerPageState();
}

class _OrganizerPageState extends State<OrganizerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageGameViewModel>(
      builder: (context, value, child) {
        switch (value.loadingOrganizerState) {
          case LoadingState.LOADING:
            return BuildProgressLoading();
          case LoadingState.DONE:
            return OrganizerDetail();
          default:
            return Container();
        }
      },
    );
  }
}
