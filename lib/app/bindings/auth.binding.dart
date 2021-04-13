import 'package:get/get.dart';
import 'package:get_fire_starter/app/controller/auth.controller.dart';
import 'package:get_fire_starter/app/data/services/authentification.service.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
        AuthController(authService: AuthentificationService()));
  }
}
