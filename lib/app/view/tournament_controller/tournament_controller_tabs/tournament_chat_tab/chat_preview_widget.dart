import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

import '../../../../module/common/res/style.dart';
import '../../../../module/utils/launch_url.dart';

class ChatPreviewWidget extends StatefulWidget {
  ChatPreviewWidget({Key? key, required this.url, required this.chatTextStyle})
      : super(key: key);
  String url;
  var chatTextStyle;

  @override
  _ChatPreviewWidgetState createState() => _ChatPreviewWidgetState();
}

class _ChatPreviewWidgetState extends State<ChatPreviewWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchURL(widget.url),
      child: AnyLinkPreview.builder(
        link: widget.url,
        placeholderWidget: Container(),
        errorWidget: Container(),
        itemBuilder: (context, metadata, imageProvider) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            padding: EdgeInsets.only(
              left: size_10_w,
              top: size_6_h,
              right: size_10_w,
              bottom: size_10_h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                size_10_r,
              ),
              color: kColor2b2e3c,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (imageProvider != null)
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.width * 0.3,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size_5_r),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      size_10_r,
                    ),
                    color: kColor2b2e3c,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: size_10_h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (metadata.title != null)
                        Text(
                          metadata.title ?? '',
                          maxLines: 1,
                          style: widget.chatTextStyle
                              .copyWith(fontWeight: FontWeight.bold,fontSize: text_14),
                        ),
                      SizedBox(height: size_5_h),
                      if (metadata.desc != null)
                        Text(
                          metadata.desc ?? '',
                          maxLines: 2,
                          style:
                              widget.chatTextStyle,
                        ),
                      SizedBox(height: size_8_h),
                      Text(
                        metadata.url ?? widget.url,
                        maxLines: 1,
                        style: widget.chatTextStyle
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
 }
