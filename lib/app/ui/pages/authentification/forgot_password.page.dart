import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import '../../helpers/auth.layout.dart';
import 'package:get_fire_starter/app/controller/auth.controller.dart';

class ForgotPasswordPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationLayout(
        title: "Reset Password",
        subtitle: "Please fill up your email",
        onMainButtonTapped: () => controller.sendResetPassword,
        form: Column(
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
          ],
        ),
      ),
    );
  }
}
