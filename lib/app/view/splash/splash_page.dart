import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/view/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../viewmodel/base_viewmodel.dart';

class SplashPage extends PageProvideNode<SplashViewModel> {
  SplashPage() : super();

  @override
  Widget buildContent(BuildContext context) {
    return _SplashContentPage(viewModel);
  }
}

class _SplashContentPage extends StatefulWidget {
  final SplashViewModel _splashViewModel;

  _SplashContentPage(this._splashViewModel);

  @override
  State<StatefulWidget> createState() => _SplashContentState();
}

class _SplashContentState extends State<_SplashContentPage> {
  SplashViewModel get splashViewModel => widget._splashViewModel;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    splashViewModel.startApi();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    print ("************** splashViewModel.dispose ******************");
    splashViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [
          Image.asset(
            'asset/images/bkg_gt.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(
              'asset/images/logo.png',
              width: size_260_w,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
