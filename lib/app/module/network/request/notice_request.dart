import 'package:Gametector/app/module/common/config.dart';
import '../network_util.dart';


class NoticeRequest {
  NoticeRequest();

  Stream all(params) => get(API_NOTIFY_ALL, params: params);

  Stream list(params) => get(API_NOTICE_LIST, params: params);

  Stream read(params) => post(API_NOTICE_READ, params: params);

  Stream announce(params) => get(API_ANNOUNCE_LIST, params: params);

  Stream badgeCount() => get(API_BADGE_COUNT);
}
