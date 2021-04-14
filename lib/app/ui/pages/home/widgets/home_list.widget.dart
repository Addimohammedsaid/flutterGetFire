import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/controller/home.controller.dart';

import './list_item.widget.dart';

class HomeList extends StatelessWidget {
  final double itemHeight = 150;
  final double itemWidth = Get.width / 2 - 100;

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (controller) {
        final users = controller.users;
        if (controller != null && controller.users != null) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 25.0,
                crossAxisSpacing: 25.0,
                childAspectRatio: itemWidth / itemHeight),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListItem(users[index]);
              },
              childCount: users.length ?? 0,
            ),
          );
        } else {
          return Text("loading...");
        }
      },
    );
  }
}
