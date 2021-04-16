import 'package:flutter/material.dart';
import 'package:get_fire_starter/app/ui/pages/home/widgets/home_list.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: HomeList(),
            ),
          ],
        ),
      ),
    );
  }
}
