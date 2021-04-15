import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/helpers/authentication_state.dart';

import 'data/services/authentification.service.dart';

class AppController extends GetxController {
  // var for automatically start collecting data
  FirebaseAnalytics analytics;

  // initialize services
  final AuthentificationService authService = AuthentificationService();

  final _authenticationStateStream = AuthenticationState().obs;

  get state => _authenticationStateStream.value;
  set state(value) => _authenticationStateStream.value = value;

  @override
  onInit() {
    // start collecting one intilized
    analytics = new FirebaseAnalytics();

    // Force enable crashlytics collection enabled if we're testing it.
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    // Pass all uncaught errors to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    this._getAuthenticatedUser();

    super.onInit();
  }

  void _getAuthenticatedUser() {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = authService.user;

    if (user == null) {
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated(user: user);
    }
  }
}
