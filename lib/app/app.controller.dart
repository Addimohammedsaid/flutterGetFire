import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  // var for automatically start collecting data
  FirebaseAnalytics analytics;

  @override
  onInit() {
    // start collecting one intilized
    analytics = new FirebaseAnalytics();

    // Force enable crashlytics collection enabled if we're testing it.
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    // Pass all uncaught errors to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    super.onInit();
  }
}
