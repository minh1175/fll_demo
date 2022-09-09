// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';
import 'package:Gametector/app/view/agreement/agreement_page.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';

void appleUseNameBottomSheet(String userName) {
  BuildContext context =
  getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: transparent,
    builder: (BuildContext builderContext) {
      return FractionallySizedBox(
          heightFactor: 0.9,
          child: AppleUseNameBottomSheet(
              defaultAction: defaultAction,
              userName: userName
          )
      );
    },
  );
}

class AppleUseNameBottomSheet extends StatefulWidget {
  VoidCallback? defaultAction;
  final String userName;

  AppleUseNameBottomSheet({Key? key, this.defaultAction, this.userName = ""}) : super(key: key);

  @override
  State<AppleUseNameBottomSheet> createState() => _AppleUseNameBottomSheet();
}

class _AppleUseNameBottomSheet extends State<AppleUseNameBottomSheet> {
  late TextEditingController _textEditingController;
  String editUserName = "";

  @override
  void initState() {
    super.initState();
    editUserName = widget.userName;
    _textEditingController = new TextEditingController(text: widget.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColor1D212C,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: size_40_h),
              child:
              Text(
                txt_input_user_name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_18,
                ),
              )
          ),
          SizedBox(
            height: size_40_h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt_open_user_name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_16,
                ),
              ),
              Text(
                txt_change_user_name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size_40_h,
          ),
          Container(
              width: size_240_w,
              height: size_60_h,
              child: TextField(
                controller: _textEditingController,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                onChanged: (value) {
                  editUserName = value;
                },
              )
          ),
          SizedBox(
            height: size_80_h,
          ),
          SizedBox(
              width: size_240_w, //横幅
              height: size_60_h,
              child: ElevatedButton(
                child: Text(
                  txt_setting,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: text_14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kColor247EF1,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size_10_r),
                  ),
                ),
                onPressed: () {
                  getIt<UserSharePref>().saveAppleUserName(editUserName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgreementPage(),
                    ),
                  );
                },
              )
          )
        ],
      ),
    );
  }
}

// class AppleUseNameBottomSheet extends StatelessWidget {
//   final String userName;
//   VoidCallback? defaultAction;
//
//   AppleUseNameBottomSheet({Key? key, this.defaultAction, this.userName = ""}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     String editUserName = this.userName;
//     return Container(
//       color: kColor1D212C,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(top: size_40_h),
//               child:
//               Text(
//                 txt_input_user_name,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: text_18,
//                 ),
//               )
//           ),
//           SizedBox(
//             height: size_40_h,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 txt_open_user_name,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: text_16,
//                 ),
//               ),
//               Text(
//                 txt_change_user_name,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: text_16,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: size_40_h,
//           ),
//           Container(
//             width: size_240_w,
//             height: size_60_h,
//             child: TextField(
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               onChanged: (value) {
//                 //editUserName = value;
//               },
//             )
//           ),
//           SizedBox(
//             height: size_80_h,
//           ),
//           SizedBox(
//               width: size_240_w, //横幅
//               height: size_60_h,
//               child: ElevatedButton(
//                 child: Text(
//                   txt_setting,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: text_14,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   primary: kColor247EF1,
//                   onPrimary: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(size_10_r),
//                   ),
//                 ),
//                 onPressed: () {
//                   getIt<UserSharePref>().saveAppleUserName(userName);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AgreementPage(),
//                     ),
//                   );
//                 },
//               )
//           )
//         ],
//       ),
//     );
//   }
// }
