import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/controller/auth.controller.dart';
import 'package:get_fire_starter/app/ui/helpers/style.dart';
import 'package:get_fire_starter/app/ui/widgets/social_buttons.widget.dart';

class WelcomePage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeightPercentage(context, percentage: 0.4)),
            GestureDetector(
              onTap: () => Get.toNamed("/register"),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: controller.busy.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : Text(
                        "Sign Up with email",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
              ),
            ),
            verticalSpaceRegular,
            SocialButtonsWidget(),
          ],
        ),
      ),
    ));
  }
}
