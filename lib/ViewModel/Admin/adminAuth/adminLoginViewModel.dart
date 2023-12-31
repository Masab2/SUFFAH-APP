// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Repository/AdminRepo/adminAuthRepo/adminAuthrepo.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/Utils.dart';

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
      final result = await _adminLoginRepo.adminLoginAccount(
        TextEditingController(text: email.text),
        TextEditingController(text: password.text),
        () {
          final emailDomain = email.text.split('@').last;
          switch (emailDomain) {
            case 'admin.com':
              Get.offAndToNamed(RoutesNames.adminDashBoardScreen);
              break;
            case 'suffacenter.com':
              Get.offAndToNamed(RoutesNames.suffacenterDashBoardScreen);
              break;
            case 'suffastore.com':
              // Handle suffastore.com case
              break;
            default:
              Get.snackbar(
                  'UnAuthorized', 'Please Enter the Authorized Domain');
          }
        },
      );
      if (result != null) {
        Get.snackbar('Error', result.toString());
      }
    } finally {
      isLoading(false);
    }
  }
}
