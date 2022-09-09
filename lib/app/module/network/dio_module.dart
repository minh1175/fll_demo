import 'package:Gametector/app/module/common/config.dart';
import 'package:Gametector/app/module/common/navigator_screen.dart';
import 'package:Gametector/app/module/local_storage/shared_pref_manager.dart';
import 'package:Gametector/app/view/login/login_page.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../di/injection.dart';

final dio = AppDio.getInstance();

// ignore: prefer_mixin
class AppDio with DioMixin implements Dio {
  AppDio._([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: API_BASE,
      contentType: 'application/json',
      connectTimeout: CONNECT_TIMEOUT,
      sendTimeout: WRITE_TIMEOUT,
      receiveTimeout: READ_TIMEOUT,
    );

    this.options = options;
    interceptors.clear();
    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final appToken = getIt<UserSharePref>().getAppToken();
        options.headers.addAll({
          'X-APP-TOKEN': '$appToken',
        });
        handler.next(options);
      },
      onError: (error, handler) async {
        switch (error.type) {
          case DioErrorType.connectTimeout:
            break;
          case DioErrorType.sendTimeout:
            break;
          case DioErrorType.receiveTimeout:
            break;
          case DioErrorType.response:
            if (error.response?.statusCode == 401) {
              _handleTokenExpired(error, handler);
            }
            break;
          case DioErrorType.cancel:
            break;
          case DioErrorType.other:
            if (error.response?.data is List) {
              handler.next(error);
            }
            return;
        }
      },
    ));

    if (kDebugMode) {
      // Local Log
      interceptors.add(
          PrettyDioLogger(
              requestHeader: false,
              requestBody: false,
              responseBody: false,
              responseHeader: false,
              error: false,
              compact: false,
              request: false,
              maxWidth: 100000)
          /*LogInterceptor(responseBody: true, requestBody: true)*/);
    }

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance() => AppDio._();

  void _handleTokenExpired(DioError error, ErrorInterceptorHandler handler) {
    getIt<UserSharePref>().saveUser(null);
    getIt<NavigationService>().pushAndRemoveUntilWithFade(LoginPage());
  }
}
