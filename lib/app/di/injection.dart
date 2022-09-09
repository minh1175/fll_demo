import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/module/network/request/account_request.dart';
import 'package:Gametector/app/module/network/request/auth_request.dart';
import 'package:Gametector/app/module/network/request/chat_request.dart';
import 'package:Gametector/app/module/network/request/common_request.dart';
import 'package:Gametector/app/module/network/request/home_request.dart';
import 'package:Gametector/app/module/network/request/matchboard_request.dart';
import 'package:Gametector/app/module/network/request/notice_request.dart';
import 'package:Gametector/app/module/network/request/setting_request.dart';
import 'package:Gametector/app/module/network/request/tournament_request.dart';
import 'package:Gametector/app/module/repository/data_repository.dart';
import 'package:Gametector/app/module/socket/socket_manager.dart';
import 'package:Gametector/app/view/agreement/agreement_viewmodel.dart';
import 'package:Gametector/app/view/component/bottom_sheet/notice_bottom_sheet/notice_bottom_sheet_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/home_main/home_main_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_game/my_page_game_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/my_page/my_page_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/notification/all_notification_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/notification/tab_content/chat/notification_chat_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/notification/tab_content/chat_private/notification_chat_private_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/notification/tab_content/other/notification_other_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/tournament/tab_content/player_organizer_viewmodel.dart';
import 'package:Gametector/app/view/home/tabs/tournament/tournament_home_viewmodel.dart';
import 'package:Gametector/app/view/login/login_viewmodel.dart';
import 'package:Gametector/app/view/splash/splash_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/chat_private_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/match_board_tab/match_board_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/score_input/score_input_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/notification_tab/notification_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/rule_overview_tab/tournament_player_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/participant_list_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_tabs/tournament_chat_tab/tournament_chat_viewmodel.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_viewmodel.dart';
import 'package:Gametector/app/view/webview/webview_viewmodel.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  //local storage
  getIt.registerSingleton<UserSharePref>(UserSharePref());
  getIt.registerSingleton<SharedPrefManager>(SharedPrefManager());
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());

  //repository
  getIt.registerFactory<AuthRequest>(() => AuthRequest());
  getIt.registerFactory<CommonRequest>(() => CommonRequest());
  getIt.registerFactory<AccountRequest>(() => AccountRequest());
  getIt.registerFactory<TournamentRequest>(() => TournamentRequest());
  getIt.registerFactory<MatchBoardRequest>(() => MatchBoardRequest());
  getIt.registerFactory<HomeRequest>(() => HomeRequest());
  getIt.registerFactory<NoticeRequest>(() => NoticeRequest());
  getIt.registerFactory<ChatRequest>(() => ChatRequest());
  getIt.registerFactory<SettingRequest>(() => SettingRequest());
  getIt.registerFactory<SocketManager>(() => SocketManager());

  //data repository
  getIt.registerFactory<DataRepository>(() => DataRepository(
        getIt<AuthRequest>(),
        getIt<CommonRequest>(),
        getIt<AccountRequest>(),
        getIt<TournamentRequest>(),
        getIt<MatchBoardRequest>(),
        getIt<HomeRequest>(),
        getIt<NoticeRequest>(),
        getIt<ChatRequest>(),
        getIt<SettingRequest>(),
      ));

  //view model
  getIt.registerFactory<SplashViewModel>(
      () => SplashViewModel(getIt<DataRepository>()));

  getIt.registerFactory<LoginViewModel>(
      () => LoginViewModel(getIt<DataRepository>()));

  getIt.registerFactory<AgreementViewModel>(
      () => AgreementViewModel(getIt<DataRepository>()));

  getIt.registerFactoryParam<WebviewViewModel, List<dynamic>, String>(
      (param1, _) => WebviewViewModel(webviewParam: param1[0]));

  getIt.registerFactory<MyPageViewModel>(
      () => MyPageViewModel(getIt<DataRepository>()));

  getIt.registerFactoryParam<TournamentHomeViewModel, List<dynamic>, String>(
      (param1, _) => TournamentHomeViewModel(getIt<DataRepository>(), tabType: param1[0]));

  getIt.registerFactory<HomeMainViewModel>(
      () => HomeMainViewModel(getIt<DataRepository>()));

  getIt.registerFactoryParam<PlayerOrganizerViewModel, List<dynamic>, String>(
      (param1, _) => PlayerOrganizerViewModel(getIt<DataRepository>(),
          tabType: param1[0], filterType: param1[1]));

  getIt.registerFactoryParam<TournamentControllerViewModel, List<dynamic>,
          String>(
      (param1, _) => TournamentControllerViewModel(getIt<DataRepository>(),
          tournamentId: param1[0]));

  getIt.registerFactoryParam<TournamentChatViewModel, List<dynamic>, String>(
          (param1, _) => TournamentChatViewModel(getIt<DataRepository>(),
          tournamentId: param1[0]));

  getIt.registerFactoryParam<ChatPrivateViewModel, List<dynamic>, String>(
          (param1, _) => ChatPrivateViewModel(getIt<DataRepository>()));

  getIt.registerFactory<TournamentPlayerViewModel>(
      () => TournamentPlayerViewModel(getIt<DataRepository>()));

  getIt.registerFactory<ParticipantListViewModel>(
      () => ParticipantListViewModel(getIt<DataRepository>()));

  getIt.registerFactoryParam<MatchBoardViewModel, List<dynamic>, String>(
          (param1, _) => MatchBoardViewModel(getIt<DataRepository>(),
              tournamentId: param1[0]));

  getIt.registerFactoryParam<NotificationViewModel, List<dynamic>, String>(
          (param1, _) => NotificationViewModel(getIt<DataRepository>(),
          tournamentId: param1[0]));

  getIt.registerFactoryParam<NoticeBottomSheetViewModel, List<dynamic>, String>(
      (param1, _) => NoticeBottomSheetViewModel(getIt<DataRepository>()));

  getIt.registerFactory<AllNotificationViewModel>(
          () => AllNotificationViewModel(getIt<DataRepository>()));

  getIt.registerFactory<NotificationChatViewModel>(
          () => NotificationChatViewModel(getIt<DataRepository>()));

  getIt.registerFactory<NotificationChatPrivateViewModel>(
          () => NotificationChatPrivateViewModel(getIt<DataRepository>()));

  getIt.registerFactory<NotificationOtherViewModel>(
          () => NotificationOtherViewModel(getIt<DataRepository>()));

  getIt.registerFactoryParam<MyPageGameViewModel, List<dynamic>, String>(
          (param1, _) => MyPageGameViewModel(getIt<DataRepository>(),
              userId: param1[0], gameTitleId: param1[1]));

  getIt.registerFactoryParam<ScoreInputViewModel, List<dynamic>, String>(
      (param1, _) => ScoreInputViewModel(getIt<DataRepository>()));
}
