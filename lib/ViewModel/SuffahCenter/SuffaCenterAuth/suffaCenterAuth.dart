import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/SuffahCenterAuthRepo/SuffahCenterAuthRepo.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class SuffaCenterAuthViewModel extends GetxController {
  final ShuffaCenterAuthRepo _adminLoginRepo = ShuffaCenterAuthRepo();

  RxBool isLoading = false.obs;

  Future<void> suffaLoginAccount(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    try {
      isLoading(true);
      final result = await _adminLoginRepo.suffahLoginAccount(email, password);
      if (result == null) {
        email.clear();
        password.clear();
        await SharePrefs.getId('id').then((value) {
          Get.toNamed(RoutesNames.suffacenterDashBoardScreen, arguments: value);
        });
      } else {
        Get.snackbar('Error', result.toString());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
