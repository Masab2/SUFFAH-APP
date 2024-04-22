// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/ViewModel/Donner/DonnorAuth/loginViewModel.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/components/loginOrRow/loginOrRow.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = Get.put(LoginViewModel());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _obscurepass.dispose();
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              0.25.ph,
              Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'DONNER LOGIN',
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.034,
                        color: AppColor.mehroonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.020,
                      color: AppColor.mehroonColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              0.02.ph,
              CustomizedFeild(
                controller: emailController,
                title: 'Email',
                hint: 'abc@gmail.com',
              ),
              0.03.ph,
              ValueListenableBuilder(
                valueListenable: _obscurepass,
                builder: (context, value, child) {
                  return CustomizedFeild(
                    title: 'Password',
                    hint: '6 character/digit',
                    obscuretext: _obscurepass.value,
                    sufixIcon: InkWell(
                        onTap: () {
                          _obscurepass.value = !_obscurepass.value;
                        },
                        child: _obscurepass.value
                            ? const Icon(
                                Icons.visibility_off,
                                color: AppColor.mehroonColor,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: AppColor.mehroonColor,
                              )),
                    controller: passwordController,
                  );
                },
              ),
              0.06.ph,
              Obx(() {
                return loginController.isLoading == true
                    ? const CircularProgressIndicator.adaptive()
                    : ReuseAblebtn(
                        title: 'Login',
                        onPressed: () {
                          loginController.loginAccount(
                              emailController, passwordController, context);
                        },
                      );
              }),
              0.03.ph,
              const LoginOrRow(),
              0.03.ph,
              GoogleSignbtn(
                color: AppColor.brownColor,
                title: 'Sign in With Google',
                onPressed: () {
                  loginController.googleLogin();
                },
              ),
              0.02.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Don't have an account",
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.015,
                      color: AppColor.geryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  0.01.pw,
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutesNames.signUpScreen);
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.roboto(
                        fontSize: context.mh * 0.014,
                        color: AppColor.mehroonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
