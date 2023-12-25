import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Repository/DonnerAuthRepo/loginRepo.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class LoginViewModel extends GetxController {
  final _loginRepo = LoginRepo();

  Future<void> loginAccount(
      TextEditingController email, TextEditingController password) async {
    final result = await _loginRepo.loginAccount(email, password);
    if (result == null) {
      Get.offAllNamed(RoutesNames.homeScreen);
    } else {
      Get.snackbar('Error', result.toString());
    }
  }

  // Google SignUp
  Future<void> googleLogin() async {
    Apis.signUpWithGoogle().then((value) {
      Get.offAllNamed(RoutesNames.homeScreen);
    }).onError((error, stackTrace) {
      Get.snackbar('Error', error.toString());
    });
  }

  void logOutAccount() {
    Apis.logOutAccount().then((value) {
      Get.offAllNamed(RoutesNames.loginScreen);
    }).onError((error, stackTrace) {
      Get.snackbar('Error', error.toString());
    });
  }
}
