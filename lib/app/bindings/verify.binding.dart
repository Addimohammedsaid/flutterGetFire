import 'package:get/get.dart';
import 'package:get_fire_starter/app/controller/verify_email.controller.dart';
import 'package:get_fire_starter/app/data/services/authentification.service.dart';

class VerifyEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<VerifyEmailController>(
        VerifyEmailController(authService: new AuthentificationService()));
  }
}
