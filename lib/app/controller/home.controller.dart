import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/data/model/user.model.dart';
import 'package:get_fire_starter/app/data/repository/user.repository.dart';

class HomeController extends GetxController {
  final UserRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

// list of all story will be saved here
  RxList<UserModel> users = RxList<UserModel>([]);

  @override
  void onInit() {
    //stream coming from firebase
    users.bindStream(repository.getStreamAll());

    super.onInit();
  }
}
