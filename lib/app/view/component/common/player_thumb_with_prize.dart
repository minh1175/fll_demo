import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';

class PlayerThumbWithPrize extends StatelessWidget {
  final String? playerThumbUrl;
  final String? playerFrameUrl;
  final String? playerBackgourndUrl;
  final double size;
  final String placeholderImage;
  const PlayerThumbWithPrize({
    Key? key,
    required this.playerThumbUrl,
    required this.playerFrameUrl,
    required this.playerBackgourndUrl,
    required this.size,
    required this.placeholderImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CachedNetworkImage(
            fit: BoxFit.fitWidth,
            height: this.size,
            width: this.size,
            imageUrl: this.playerBackgourndUrl?? "",
            placeholder: (context, url) => Image.memory(fit: BoxFit.fitWidth, kTransparentImage),
            errorWidget: (context, url, error) => Image.memory(fit: BoxFit.fitWidth, kTransparentImage),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(size_30_r),
            child: CachedNetworkImage(
              fit: BoxFit.fitWidth,
              height: this.size!*0.5,
              width: this.size!*0.5,
              imageUrl: this.playerThumbUrl?? "",
              placeholder: (context, url) => Image.asset(fit: BoxFit.fitWidth, this.placeholderImage,),
              errorWidget: (context, url, error) => Image.asset(fit: BoxFit.fitWidth, this.placeholderImage,),
            ),
          ),
          CachedNetworkImage(
            fit: BoxFit.fitWidth,
            height: this.size!*0.9,
            width: this.size!*0.9,
            imageUrl: this.playerFrameUrl?? "",
            placeholder: (context, url) => Image.memory(fit: BoxFit.fitWidth, kTransparentImage),
            errorWidget: (context, url, error) => Image.memory(fit: BoxFit.fitWidth, kTransparentImage),
          ),
        ],
      ),
    );
  }
}
