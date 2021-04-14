import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'data/services/authentification.service.dart';

class AppController extends GetxController {
  // var for automatically start collecting data
  FirebaseAnalytics analytics;

  // used for getting user data
  AuthentificationService _auth = AuthentificationService();

  bool allowVerifyEmail = true;
  bool allowResetPassword = false;

  @override
  onInit() {
    // start collecting one intilized
    analytics = new FirebaseAnalytics();

    // Force enable crashlytics collection enabled if we're testing it.
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    // Pass all uncaught errors to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // listen to user change events
    _auth.getUserChanges().listen((user) {
      print(user);

      // if user is not logged in
      if (user == null)
        Get.offAllNamed("/login");
      // if user is not verifed
      else if (!user.emailVerified && allowVerifyEmail)
        Get.offAllNamed("/verify/email");
      // if user is verifed & logged in
      else if (user.emailVerified == true)
        Get.offAllNamed("/");
      else if (allowResetPassword)
        Get.offAllNamed("/change/password");
      else
        Get.toNamed("/loading");
    });

    super.onInit();
  }
}
