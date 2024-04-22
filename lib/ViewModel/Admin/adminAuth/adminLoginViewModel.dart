// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Repository/AdminRepo/adminAuthRepo/adminAuthrepo.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class AdminLoginViewModel extends GetxController {
  final AdminAuthRepo _adminLoginRepo = AdminAuthRepo();

  RxBool isLoading = false.obs;

  Future<void> adminLoginAccount(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    try {
      isLoading(true);
      final result = await _adminLoginRepo.adminLoginAccount(email, password,context);
      if (result == null) {
        email.clear();
        password.clear();
        Get.toNamed(RoutesNames.adminDashBoardScreen);
      }else{
        Get.snackbar('Error', result);
      }
    } finally {
      isLoading(false);
    }
  }
}
