import 'package:flutter/material.dart';
import 'package:get_fire_starter/app/data/services/authentification.service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(slivers: [
      SliverAppBar(
        leading: GestureDetector(
          child: Text("logout"),
          onTap: () => AuthentificationService().signOut(),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(
          top: 25,
          left: 25,
          right: 25,
        ),
      ),
    ])));
  }
}
