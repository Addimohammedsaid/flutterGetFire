import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/app.controller.dart';

import 'helpers/authentication_state.dart';
import 'ui/helpers/loading.page.dart';
import 'ui/pages/home/home.page.dart';
import 'ui/pages/welcome.page.dart';

class AppPage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //
      if (controller.state is UnAuthenticated) {
        return WelcomePage();
      }

      if (controller.state is Authenticated) {
        return HomePage();
      }

      return LoadingPage();
    });
  }
}
