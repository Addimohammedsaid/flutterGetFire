import 'package:get/get.dart';
import 'package:get_fire_starter/app/controller/auth.controller.dart';
import 'package:get_fire_starter/app/ui/pages/authentification/change_password.page.dart';
import 'package:get_fire_starter/app/ui/pages/authentification/login.page.dart';
import 'package:get_fire_starter/app/ui/pages/authentification/register.page.dart';
import 'package:get_fire_starter/app/ui/pages/authentification/verify_email.page.dart';
import 'package:get_fire_starter/app/ui/pages/home/home.page.dart';
import 'package:get_fire_starter/app/ui/helpers/loading.page.dart';
import '../app.binding.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.EMAIL,
      page: () => VerifyEmailPage(),
      binding: VerifyEmailBinding(),
    ),
    GetPage(
      name: Routes.PASSWORD,
      page: () => ChangePasswordPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => LoadingPage(),
    ),
  ];
}
