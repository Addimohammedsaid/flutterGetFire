import 'package:get/get.dart';
import 'package:get_fire_starter/app/controller/home.controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
