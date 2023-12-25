import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Repository/DonnerAuthRepo/signUpRepo.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class SignUpViewModel extends GetxController {
  final SignUpRepo _signUpRepo = SignUpRepo();
  Future<void> signUpAccount(
      TextEditingController email, TextEditingController password) async {
    final result = await _signUpRepo.signUpAccount(email, password);
    if (result == null) {
      Get.offAllNamed(RoutesNames.verifyScreen);
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
