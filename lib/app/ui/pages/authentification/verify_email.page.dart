import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_fire_starter/app/controller/verify_email.controller.dart';
import 'package:get_fire_starter/app/ui/helpers/auth.layout.dart';

class VerifyEmailPage extends GetView<VerifyEmailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => AuthenticationLayout(
        title: "Email Verification",
        subtitle: "Please verify your email.",
        mainButtonTitle: controller.countDown != null
            ? controller.countDown.toString()
            : "Resend Mail",
        onMainButtonTapped: () => controller.sendMailFunc.value(),
        form: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${controller.email}",
                style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
        bottomWidget: Text("Did not receive the email? Check your spam filter.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1),
      ),
    ));
  }
}

void showNoMailAppsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Open Mail App"),
        content: Text("No mail apps installed"),
        actions: <Widget>[
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
