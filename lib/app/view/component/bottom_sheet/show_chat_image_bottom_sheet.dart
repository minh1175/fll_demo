import 'dart:io';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/style.dart';
import 'package:flutter/material.dart';

void showImageChatBottomSheet(String imgUrl, {String? message, int type=1}) {
  // type = 1: NetworkImage
  // type = 2: Image.file
  BuildContext context =
      getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: transparent,
    context: context,
    builder: (BuildContext builderContext) {
      return FractionallySizedBox(
        heightFactor: 0.95,
        child: ShowImageChatBottomSheet(
          defaultAction: defaultAction,
          imgUrl: imgUrl,
          type: type,
        ),
      );
    },
  );
}

class ShowImageChatBottomSheet extends StatelessWidget {
  final VoidCallback? defaultAction;
  final String imgUrl;
  final int type;

  ShowImageChatBottomSheet({
    Key? key,
    this.defaultAction,
    required this.imgUrl,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kColor212430,
        borderRadius: BorderRadius.circular(size_5_r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: size_18_h, horizontal: size_12_w),
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                txt_close,
                style: TextStyle(fontSize: text_15, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: (type==1)
                ? FadeInImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(imgUrl,),
                  placeholder: AssetImage('asset/images/gray04.png',),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'asset/images/gray04.png',
                      fit: BoxFit.fill,
                      height: size_100_h,
                      width: size_100_w,
                    );
                  },
                )
                : Image.file(File(imgUrl,),),
          ),
        ],
      ),
    );
  }
}
