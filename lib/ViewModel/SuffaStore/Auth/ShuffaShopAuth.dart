import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Repository/SuffahStoreRepos/AuthRepo/SuffahStoreAuthRepo.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class ShuffaShopAuthViewModel extends GetxController {
  final SuffaStoreAuthRepo _authRepo = SuffaStoreAuthRepo();
  Rx<bool> isLoading = false.obs;
  Future<void> suffaLoginAccount(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    try {
      isLoading(true);
      final result =
          await _authRepo.suffaStoreLoginAccount(email, password, context);
      if (result == null) {
        email.clear();
        password.clear();
        final futures = await Future.wait([
          SharePrefs.getShopID('Shopid'),
          SharePrefs.getShopID('Shopname'),
        ]);
        final shopname = futures[1];
        Get.toNamed(RoutesNames.suffahStoreDashBoardScreen, arguments: [
          shopname,
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
