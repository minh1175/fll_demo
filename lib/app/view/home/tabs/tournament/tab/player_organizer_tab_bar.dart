import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';

class PlayerPageTab extends StatelessWidget {
  String txtTab;

  PlayerPageTab({Key? key, required this.txtTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          txtTab,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: text_12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
