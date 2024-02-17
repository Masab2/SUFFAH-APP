// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:suffa_app/ViewModel/Donner/DonnorAuth/loginViewModel.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/components/loginOrRow/loginOrRow.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

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
      body: Stack(
        children: [
          Container(
            height: context.mh * 0.55,
            decoration: const BoxDecoration(
                color: AppColor.cgreenColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )),
          ),
          Positioned(
              top: context.mh * 0.04,
              right: context.mw * 0.05,
              left: context.mw * 0.05,
              child: Image(image: AssetImage(ImageAsset.applogobackremove))),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: EdgeInsets.only(
                top: context.mh * 0.33,
                left: context.mw * 0.05,
                right: context.mw * 0.05,
              ),
              child: Container(
                height: context.mh * 0.60,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        0.02.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              color: Colors.grey[500],
                              onPressed: () {
                                Get.toNamed(RoutesNames.loginDashBoardScreen);
                              },
                              icon: const Icon(
                                Icons.admin_panel_settings_rounded,
                              ),
                            ),
                            0.03.pw,
                          ],
                        ),
                        0.01.ph,
                        Text(
                          'Sign In to your account',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        0.03.ph,
                        CustomizedFeild(
                            controller: emailController,
                            title: 'Email',
                            hint: 'abc@gmail.com',
                            prefixIcon: const Icon(
                              IconlyBold.message,
                              color: AppColor.cgreenColor,
                            )),
                        0.02.ph,
                        ValueListenableBuilder(
                          valueListenable: _obscurepass,
                          builder: (context, value, child) {
                            return CustomizedFeild(
                              title: 'Password',
                              hint: '6 character/digit',
                              prefixIcon: const Icon(
                                IconlyBold.password,
                                color: AppColor.cgreenColor,
                              ),
                              obscuretext: _obscurepass.value,
                              sufixIcon: InkWell(
                                  onTap: () {
                                    _obscurepass.value = !_obscurepass.value;
                                  },
                                  child: _obscurepass.value
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: AppColor.cgreenColor,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: AppColor.cgreenColor,
                                        )),
                              controller: passwordController,
                            );
                          },
                        ),
                        0.02.ph,
                        Obx(() {
                          return loginController.isLoading == true
                              ? const CircularProgressIndicator.adaptive()
                              : ReuseAblebtn(
                                  title: 'Login',
                                  onPressed: () {
                                    loginController.loginAccount(
                                        emailController, passwordController);
                                  },
                                );
                        }),
                        0.01.ph,
                        const LoginOrRow(),
                        0.01.ph,
                        Row(
                          children: [
                            0.06.pw,
                            Expanded(
                              child: SignInButton(
                                padding: context.mh * 0.01,
                                imagePosition: ImagePosition.right,
                                btnColor: AppColor.geryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                buttonType: ButtonType.google,
                                onPressed: () {
                                  loginController.googleLogin();
                                },
                              ),
                            ),
                            0.06.pw,
                          ],
                        ),
                        0.01.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Don't have an account",
                              style: GoogleFonts.roboto(
                                  fontSize: context.mh * 0.015,
                                  color: AppColor.geryColor,
                                  fontWeight: FontWeight.bold),
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
                                  color: AppColor.cgreenColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        0.005.ph,
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
