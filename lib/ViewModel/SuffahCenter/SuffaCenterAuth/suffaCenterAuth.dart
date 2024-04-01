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
          SharePrefs.getData('id'),
          SharePrefs.getData('masjidName'),
          SharePrefs.getData('centerId'),
          SharePrefs.getData('email'),
          SharePrefs.getData('country'),
          SharePrefs.getData('state'),
          SharePrefs.getData('city'),
          SharePrefs.getData('address'),
        ]);
        final userId = futures[0];
        final masjidName = futures[1];
        final centerId = futures[2];
        final muntazimEmail = futures[3];
        final country = futures[4];
        final state = futures[5];
        final city = futures[6];
        final address = futures[7];
        log(masjidName);
        Get.toNamed(RoutesNames.suffacenterDashBoardScreen, arguments: [
          userId,
          masjidName,
          centerId,
          muntazimEmail,
          country,
          state,
          city,
          address,
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
