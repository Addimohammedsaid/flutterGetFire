import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.controller.dart';

class AppPage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: Center(child: Text('GET FIRE FLUTTRER'))));
  }
}
