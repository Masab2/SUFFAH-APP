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
        final futures = await Future.wait([
          SharePrefs.getId('id'),
          SharePrefs.getMasjid('masjidName'), // Use getString instead of getId
          SharePrefs.getMasjidID('centerId'), // Use getString instead of getId
        ]);
        final userId = futures[0];
        final masjidName = futures[1];
        final centerId = futures[2];
        log(masjidName);
        Get.toNamed(RoutesNames.suffacenterDashBoardScreen, arguments: [
          userId,
          masjidName,
          centerId,
        ]);
      } else {
        log(result.toString());
        Get.snackbar('Error', result.toString());
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
