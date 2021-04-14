import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_fire_starter/app/controller/home.controller.dart';
import 'package:get_fire_starter/app/data/services/authentification.service.dart';

import './widgets/home_list.widget.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Text("logout"),
            onTap: () => AuthentificationService().signOut(),
          ),
        ),
        body: SafeArea(
            child: CustomScrollView(slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: 25,
              left: 25,
              right: 25,
            ),
            sliver: HomeList(),
          ),
        ])));
  }
}
