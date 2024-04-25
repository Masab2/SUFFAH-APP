import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Repository/DonnerAuthRepo/signUpRepo.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class SignUpViewModel extends GetxController {
  final SignUpRepo _signUpRepo = SignUpRepo();
  RxBool isLoading = false.obs;
  Future<void> signUpAccount(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    try {
      isLoading(true);
      final result = await _signUpRepo.signUpAccount(
        email,
        password,
        context,
      );
      if (result == null) {
        log("Sign Up");
        Get.offAllNamed(RoutesNames.verifyScreen);
      } else {
        Get.snackbar('Error', result);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
