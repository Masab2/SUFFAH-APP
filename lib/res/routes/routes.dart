import 'package:get/get.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/views/Auth/VerifyScreen/verifyScreen.dart';
import 'package:suffa_app/views/Auth/login/login.dart';
import 'package:suffa_app/views/Auth/signup/signUpScreen.dart';
import 'package:suffa_app/views/Donners/HomeScreen.dart';
import 'package:suffa_app/views/admin/Auth/LoginDashBoard/adminLoginDashBoard.dart';
import 'package:suffa_app/views/admin/DashBoard/adminDashboard.dart';
import 'package:suffa_app/views/admin/SuffahCenter/ViewSuffahCenter.dart';
import 'package:suffa_app/views/admin/SuffahCenter/addSuffahCenter.dart';
import 'package:suffa_app/views/admin/SuffahCenter/createEmailView.dart';
import 'package:suffa_app/views/splashView/splashView.dart';
import 'package:suffa_app/views/suffaCenters/DashBoard/suffacenterDashboard.dart';

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

        // Donner DashBoard
        GetPage(
            name: RoutesNames.homeScreen,
            page: () => const HomeScreen(),
            transition: Transition.leftToRight),

        // Adminstration Auth landing page
        GetPage(
            name: RoutesNames.loginDashBoardScreen,
            page: () => const AdminLoginDashBoard(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.adminDashBoardScreen,
            page: () => const AdminDashBoard(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.viewSuffahCenterScreen,
            page: () => const ViewSuffahCenter(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.addSuffahCenterScreen,
            page: () => const AddSuffahCenter(),
            transition: Transition.leftToRight),
        GetPage(
            name: RoutesNames.createEmailScreen,
            page: () => const CreateEmail(),
            transition: Transition.leftToRight),

        // Suffa Center DashBoard
        GetPage(
            name: RoutesNames.suffacenterDashBoardScreen,
            page: () => const SuffaCenterDashboard(),
            transition: Transition.leftToRight),
      ];
}
