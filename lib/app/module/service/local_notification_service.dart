import 'dart:async';
import 'dart:developer';

import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/network/response/push_notification_private_response.dart';
import 'package:Gametector/app/module/network/response/push_notification_response.dart';
import 'package:Gametector/app/module/network/response/push_update_all_notification.dart';
import 'package:Gametector/app/module/network/response/push_update_notification.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/module/utils/launch_url.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/view/home/home_page.dart';
import 'package:Gametector/app/view/tournament_controller/chat_private/chat_private_page.dart';
import 'package:Gametector/app/view/tournament_controller/tournament_controller_page.dart';
import 'package:Gametector/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final _subs = <StreamSubscription>[];
  static Map<String, dynamic> data = {};
  static const _channel = AndroidNotificationChannel(
    'com.gametector', // id
    'Gametector', // title
    description: '',
    importance: Importance.max,
  );

  static void initialize() async {
    _initFCM();
    _initLocalNotification();
    _createImportantChannel();
  }

  static void _initLocalNotification() {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  static void _initFCM() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final firebaseToken = await messaging.getToken();
    //SAVE FIREBASE PUSH TOKEN
    saveFirebaseToken(firebaseToken ?? '');
    log('FIREBASE TOKEN: $firebaseToken -------------------------------------');
    _subs.add(messaging.onTokenRefresh.listen((firebaseToken) {
      //SAVE FIREBASE PUSH TOKEN REFRESH
      saveFirebaseToken(firebaseToken);
      log('FIREBASE TOKEN REFRESH: $firebaseToken -------------------------------------');
    }));

    void _silentPushRouting(RemoteMessage message) {
      try {
        print(message.data);
        // Receive message in the foreground
        if (message.data.containsKey('push_type')) {
          int pushType = int.parse(message.data["push_type"]);
          switch(pushType) {
            case 1:
              // post_chat_message
              var jsonDecodeMessage = jsonDecode(message.data["data"]);
              if (jsonDecodeMessage["player_id"] == "") jsonDecodeMessage["player_id"] = 0;
              PushNotificationResponse pushData = PushNotificationResponse.fromJson(jsonDecodeMessage);
              eventBus.fire(PushNotificationEvent(pushData));
              break;
            case 2:
              // post_private_chat_message
              var jsonDecodeMessage = jsonDecode(message.data["data"]);
              if (jsonDecodeMessage["player_id"] == "") jsonDecodeMessage["player_id"] = 0;
              PushNotificationPrivateResponse pushData = PushNotificationPrivateResponse.fromJson(jsonDecodeMessage);
              eventBus.fire(PushNotificationPrivateEvent(pushData));
              break;
            case 3:
              // TODO : PushReflectMatchResultEvent
              // reflect_match_result
              Map dataJson = jsonDecode(message.data["data"]);
              eventBus.fire(PushUpdateMatchBoardEvent(dataJson["tournament_id"]));
              break;
            case 4:
              // update_match_board
              Map dataJson = jsonDecode(message.data["data"]);
              eventBus.fire(PushUpdateMatchBoardEvent(dataJson["tournament_id"]));
              break;
            case 5:
              // update_notification
              PushUpdateNotification pushData = PushUpdateNotification.fromJson(jsonDecode(message.data["data"]));
              eventBus.fire(PushUpdateNotificationEvent(pushData.tournament_id, pushData.tournament_round_id));
              break;
            case 6:
              // TODO : replace to PushReflectMatchResultBulk??
              // reflect_match_result_bulk
              Map dataJson = jsonDecode(message.data["data"]);
              eventBus.fire(PushUpdateMatchBoardEvent(dataJson["tournament_id"]));
              break;
            case 7:
              // update_all_notification
              PushUpdateAllNotification pushData = PushUpdateAllNotification.fromJson(jsonDecode(message.data["data"]));
              eventBus.fire(PushUpdateAllNotificationEvent(pushData));
              eventBus.fire(RefreshAllNotificationBadgeEvent());
              break;
            default:
              break;
          }
        }
      } catch (e) {
        print(e);
      }
    }

    // function define the action when push notification is tapped
    void _pushRouting(RemoteMessage message) {
      print (message.data);
      if (message.data.containsKey('destination_type')) {
        NavigationService _navigationService = getIt<NavigationService>();
        BuildContext context = _navigationService.navigatorKey.currentContext!;
        int destType = int.parse(message.data["destination_type"]);
        switch(destType) {
          case 0:
            // open app
            break;
          case 1:
            // web（ウェブページ）
            launchURL(message.data["web_url"]);
            break;
          case 2:
            // tournament_chat（大会チャット）
            _navigationService.pushAndRemoveUntilWithFade(HomePage());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TournamentControllerPage(
                  tournamentId: int.parse(message.data["tournament_id"],),
                ),
              ),
            );
            break;
          case 3:
            // tournamnet_private_chat（試合チャット）
            _navigationService.pushAndRemoveUntilWithFade(HomePage());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPrivatePage(
                  tournamentId: int.parse(message.data["tournament_id"]),
                  tournamentRoundId: int.parse(message.data["tournament_round_id"]),
                  isDiplayTournamentButton: true,
                ),
              ),
            );
            break;
          case 4:
            // result_aproval（まとめて結果承認）
            _navigationService.pushAndRemoveUntilWithFade(HomePage());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TournamentControllerPage(
                  tournamentId: int.parse(message.data["result_tournament_id"],),
                ),
              ),
            );
            break;
          case 5:
            // my_page（マイページ）
            _navigationService.currentHomeIndex = 4;
            if (message.data.containsKey('game_title_id')) {
              _navigationService.myPageGameTitileIdFromPush = int.parse(message.data["game_title_id"]);
            }
            if (message.data.containsKey('type')) {
              _navigationService.myPageTypeFromPush = message.data["type"];
            }
            _navigationService.pushAndRemoveUntilWithFade(HomePage());
            break;
          case 6:
            // all notice（お知らせ）
            _navigationService.currentHomeIndex = 3;
            // pushから遷移させるタブ
            if (message.data.containsKey('type')) {
              // type (substract 1 because index start from 0)
              // 1: tournament_chat
              // 2: tournament_private_chat
              // 3: other
              _navigationService.allNotificationTabIndexFromPush = int.parse(message.data["type"]) - 1;
            }
            _navigationService.pushAndRemoveUntilWithFade(HomePage());
            break;
          default:
            print ("------ Unexpected destType {$destType} -------");
            break;
        }
      }
    }

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null){
        // TODO : change if there is any ather good method.
        Future.delayed(
          Duration(milliseconds: 1000), () {
            _pushRouting(message);
          },
        );
      }
    });

    // Excute when tap push notification while app is running
    _subs.add(FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      _pushRouting(message);
    }));

    _subs.add(FirebaseMessaging.onMessage.listen((message) {
      _silentPushRouting(message);
    }));

  }

  static void saveFirebaseToken(String value) {
    getIt<UserSharePref>().saveFirebaseToken(value);
  }

  static void _createImportantChannel() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  static Future<void> _onSelectNotification(String? payload) async {}

  static Future _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {}

  static void display(RemoteMessage message) async {
    try {
      data = message.data;
      final android = message.notification?.android;
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.max,
          priority: Priority.high,
          icon: android?.smallIcon,
        ),
      );
      await _notificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['route'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static void cancel() {
    _subs.forEach((element) => element.cancel());
  }
}
