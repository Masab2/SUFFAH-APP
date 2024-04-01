import 'dart:async';

import 'package:get/get.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class SplashViewModel extends GetxController {
  void isLogin() {
    if (Apis.auth.currentUser != null) {
      Timer(const Duration(seconds: 4), () {
        Get.offAndToNamed(RoutesNames.bottomNavbarScreen);
      });
    } else {
      Timer(const Duration(seconds: 4), () {
        Get.offAndToNamed(RoutesNames.splashChoices);
      });
    }
  }
}
