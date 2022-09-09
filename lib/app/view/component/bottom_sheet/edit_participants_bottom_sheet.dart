import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

void editParticipantsBottomSheet({int? status, String? type, VoidCallback? excludeCallback, VoidCallback? deleteCallback}) {
  BuildContext context = getIt<NavigationService>().navigatorKey.currentContext!;
  VoidCallback? defaultAction;
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: transparent,
    context: context,
    builder: (BuildContext builderContext) {
      return _EditParticipants(
        defaultAction: defaultAction,
        status: status,
        type: type,
        excludeCallback: excludeCallback,
        deleteCallback: deleteCallback,
      );
    },
  );
}

class _EditParticipants extends StatelessWidget {
  final VoidCallback? defaultAction;
  final int? status;
  final String? type;
  final VoidCallback? excludeCallback;
  final VoidCallback? deleteCallback;
  const _EditParticipants({
    Key? key,
    required this.defaultAction,
    required this.status,
    required this.type,
    required this.excludeCallback,
    required this.deleteCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size_20_h, horizontal: size_15_w,),
      decoration: BoxDecoration(
        color: kColor202330,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                sprintf(txt_title_exclude, [this.type]),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: this.excludeCallback,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: size_5_h, horizontal: size_15_w,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size_20_r),
                    color: this.status == 3 ? Colors.blueAccent : Colors.redAccent,
                  ),
                  child: Text(
                    this.status == 3 ? txt_to_unexclude : txt_to_exclude,
                    style: TextStyle(color: Colors.white, fontSize: text_12,),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size_6_h,),
          Text(
            sprintf(txt_exclude_description, [this.type]),
            style: TextStyle(color: Colors.white, fontSize: text_12,),
          ),
          SizedBox(height: size_30_h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                sprintf(txt_title_delete, [this.type]),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: text_14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: this.deleteCallback,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: size_5_h, horizontal: size_15_w,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size_20_r),
                      color: Colors.redAccent),
                  child: Text(
                    txt_to_delete,
                    style: TextStyle(color: Colors.white, fontSize: text_12,),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size_6_h,),
          Text(
            sprintf(txt_delete_description, [this.type]),
            style: TextStyle(color: Colors.white, fontSize: text_12,),
          ),
          SizedBox(height: size_30_h,),
          Text(
            txt_note_exclude,
            style: TextStyle(color: Colors.white, fontSize: text_12, fontWeight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}
