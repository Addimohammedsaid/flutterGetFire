import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/data/services/authentification.service.dart';
import 'package:get_fire_starter/app/helpers/authentication_state.dart';

import '../app.controller.dart';

class AuthController extends GetxController {
  // initialize variables
  RxString _email = ''.obs;
  RxString _password = ''.obs;
  RxString error = RxString(null);

  RxBool busy = RxBool(false);
  RxBool obscureText = RxBool(true);

  // GETTERS & SETTERS
  set email(value) => this._email.value = value;
  get email => this._email.value;

  set password(value) => this._password.value = value;
  get password => this._password.value;

  // initialize services
  final AuthentificationService authService;

  AppController appController = Get.find();

  AuthController({@required this.authService}) : assert(authService != null);

  // creater using email & password
  void createUserWithEmailAndPassword() async {
    try {
      // reset validation errors to nothing
      error.value = null;

      this.appController.state = AuthenticationLoading();

      this.authService.createUserWithEmailAndPassword(email, password);
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", error.value);
    }
  }

  // login using email & password
  void signInUserWithEmailAndPassword() async {
    try {
      // reset validation errors to nothing
      error.value = null;

      this.appController.state = AuthenticationLoading();

      await this
          .authService
          .signInUserWithEmailAndPassword(email, password)
          .then(
              (value) => this.appController.state = Authenticated(user: value));
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", error.value);
    }
  }

  // google singup & login
  void signInWithGoogle() async {
    try {
      final result = await this.authService.signInWithGoogle();

      print(result.additionalUserInfo);

      if (result.additionalUserInfo.isNewUser) {
        // goto specifique route for exemple
      } else
        this.appController.state = Authenticated(user: result.user);
    } catch (e) {
      print(e);
    }
  }

  // google singup & login
  void signInWithApple() async {
    try {
      final result = await this.authService.signInWithApple();

      if (result.additionalUserInfo.isNewUser) {
        // goto specifique route for exemple
      } else
        this.appController.state = Authenticated(user: result.user);
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", error.value);
    }
  }

  // sign out
  void signOut() async {
    try {
      this.appController.state = AuthenticationLoading();
      await this
          .authService
          .signOut()
          .then((value) => this.appController.state = UnAuthenticated);
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", error.value);
    }
  }

  sendResetPassword() {
    this.authService.sendPasswordResetMail(email);
    Get.toNamed("/");
  }

  resetPassword() {
    this.authService.changePassword(password);
  }

  onForgotPassword() {
    Get.toNamed("/forgot/password");
  }

  navigateToCreateAccount() {
    Get.toNamed("/register");
  }

  navigateToLogin() {
    Get.toNamed("/login");
  }

  togglePasswordStatus() {
    this.obscureText.value = !this.obscureText.value;
  }
}
