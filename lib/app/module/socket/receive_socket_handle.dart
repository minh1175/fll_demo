import 'dart:convert';

import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/subscribe/event_bus.dart';
import 'package:Gametector/app/module/network/response/chat_list_response.dart';
import 'package:Gametector/app/module/network/response/push_notification_private_response.dart';
import 'package:Gametector/app/module/network/response/push_notification_response.dart';
import 'package:Gametector/app/module/network/response/push_reflect_match_result.dart';
import 'package:Gametector/app/module/network/response/push_reflect_match_result_bulk.dart';
import 'package:Gametector/app/module/network/response/push_update_all_notification.dart';
import 'package:Gametector/app/module/network/response/push_update_all_notification_temp.dart';
import 'package:Gametector/app/module/network/response/push_update_match_board.dart';
import 'package:Gametector/app/module/network/response/push_update_notification.dart';
import 'package:Gametector/app/module/socket/receive/already_read_msg_socket_response.dart';
import 'package:Gametector/app/module/socket/receive/base_socket_response.dart';
import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:Gametector/main.dart';

class ReceiveSocketHandle {
  String? data = "";

  ReceiveSocketHandle({this.data});

  handleData() {
    if (data?.isEmpty == true) return;
    BaseSocketResponse baseResponse = BaseSocketResponse.fromJson(jsonDecode(data ?? " "));
    List<int>? pushType = baseResponse.push_type;
    if (pushType == null) return;
    for (int element in pushType) {
      switch (element.toString()) {
        case PUSH_TYPE_SOCKET_ERROR:
          // 0 : socket_error
          BaseSocketResponse pushData = BaseSocketResponse.fromJson(jsonDecode(data ?? " "));
          showAlertGTDialog(message: pushData.message);
          break;
        case PUSH_TYPE_CHAT_MESSAGE:
          // 1 : post_chat_message
          PushNotificationResponse pushData = PushNotificationResponse.fromJson(jsonDecode(data ?? " "));
          eventBus.fire(PushNotificationEvent(pushData));
          break;
        case PUSH_TYPE_PRIVATE_CHAT_MESSAGE:
          // 2 : post_private_chat_message
          PushNotificationPrivateResponse pushData = PushNotificationPrivateResponse.fromJson(jsonDecode(data ?? " "));
          eventBus.fire(PushNotificationPrivateEvent(pushData));
          break;
        case PUSH_TYPE_REFLECT_MATCH_RESULT:
          // 3 : reflect_match_result (never called from socket)
          // Set [flg_result_reflect of lstData] of ChatFragment to 1 (not call api but reload RecyclerView)
          // parameter is tournament_id and round_box_no
          PushReflectMatchResult pushData = PushReflectMatchResult.fromJson(jsonDecode(data ?? " "));
          eventBus.fire(PushReflectMatchResultEvent(pushData));
          break;
        case PUSH_TYPE_UPDATE_MATCH_BOARD:
          // 4 : update_match_board (never called from socket)
          // call matchBoardListApi of MatchBoardFragment again
          PushUpdateMatchBoard pushData = PushUpdateMatchBoard.fromJson(jsonDecode(data ?? " "));
          eventBus.fire(PushUpdateMatchBoardEvent(pushData.tournament_id));
          break;
        case PUSH_TYPE_UPDATE_NOTIFICATION:
          // 5 : update_notification
          // call noticeListApi of NotificationFragment again
          PushUpdateNotification pushData = PushUpdateNotification.fromJson(jsonDecode(data ?? " "));
          eventBus.fire(PushUpdateNotificationEvent(pushData.tournament_id, pushData.tournament_round_id));
          break;
        case PUSH_TYPE_REFLECT_MATCH_RESULT_BULK:
          // 6 : reflect_match_result_bulk (never called from socket)
          // Set [flg_result_reflect of lstData] of ChatFragment to 1 (not call api but reload RecyclerView)
          // parameter is tournament_id and round_box_no_list
          PushReflectMatchResultBulk pushData = PushReflectMatchResultBulk.fromJson(jsonDecode(data ?? " "));
          eventBus.fire(PushReflectMatchResultBulkEvent(pushData));
          break;
        case PUSH_TYPE_UPDATE_ALL_NOTIFICATION:
          // 7 : update_all_notification
          // call noticeListApi of NotificationFragment again
          PushUpdateAllNotificationTemp pushDataTemp = PushUpdateAllNotificationTemp.fromJson(jsonDecode(data ?? " "));
          PushUpdateAllNotification pushData = PushUpdateAllNotification();
          if (pushDataTemp.is_private) {
            pushData.type = 2;
            pushData.flg_badge_update = pushDataTemp.flg_organizer_call;
          } else {
            pushData.type = 1;
            pushData.flg_badge_update = pushDataTemp.flg_announce;
          }
          eventBus.fire(PushUpdateAllNotificationEvent(pushData));
          eventBus.fire(RefreshAllNotificationBadgeEvent());
          break;
        case PUSH_TYPE_ALREADY_READ_MESSAGE:
          // 8 : already_read_message
          AlreadyReadMessageSocketResponse alreadyReadData = AlreadyReadMessageSocketResponse.fromJson(jsonDecode(data ?? " "));
          eventBus.fire(AlreadyReadMessageSocketEvent(alreadyReadData));
          break;
        case PUSH_TYPE_TYPING_MESSAGE:
          // 9 : typing_message
          TypingMessageResponse typingData = TypingMessageResponse.fromJson(jsonDecode(data ?? ' '));
          eventBus.fire(TypingMessageEvent(typingData));
          break;
      }
    }
  }
}
