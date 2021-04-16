import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/controller/auth.controller.dart';
import 'package:get_fire_starter/app/helpers/authentication_state.dart';
import 'package:get_fire_starter/app/ui/helpers/auth.layout.dart';
import 'package:get_fire_starter/app/ui/helpers/style.dart';
import 'package:validators/validators.dart';

class RegisterPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey key = GlobalKey<FormState>();
    return Scaffold(
        body: AuthenticationLayout(
      title: 'Lets Register',
      subtitle: 'Welcome !',
      busy: controller.state == AuthenticationLoading(),
      mainButtonTitle: 'Sign Up',
      onMainButtonTapped: () {
        final FormState form = key.currentState;
        if (form.validate()) {
          form.save();
          controller.createUserWithEmailAndPassword();
        } else
          print('error sign up');
      },
      form: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => controller.email = value,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(fontSize: 16.0),
              ),
              validator: (value) {
                if (!isEmail(value)) {
                  return 'Insert valid email';
                } else
                  return null;
              },
            ),
            verticalSpaceRegular,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: controller.onForgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
              ],
            ),
            verticalSpaceTiny,
            Obx(() => TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (value) => controller.password = value,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 16.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: controller.togglePasswordStatus,
                  ),
                ),
                enableSuggestions: true,
                obscureText: controller.obscureText.value,
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insert valid password';
                  } else if (value.length < 5) {
                    return 'Insert password > 5 characters';
                  } else
                    return null;
                }))
          ],
        ),
      ),
      bottomWidget: GestureDetector(
        onTap: controller.navigateToLogin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have an account?',
                style: Theme.of(context).textTheme.bodyText1),
            horizontalSpaceTiny,
            Text(
              'Login',
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    ));
  }
}
