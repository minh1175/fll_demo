import 'dart:ui';

import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showToast(String msg,
      {Color color = kColorA6000000,
      int timeInSecForIos = 1,
      Toast toastLength = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
        msg: '$msg',
        toastLength: toastLength,
        timeInSecForIosWeb: timeInSecForIos,
        backgroundColor: color);
  }
}
