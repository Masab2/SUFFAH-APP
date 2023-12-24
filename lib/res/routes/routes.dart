import 'package:get/get.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/views/Auth/VerifyScreen/verifyScreen.dart';
import 'package:suffa_app/views/Auth/login/login.dart';
import 'package:suffa_app/views/Auth/signup/signUpScreen.dart';
import 'package:suffa_app/views/Donners/HomeScreen.dart';
import 'package:suffa_app/views/splashView/splashView.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RoutesNames.splashScreen,
            page: () => const SplashView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.loginScreen,
            page: () => const LoginView(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.signUpScreen,
            page: () => const SignUpScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.verifyScreen,
            page: () => const VerifyScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.homeScreen,
            page: () => const HomeScreen(),
            transition: Transition.leftToRight)
      ];
}
