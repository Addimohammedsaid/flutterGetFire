import 'package:get/get.dart';
import 'package:get_fire_starter/app/ui/pages/home.page.dart';
import '../app.binding.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
