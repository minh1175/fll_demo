import 'package:Gametector/app/module/common/config.dart';
import '../network_util.dart';


class AccountRequest {
  AccountRequest();

  Stream twitterInfoUpdate() => post(API_APP_MY_PAGE_TWITTER_UPDATE);

  Stream mypage() => get(API_APP_MY_PAGE);

  Stream mypageGame(params) => get(API_APP_MY_PAGE_GAME, params: params);

  Stream profile(params) => get(API_PROFILE_INFO, params: params);

  Stream introductionPost(params) => post(API_INTRODUCTION_POST, params: params);
}
