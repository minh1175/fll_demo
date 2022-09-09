import 'package:Gametector/app/view/error/error_page.dart';
import 'package:Gametector/app/view/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  int currentHomeIndex = -1;
  int allNotificationTabIndexFromPush = -1;
  int myPageGameTitileIdFromPush = -1;
  String myPageTypeFromPush = "player";

  //replace with anim fade
  Future<dynamic>? pushReplacementScreenWithFade(Widget widget) {
    return navigatorKey.currentState?.pushReplacement(
      PageTransition(type: PageTransitionType.fade, child: widget),
    );
  }

  Future<dynamic>? pushEnterFadeExitDown(Widget widget) {
    return navigatorKey.currentState?.push(
      PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (animation.status == AnimationStatus.reverse) {
              //do your dismiss animation here
              return SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            } else {
              return
                FadeTransition(
                  opacity: animation,
                  child: child,
                );
            }
          },
          pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation,) {
            return widget;
          }),
    );
  }

  //push with anim fade
  Future<dynamic>? pushScreenWithFade(Widget widget) {
    return navigatorKey.currentState?.push(
      PageTransition(type: PageTransitionType.fade, child: widget),
    );
  }

  //push with anim slide up
  Future<dynamic>? pushScreenWithSlideUp(Widget widget) {
    return navigatorKey.currentState?.push(
      PageTransition(type: PageTransitionType.bottomToTop, child: widget),
    );
  }

  //clear all page and push new page
  Future<dynamic>? pushAndRemoveUntilWithFade(Widget widget) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      PageTransition(type: PageTransitionType.fade, child: widget),
          (route) => false,
    );
  }

  //push no anim
  Future<dynamic>? pushScreenNoAnim(Widget widget) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  refreshApp() {
    pushAndRemoveUntilWithFade(SplashPage());
  }

  gotoErrorPage({String? message}) {
    pushAndRemoveUntilWithFade(ErrorPage(
      message: message?? "",
    ));
  }

  back() {
    navigatorKey.currentState?.pop();
  }
}
