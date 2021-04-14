import 'package:get_fire_starter/app/controller/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/ui/helpers/auth.layout.dart';

class ChangePasswordPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthenticationLayout(
      title: "Reset Password",
      subtitle: "Please fill up your new password",
      onMainButtonTapped: () => controller.sendResetPassword,
      form: Column(
        children: [
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
    ));
  }
}
