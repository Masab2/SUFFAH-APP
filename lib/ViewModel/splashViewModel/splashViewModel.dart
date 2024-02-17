import 'dart:async';

import 'package:get/get.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class SplashViewModel {
  void isLogin() {
    Timer(const Duration(seconds: 3), () {
      Get.offAndToNamed(RoutesNames.choiceScreen);
    });
  }
}
