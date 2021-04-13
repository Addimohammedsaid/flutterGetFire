import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_fire_starter/app/controller/home.controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(controller.obj)),
        body: SafeArea(child: Text('HomeController')));
  }
}
