import 'dart:io';

import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/view/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../viewmodel/base_viewmodel.dart';

class LoginPage extends PageProvideNode<LoginViewModel> {
  LoginPage() : super();

  @override
  Widget buildContent(BuildContext context) {
    return _LoginContentPage(viewModel);
  }
}

class _LoginContentPage extends StatefulWidget {
  final LoginViewModel _loginViewModel;

  _LoginContentPage(this._loginViewModel);

  @override
  State<StatefulWidget> createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContentPage> {
  LoginViewModel get loginViewModel => widget._loginViewModel;

  @override
  void initState() {
    /*FirebaseAuth.instance.signOut();
    loginViewModel.signOut();*/
  }

  @override
  void dispose() {
    super.dispose();
    print ("************** loginViewModel.dispose ******************");
    loginViewModel.dispose();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/images/logo.png',
                  width: size_260_w,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: 50.0,
                ),
                SizedBox(
                    width: 300, //横幅
                    height: 50, //高さ
                    child: ElevatedButton.icon(
                      icon: Container(),
                      label: const Text(txt_login_twitter),
                      style: ElevatedButton.styleFrom(
                          primary: kColor03a9f4,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () async {
                        // 0: apple, 1= twitter
                        //loginViewModel.setloginType(1);
                        await loginViewModel.twitterLogin();
                        //account test
                        // await loginViewModel.loginApi('2803532592'); // for iwasaki
                        // await loginViewModel.loginApi('1228218841416683520');
                        // await loginViewModel.loginApi('1338500678197469184');
                      },
                    )),
                SizedBox(
                  height: 25.0,
                ),
                Visibility(
                  visible: Platform.isIOS,
                  child: SizedBox(
                    width: 300, //横幅
                    height: 50, //高さ
                    child: ElevatedButton.icon(
                      icon: ImageIcon(
                        AssetImage("asset/icons/ic_apple.png"),
                        color: Colors.black,
                        size: 24,
                      ),
                      label: const Text(txt_login_apple),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await loginViewModel.appleLogin();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
