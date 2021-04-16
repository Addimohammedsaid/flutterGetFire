import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/data/services/authentification.service.dart';

import 'package:get_fire_starter/app/helpers/authentication_state.dart';

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

  Rx<AuthenticationState> _authenticationStateStream =
      AuthenticationState().obs;

  get state => _authenticationStateStream.value;

  AuthController({@required this.authService}) : assert(authService != null);

  @override
  onInit() {
    this._getAuthenticatedUser();
    super.onInit();
  }

  void _getAuthenticatedUser() {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = authService.user;

    if (user == null) {
      _authenticationStateStream.value = UnAuthenticated();
    } else if (!user.emailVerified) {
      _authenticationStateStream.value =
          UnVerfiedEmail(authService: authService);
    } else {
      _authenticationStateStream.value = Authenticated(user: user);
    }
  }

  // creater using email & password
  void createUserWithEmailAndPassword() async {
    try {
      // reset validation errors to nothing
      error.value = null;

      this._authenticationStateStream.value = AuthenticationLoading();

      final result = await this
          .authService
          .createUserWithEmailAndPassword(email, password);

      if (result != null) {
        this._authenticationStateStream.value = Authenticated(user: result);
        Get.offAndToNamed("/");
      } else {
        this._authenticationStateStream.value =
            AuthenticationFailure(message: "failure");
      }
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

      this._authenticationStateStream.value = AuthenticationLoading();

      await this
          .authService
          .signInUserWithEmailAndPassword(email, password)
          .then((value) => this._authenticationStateStream.value =
              Authenticated(user: value));
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", error.value);
    }
  }

  // google singup & login
  void signInWithGoogle() async {
    try {
      final result = await this.authService.signInWithGoogle();

      if (result.additionalUserInfo.isNewUser) {
        // goto specifique route for exemple
      }
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
        this._authenticationStateStream.value =
            Authenticated(user: result.user);
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", error.value);
    }
  }

  // sign out
  void signOut() async {
    try {
      this._authenticationStateStream.value = AuthenticationLoading();

      this.authService.signOut().then((value) => () {
            this._authenticationStateStream.value = UnAuthenticated();
            Get.offAndToNamed("/welcome");
          });
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
