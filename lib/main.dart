import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.binding.dart';
import 'app/app.page.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: AppBinding(),
    defaultTransition: Transition.fade,
    home: AppPage(),
  ));
}
