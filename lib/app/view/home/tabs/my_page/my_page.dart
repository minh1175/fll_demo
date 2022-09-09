import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/view/component/custom/default_loading_progress.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_page_content.dart';

class MyPage extends PageProvideNode<MyPageViewModel> {
  MyPage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return _MyContentPage(viewModel);
  }
}

class _MyContentPage extends StatefulWidget {
  final MyPageViewModel _myPageViewModel;

  _MyContentPage(this._myPageViewModel, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<_MyContentPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  MyPageViewModel get myPageViewModel => widget._myPageViewModel;

  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    super.initState();
    myPageViewModel.mypageApi();
    myPageViewModel.openMypageGameFromPush(context);
  }

  // Don't need to dispose homeMainViewModel

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageViewModel>(
      builder: (context, value, child) {
        switch (value.loadingState) {
          case LoadingState.LOADING:
            return BuildProgressLoading();
          case LoadingState.DONE:
            return MyPageContent();
          default:
            return Container();
        }
      },
    );
  }
}
