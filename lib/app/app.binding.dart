import 'package:get/get.dart';
import 'package:get_fire_starter/app/app.controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(() => AppController());
  }
}
