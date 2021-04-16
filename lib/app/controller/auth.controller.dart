import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/data/model/user.model.dart';
import 'package:get_fire_starter/app/data/repository/user.repository.dart';
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
  final UserRepository userRepository;

  Rx<AuthenticationState> _authenticationStateStream =
      AuthenticationState().obs;

  get state => _authenticationStateStream.value;
  set state(value) => _authenticationStateStream.value = value;

  AuthController({@required this.authService, @required this.userRepository})
      : assert(authService != null, userRepository != null);

  @override
  onInit() {
    this._getAuthenticatedUser();
    super.onInit();
  }

  void _getAuthenticatedUser() {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = authService.user;

    if (user == null) {
      state = UnAuthenticated();
    } else if (!user.emailVerified) {
      state = UnVerifiedEmail(authService: authService);
    } else {
      state = Authenticated(user: user);
    }
  }

  // creater using email & password
  void createUserWithEmailAndPassword() async {
    try {
      // reset validation errors to nothing
      error.value = null;

      state = AuthenticationLoading();

      final result = await this
          .authService
          .createUserWithEmailAndPassword(email, password);

      if (result != null) {
        // create user
        this.userRepository.add(UserModel(
            createdAt: result.metadata.creationTime,
            email: result.email,
            uid: result.uid,
            isEmailVerified: result.emailVerified));

        // set user as authenticated
        state = Authenticated(user: result);

        // go to next step
        Get.offAndToNamed("/");
      }
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", error.value);
    }
  }

  // login using email & password
  void signInUserWithEmailAndPassword() async {
    try {
      state = AuthenticationLoading();

      final result = await this
          .authService
          .signInUserWithEmailAndPassword(email, password);

      if (result != null && result.emailVerified)
        state = Authenticated(user: result);
      else if (result != null)
        state = UnVerifiedEmail(authService: authService);

      Get.offAndToNamed("/");
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
        // create user
        this.userRepository.add(UserModel(
            createdAt: result.user.metadata.creationTime,
            email: result.user.email,
            uid: result.user.uid,
            username: result.additionalUserInfo.username,
            isEmailVerified: true));

        // set user as authenticated
        state = Authenticated(user: result.user);
      } else {
        // update user
        this.userRepository.edit(
            UserModel(
              username: result.additionalUserInfo.username,
            ),
            result.user.uid);
      }
    } on PlatformException catch (error) {
      print(error);
    } catch (err) {
      Get.snackbar("Error", error.value);
    }
  }

  // google singup & login
  void signInWithApple() async {
    try {
      final result = await this.authService.signInWithApple();

      if (result.additionalUserInfo.isNewUser) {
        // goto specifique route for exemple
      } else
        state = Authenticated(user: result.user);
    } catch (e) {
      error.value = e;
      Get.snackbar("Error", error.value);
    }
  }

  // sign out
  void signOut() async {
    try {
      this.authService.signOut().then((value) => state = UnAuthenticated());

      Get.offAndToNamed("/");
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
