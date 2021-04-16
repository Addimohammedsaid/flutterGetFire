import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_fire_starter/app/controller/home.controller.dart';
import 'package:get_fire_starter/app/controller/verify_email.controller.dart';
import 'package:get_fire_starter/app/data/provider/cloud_firestore.provider.dart';
import 'package:get_fire_starter/app/data/repository/user.repository.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}

class UnVerifiedEmail extends AuthenticationState {
  final authService;

  UnVerifiedEmail({@required this.authService}) {
    Get.put<VerifyEmailController>(
        VerifyEmailController(authService: authService));
  }
}

class Authenticated extends AuthenticationState {
  final User user;

  Authenticated({@required this.user}) {
    Get.put<HomeController>(Get.put<HomeController>(HomeController(
        repository: UserRepository(
            apiClient: CloudFirestoreApi(collection: "users")))));
  }

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
