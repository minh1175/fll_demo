import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class PlayerThumb extends StatelessWidget {
  final String? playerThumbUrl;
  final double size;
  final String placeholderImage;

  const PlayerThumb({
    Key? key,
    required this.playerThumbUrl,
    required this.size,
    required this.placeholderImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size_50_r,),
      child: CachedNetworkImage(
        fit: BoxFit.fitWidth,
        width: size,
        height: size,
        imageUrl: playerThumbUrl?? "",
        placeholder: (context, url) => Image.asset(fit: BoxFit.fitWidth, this.placeholderImage,),
        errorWidget: (context, url, error) => Image.asset(fit: BoxFit.fitWidth, this.placeholderImage,),
      ),
    );
  }
}