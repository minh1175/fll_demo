import 'package:Gametector/app/di/injection.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsLogService {
  static final FirebaseAnalytics analyticsLogs = FirebaseAnalytics.instance;

  static void initialize() async {
    _initLog();
  }

  static void _initLog() async {
    print ("FIREBASE INIT LOG -------------------------------------");
    int? user_id = getIt<UserSharePref>().getUser()?.user_id?? null;
    if (user_id != null) {
      await analyticsLogs.setUserId(id: user_id.toString());
    }
    await analyticsLogs.logEvent(
      name: 'flutter',
      parameters: <String, dynamic>{
        'user_id': user_id.toString(),
      },
    );
  }

  static void setUserId() async {
    int? user_id = getIt<UserSharePref>().getUser()!.user_id?? null;
    if (user_id != null) {
      await analyticsLogs.setUserId(id: user_id.toString());
    }
  }
}