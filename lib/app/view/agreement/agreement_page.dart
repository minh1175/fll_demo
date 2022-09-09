import 'package:Gametector/app/module/common/res/colors.dart';
import 'package:Gametector/app/module/common/res/dimens.dart';
import 'package:Gametector/app/module/common/res/string.dart';
import 'package:Gametector/app/module/common/res/text.dart';
import 'package:Gametector/app/view/agreement/agreement_viewmodel.dart';
import 'package:Gametector/app/viewmodel/base_viewmodel.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgreementPage extends PageProvideNode<AgreementViewModel> {
  AgreementPage() : super();

  @override
  Widget buildContent(BuildContext context) {
    return _AgreementContentPage(viewModel);
  }
}

class _AgreementContentPage extends StatefulWidget {
  final AgreementViewModel _agreementViewModel;

  _AgreementContentPage(this._agreementViewModel);

  @override
  State<_AgreementContentPage> createState() => _AgreementContentState();
}

class _AgreementContentState extends State<_AgreementContentPage> {
  AgreementViewModel get agreementViewModel => widget._agreementViewModel;

  @override
  void dispose() {
    super.dispose();
    print ("************** agreementViewModel.dispose ******************");
    agreementViewModel.dispose();
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
          Padding(
            padding: EdgeInsets.only(top: size_100_h),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size_40_h),
                    child: Image.asset(
                      'asset/images/logo.png',
                      width: size_260_w,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(
                    height: size_40_h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size_45_w, right: size_45_w, bottom: size_20_h),
                    child: _buildBtnLoginComplete(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size_45_w),
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: size_12_h, horizontal: size_10_w),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(size_4_r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size_6_h),
                            Text(
                              txt_msg_agree_term_app,
                              style: TextStyle(
                                  color: kCGrey255, fontSize: text_12),
                            ),
                            SizedBox(height: size_6_h),
                            _buildCheckBoxTermOfService(),
                            _buildCheckBoxPolicy(),
                            SizedBox(height: size_10_h),
                            _buildBtnShowPolicyNTerm()
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Consumer<AgreementViewModel> _buildBtnLoginComplete() {
    return Consumer<AgreementViewModel>(
      builder: (context, value, child) {
        return AbsorbPointer(
          absorbing: !(value.policy && value.termOfService),
          child: BouncingWidget(
            duration: Duration(milliseconds: 100),
            scaleFactor: 1.0,
            onPressed: () => value.policy && value.termOfService
                ? agreementViewModel.loginCompleteAction()
                : null,
            child: Card(
              margin: EdgeInsets.zero,
              color: value.policy && value.termOfService
                  ? kColor03a9f4
                  : kColor03a9f4.withOpacity(0.5),
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(size_4_r)),
              ),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size_10_h),
                  child: Center(
                    child: Text(
                      txt_next,
                      style: kTSSVNGilroy.copyWith(
                          color: kWhite,
                          fontSize: text_16,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Consumer<AgreementViewModel> _buildCheckBoxTermOfService() {
    return Consumer<AgreementViewModel>(
      builder: (context, value, child) {
        return BouncingWidget(
          duration: Duration(milliseconds: 65),
          onPressed: () {
            agreementViewModel.changeTermOfService();
          },
          child: SizedBox(
            height: size_48_h,
            child: Card(
              margin: EdgeInsets.only(top: size_10_h),
              color: kColor70000000,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(size_4_r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      agreementViewModel.changeTermOfService();
                    },
                    child: Container(
                      height: size_12_h,
                      width: size_12_w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: value.termOfService
                                  ? kColor03a9f4
                                  : kColor7e7e7e,
                              width: 1.0),
                          shape: BoxShape.circle,
                          color: Colors.black12),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: value.termOfService
                            ? Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kColor03a9f4),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: kCBlack20),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size_5_h,
                  ),
                  Text(txt_agree_terms,
                      style: TextStyle(color: kCGrey255, fontSize: text_12))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Consumer<AgreementViewModel> _buildCheckBoxPolicy() {
    return Consumer<AgreementViewModel>(
      builder: (context, value, child) {
        return BouncingWidget(
          duration: Duration(milliseconds: 65),
          onPressed: () {
            agreementViewModel.changePolicy();
          },
          child: SizedBox(
            height: size_48_h,
            child: Card(
              margin: EdgeInsets.only(top: size_10_h),
              color: kColor70000000,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(size_5_r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        agreementViewModel.changePolicy();
                      });
                    },
                    child: Container(
                      height: size_12_h,
                      width: size_12_w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: value.policy ? kColor03a9f4 : kColor7e7e7e,
                              width: 1.0),
                          shape: BoxShape.circle,
                          color: Colors.black12),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: value.policy
                            ? Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kColor03a9f4),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: kCBlack20),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size_5_h,
                  ),
                  Text(txt_agree_policy,
                      style: TextStyle(color: kCGrey255, fontSize: text_12))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBtnShowPolicyNTerm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: BouncingWidget(
            onPressed: () {
              agreementViewModel.showTerm();
            },
            duration: Duration(milliseconds: 100),
            scaleFactor: 1.0,
            child: Container(
              height: size_40_h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size_4_r),
                  color: kColor202330),
              child: Center(
                  child: Text(txt_terms_of_service,
                      style:
                          TextStyle(color: Colors.white, fontSize: text_12))),
            ),
          ),
        ),
        SizedBox(width: size_10_w),
        Expanded(
          flex: 1,
          child: BouncingWidget(
            onPressed: () {
              agreementViewModel.showPolicy();
            },
            duration: Duration(milliseconds: 100),
            scaleFactor: 1.0,
            child: Container(
              height: size_40_h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size_4_r),
                  color: kColor202330),
              child: Center(
                  child: Text(txt_privacy_policy,
                      style:
                          TextStyle(color: Colors.white, fontSize: text_12))),
            ),
          ),
        ),
      ],
    );
  }
}
