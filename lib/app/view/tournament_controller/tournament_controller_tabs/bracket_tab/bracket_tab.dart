// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/bracket_tab/tournament_bracket_webview.dart';

class BracketTab extends StatefulWidget {
  final String tournamentName;
  final String appBracketUrl;
  final VoidCallback callBack;
  const BracketTab({
    Key? key,
    required this.tournamentName,
    required this.appBracketUrl,
    required this.callBack,
  }) : super(key: key);

  @override
  _BracketTabState createState() => _BracketTabState();
}

class _BracketTabState extends State<BracketTab> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TournamentBracketWebview(
            tournamentName: widget.tournamentName,
            appBracketUrl: widget.appBracketUrl,
            callBack: widget.callBack,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
