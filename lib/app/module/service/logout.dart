import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/socket/socket_manager.dart';
import 'package:Gametector/app/view/home/tabs/home_main/home_main_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/notification/all_notification_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/notification/tab_content/chat/notification_chat_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/notification/tab_content/chat_private/notification_chat_private_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/notification/tab_content/other/notification_other_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/tournament/tab_content/player_organizer_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/tournament/tournament_home_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_board_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/notification_tab/notification_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_chat_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

void systemLogout() {
  // TODO : ViewModelのcacheのやり方を見直す
  // ViewModelの削除
  getIt<TournamentHomeViewModel>(param1: [0]);
  getIt<PlayerOrganizerViewModel>(param1: [0, 0]);
  getIt<HomeMainViewModel>().clear();
  getIt<AllNotificationViewModel>().clear();
  getIt<NotificationChatViewModel>().clear();
  getIt<NotificationChatPrivateViewModel>().clear();
  getIt<NotificationOtherViewModel>().clear();
  getIt<MyPageViewModel>().clear();
  getIt<MatchBoardViewModel>(param1: [0]);
  getIt<NotificationViewModel>(param1: [0]);
  getIt<TournamentChatViewModel>(param1: [0]);

  // getItのユーザー情報の削除
  getIt<SharedPrefManager>().clear();
  getIt<UserSharePref>().clear();

  // firebaseからのログアウト
  FirebaseAuth.instance.signOut();

  // socketの切断
  getIt<SocketManager>().disconnect();
}