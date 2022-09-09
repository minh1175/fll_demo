import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TwitterElipse extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback callback;
  const TwitterElipse({
    Key? key,
    required this.width,
    required this.height,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          this.callback();
        },
        child: Container(
          width: this.width,
          height: this.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(this.height/2),
            color: Colors.blue,
          ),
          padding: EdgeInsets.symmetric(vertical: this.height/8,),
          child: SvgPicture.asset(
            'asset/icons/ic_twitter.svg',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
