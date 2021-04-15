import 'package:flutter/material.dart';
import 'package:get_fire_starter/app/core/theme/app_color.dart';
import 'package:get_fire_starter/app/data/model/user.model.dart';

class ListItem extends StatelessWidget {
  final UserModel user;

  ListItem(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150.0,
        child: Text(
          this.user.username,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.DARK,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
