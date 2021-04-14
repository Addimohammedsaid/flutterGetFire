import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_fire_starter/app/controller/verify_email.controller.dart';
import 'package:get_fire_starter/app/ui/helpers/auth.layout.dart';
import 'package:get_fire_starter/app/ui/helpers/style.dart';
import 'package:open_mail_app/open_mail_app.dart';

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
            verticalSpaceRegular,
            GestureDetector(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: controller.busy
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : Text(
                        "Open email app",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
              ),
              onTap: () async {
                // Android: Will open mail app or show native picker.
                // iOS: Will open mail app if single mail app found.
                var result = await OpenMailApp.openMailApp();

                // If no mail apps found, show error
                if (!result.didOpen && !result.canOpen) {
                  showNoMailAppsDialog(context);

                  // iOS: if multiple mail apps found, show dialog to select.
                  // There is no native intent/default app system in iOS so
                  // you have to do it yourself.
                } else if (!result.didOpen && result.canOpen) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return MailAppPickerDialog(
                        mailApps: result.options,
                      );
                    },
                  );
                }
              },
            ),
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
