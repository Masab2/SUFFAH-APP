import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/Donner/DonnorAuth/signUpViewModel.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/components/loginOrRow/loginOrRow.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = Get.put(SignUpViewModel());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _obscurepass.dispose();
    signUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              0.10.ph,
              Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Create Your Account',
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.034,
                        color: AppColor.mehroonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              0.04.ph,
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
                return signUpController.isLoading.value == true
                    ? const CircularProgressIndicator.adaptive()
                    : ReuseAblebtn(
                        title: 'Create Account',
                        onPressed: () {
                          signUpController.signUpAccount(
                            emailController,
                            passwordController,
                            context,
                          );
                        },
                      );
              }),
              0.03.ph,
              const LoginOrRow(),
              0.02.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Already have an Account",
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.015,
                      color: AppColor.geryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  0.01.pw,
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutesNames.loginScreen);
                    },
                    child: Text(
                      "Login",
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
