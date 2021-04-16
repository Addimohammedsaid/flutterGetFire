import 'package:get/get.dart';
import 'package:get_fire_starter/app/controller/auth.controller.dart';
import 'package:get_fire_starter/app/data/provider/cloud_firestore.provider.dart';
import 'package:get_fire_starter/app/data/repository/user.repository.dart';
import 'package:get_fire_starter/app/data/services/authentification.service.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(
        authService: new AuthentificationService(),
        userRepository:
            UserRepository(apiClient: CloudFirestoreApi(collection: "users"))));
  }
}
