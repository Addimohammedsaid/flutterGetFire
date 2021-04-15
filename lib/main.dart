import 'dart:async';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/app.page.dart';

import 'app/app.binding.dart';
import 'app/routes/app_pages.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/translations/app_translation.dart';

void main() async {
  // fonts license
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('../../OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // get env file
  await DotEnv.load(fileName: '.env');

  // firebase initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Run the app
  runZonedGuarded(() {
    runApp(MyApp());
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      title: 'Flutter GetX Fire',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      theme: appThemeData,
      locale: window.locale,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
      ],
      fallbackLocale: AppTranslation.fallbackLocale,
      translations: AppTranslation(),
      home: AppPage(),
      getPages: AppPages.pages,
    );
  }
}
