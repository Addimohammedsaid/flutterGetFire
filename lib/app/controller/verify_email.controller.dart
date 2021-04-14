import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/app.controller.dart';
import 'package:get_fire_starter/app/data/services/authentification.service.dart';

class VerifyEmailController extends GetxController {
  final AuthentificationService authService;

  VerifyEmailController({@required this.authService})
      : assert(authService != null);

  // used to controller navigation
  AppController appController = Get.find();

  get email => this.authService.user.email;

  // for setting waiting time
  Timer _timer;
  get timer => this._timer;

  // countdown to resend mail
  RxInt _countDown = RxInt(null);
  get countDown => this._countDown.value;

  RxBool _busy = RxBool(false);
  get busy => this._busy.value;

  // change time to reload user here
  Duration timeToReloadUser = Duration(seconds: 10);

  // function to allow button resend mail
  Rx<Function> sendMailFunc = Rx<Function>(null);

  @override
  void onInit() {
    // lock navigation
    appController.allowVerifyEmail = false;

    this.sendMail();

    this.sendMailFunc.value = this.timerFunction();

    // check user is verfied
    // every 10 seconds
    this._timer = new Timer(timeToReloadUser, reload);

    super.onInit();
  }

  reload() {
    // email verification can't be listend to
    this.authService.reloadUser();

    if (this.authService.isVerifiedEmail()) {
      // do somthing if verified.....
    }
  }

  sendMail() async {
    if (await authService.sendEmailVerification()) {
      print("email sent");
    }
  }

  Future<bool> Function() timerFunction() {
    return () async {
      print("begin countDown...");
      // send email
      this.sendMail();

      this._countDown.value = 60;

      // disable resend
      this.sendMailFunc.value = null;

      // set timer
      new Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) {
          if (this._countDown.value == 0) {
            // reset countDown
            this._countDown.value = null;

            // stop the function
            timer.cancel();
          } else {
            this._countDown.value--;
          }
        },
      );
      return true;
    };
  }

  @override
  void dispose() {
    this._timer.cancel();
    super.dispose();
  }
}
