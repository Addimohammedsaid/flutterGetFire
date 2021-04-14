import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/data/services/authentification.service.dart';

class AuthController extends GetxController {
  // initialize variables
  RxString _email = ''.obs;
  RxString _password = ''.obs;
  RxString error = RxString(null);

  RxBool busy = RxBool(true);
  RxBool obscureText = RxBool(true);

  // GETTERS & SETTERS
  set email(value) => this._email.value = value;
  get email => this._email.value;

  set password(value) => this._password.value = value;
  get password => this._password.value;

  // initialize services
  final AuthentificationService authService;

  AuthController({@required this.authService}) : assert(authService != null);

  // creater using email & password
  void createUserWithEmailAndPassword() async {
    try {
      // reset validation errors to nothing
      error.value = null;

      final result = await this
          .authService
          .createUserWithEmailAndPassword(email, password);

      // if user properly created goto next step
      if (result != null) Get.offAndToNamed("/select/location");
    } catch (e) {
      print(e);
    }
  }

  // login using email & password
  void signInUserWithEmailAndPassword() async {
    try {
      await this.authService.signInUserWithEmailAndPassword(email, password);
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", e.value);
    }
  }

  // google singup & login
  void signUpWithGoogle() async {
    try {
      final user = await this.authService.signInWithGoogle();
      if (user != null) {
        Get.toNamed("/select/location");
      }
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", e.value);
    }
  }

  // google singup & login
  void signUpWithApple() async {
    try {
      final user = await this.authService.signInWithApple();
      if (user != null) {
        Get.offAndToNamed("/select/location");
      }
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", e.value);
    }
  }

  // google singup & login
  void signInWithGoogle() {
    try {
      this.authService.signInWithGoogle();
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", e.value);
    }
  }

  // appel signup & login
  void signInWithApple() {
    try {
      this.authService.signInWithApple();
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", e.value);
    }
  }

  // sign out
  void signOut() async {
    try {
      await this.authService.signOut();
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", e.value);
    }
  }

  sendResetPassword() {
    this.authService.sendPasswordResetMail(email);
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
