import 'dart:developer';

import 'package:Gametector/app/module/common/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_login/twitter_login.dart';

class Resource {
  final Status status;
  final String twitterId;

  Resource({
    required this.status,
    required this.twitterId,
  });
}

enum Status { Success, Error, Cancelled }

Future<Resource?> signInWithTwitter() async {
  final twitterLogin = TwitterLogin(
    apiKey: TWITTER_API_KEY,
    apiSecretKey: TWITTER_API_SECRET,
    redirectURI: TWITTER_URL_SCHEME,
  );
  final authResult = await twitterLogin.login();
  log('ID TWITTER: ${authResult.user?.id} -------------------------------------');

  switch (authResult.status) {
    case TwitterLoginStatus.loggedIn:
      final AuthCredential twitterAuthCredential =
          TwitterAuthProvider.credential(
              accessToken: authResult.authToken!,
              secret: authResult.authTokenSecret!);
      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
      log('FIREBASE AUTH UID: ${userCredential.user?.uid} -------------------------------------');
      return Resource(
          status: Status.Success,
          twitterId: authResult.user?.id.toString().trim() ?? '');
    case TwitterLoginStatus.cancelledByUser:
      return Resource(status: Status.Cancelled, twitterId: '');
    case TwitterLoginStatus.error:
      return Resource(status: Status.Error, twitterId: '');
    default:
      return null;
  }
}

