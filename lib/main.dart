import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.binding.dart';
import 'app/routes/app_pages.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/translations/app_translation.dart';

void main() async {
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
      title: 'Flutter Get Fire',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      theme: appThemeData,
      locale: window.locale,
      fallbackLocale: AppTranslation.fallbackLocale,
      translations: AppTranslation(),
      initialRoute: Routes.INITIAL,
      getPages: AppPages.pages,
    );
  }
}
