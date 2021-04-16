import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/app.controller.dart';
import 'package:get_fire_starter/app/ui/pages/authentification/verify_email.page.dart';

import 'controller/auth.controller.dart';
import 'helpers/authentication_state.dart';
import 'ui/helpers/loading.page.dart';
import 'ui/pages/home/home.page.dart';
import 'ui/pages/welcome.page.dart';

class AppPage extends GetWidget<AppController> {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(builder: (AuthController authcontroller) {
      if (authcontroller.state is UnAuthenticated) {
        return WelcomePage();
      }

      if (authcontroller.state is Authenticated) {
        return HomePage();
      }

      if (authcontroller.state is UnVerifiedEmail) {
        return VerifyEmailPage();
      }

      return LoadingPage();
    });
  }
}
