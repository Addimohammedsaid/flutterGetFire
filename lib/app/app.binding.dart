import 'package:get/get.dart';
import 'package:get_fire_starter/app/app.controller.dart';

import 'controller/auth.controller.dart';
import 'data/services/authentification.service.dart';

export './bindings/home.binding.dart';
export './bindings/auth.binding.dart';
export './bindings/verify.binding.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppController>((AppController()));
    Get.put(AuthController(authService: new AuthentificationService()));
  }
}
