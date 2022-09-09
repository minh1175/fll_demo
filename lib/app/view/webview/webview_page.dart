import 'dart:io';

import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/model/webview_param.dart';
import 'package:Gametector/app/view/component/custom/appbar_custom.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:Gametector/app/view/webview/webview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends PageProvideNode<WebviewViewModel> {
  WebviewPage(WebviewParam? webviewParam) : super(params: [webviewParam]);

  @override
  Widget buildContent(BuildContext context) {
    return _WebviewContentPage(viewModel);
  }
}

class _WebviewContentPage extends StatefulWidget {
  final WebviewViewModel _webviewViewModel;

  _WebviewContentPage(this._webviewViewModel);

  @override
  _WebviewContentPageState createState() => _WebviewContentPageState();
}

class _WebviewContentPageState extends State<_WebviewContentPage> {
  WebviewViewModel get webviewViewModel => widget._webviewViewModel;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
    print ("************** webviewViewModel.dispose ******************");
    webviewViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColor202330,
      child: SafeArea(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarCustom(
              colorBackGround: kColor202330,
              resIcon: 'asset/icons/ic_close.svg',
              onPressIcon: () => webviewViewModel.navigationService.back(),
            ),
            body: Stack(
              children: <Widget>[
                WebView(
                  key: UniqueKey(),
                  initialUrl: webviewViewModel.webviewParam?.url ?? '',
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish) => webviewViewModel.loading = false,
                ),
                _buildLoading(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Consumer<WebviewViewModel> _buildLoading(){
    return Consumer<WebviewViewModel>(
      builder: (context, value, child){
        return value.loading ?  BuildProgressLoading() : Stack();
      },
    );
  }
}
