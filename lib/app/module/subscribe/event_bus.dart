import 'package:Gametector/app/module/network/response/chat_list_response.dart';
import 'package:Gametector/app/module/network/response/push_notification_private_response.dart';
import 'package:Gametector/app/module/network/response/push_notification_response.dart';
import 'package:Gametector/app/module/network/response/push_reflect_match_result.dart';
import 'package:Gametector/app/module/network/response/push_reflect_match_result_bulk.dart';
import 'package:Gametector/app/module/network/response/push_update_all_notification.dart';
import 'package:Gametector/app/module/socket/receive/already_read_msg_socket_response.dart';

// 1 : post_chat_message
class PushNotificationEvent {
  PushNotificationResponse pushNotificationResponse;
  PushNotificationEvent(this.pushNotificationResponse);
}

// 2 : post_private_chat_message
class PushNotificationPrivateEvent {
  PushNotificationPrivateResponse pushNotificationPrivateResponse;
  PushNotificationPrivateEvent(this.pushNotificationPrivateResponse);
}

// 3 : reflect_match_result
class PushReflectMatchResultEvent {
  PushReflectMatchResult pushReflectMatchResult;
  PushReflectMatchResultEvent(this.pushReflectMatchResult);
}

// 4 : update_match_board
class PushUpdateMatchBoardEvent {
  int? tourId;
  PushUpdateMatchBoardEvent(this.tourId);
}

// 5 : update_notification
class PushUpdateNotificationEvent {
  int? tourId;
  int? tourRoundId;
  PushUpdateNotificationEvent(this.tourId, this.tourRoundId);
}

// 6 : reflect_match_result_bulk
class PushReflectMatchResultBulkEvent {
  PushReflectMatchResultBulk pushReflectMatchResultBulk;
  PushReflectMatchResultBulkEvent(this.pushReflectMatchResultBulk);
}

// 7 : update_all_notification
class PushUpdateAllNotificationEvent {
  PushUpdateAllNotification pushUpdateAllNotification;
  PushUpdateAllNotificationEvent(this.pushUpdateAllNotification);
}

// 8 : already_read_message
class AlreadyReadMessageSocketEvent {
  AlreadyReadMessageSocketResponse alreadyReadMessageSocketResponse;
  AlreadyReadMessageSocketEvent(this.alreadyReadMessageSocketResponse);
}

// 9 : typing_message
class TypingMessageEvent {
  TypingMessageResponse typingMessageResponse;
  TypingMessageEvent(this.typingMessageResponse);
}

// other : refresh all_notification tab badge
class RefreshAllNotificationBadgeEvent {
  RefreshAllNotificationBadgeEvent();
}

// other : update all_notification tab badge
class UpdateAllNotificationTabBadgeEvent {
  // 1:chat, 2:private_chat, 3:other
  int type;
  int badgeCount;
  UpdateAllNotificationTabBadgeEvent(this.type, this.badgeCount);
}

// other : update tournament page tab (match_board, notification)
class UpdateTournamentPageTabBadgeEvent {
  int tournamentId;
  int index;
  int count;
  UpdateTournamentPageTabBadgeEvent(this.tournamentId, this.index, this.count);
}

// other : refresh tournament chat
class RefreshTournamentChatEvent {
  int tournamentId;
  RefreshTournamentChatEvent(this.tournamentId);
}
