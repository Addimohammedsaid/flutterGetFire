import 'package:get/get.dart';
import 'package:get_fire_starter/app/ui/pages/authentification/forgot_password.page.dart';
import 'package:get_fire_starter/app/ui/pages/authentification/login.page.dart';
import 'package:get_fire_starter/app/ui/pages/authentification/register.page.dart';
import 'package:get_fire_starter/app/ui/pages/authentification/verify_email.page.dart';
import 'package:get_fire_starter/app/ui/pages/home/home.page.dart';
import 'package:get_fire_starter/app/ui/pages/welcome.page.dart';
import 'package:get_fire_starter/app/ui/helpers/loading.page.dart';
import '../app.binding.dart';
import '../app.page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => AppPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.WELCOM,
      page: () => WelcomePage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: Routes.EMAIL,
      page: () => VerifyEmailPage(),
      binding: VerifyEmailBinding(),
    ),
    GetPage(
      name: Routes.RESET,
      page: () => ForgotPasswordPage(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => LoadingPage(),
    ),
  ];
}
