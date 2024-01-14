import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/Donner/DonnorAuth/signUpViewModel.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
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
              top: context.mh * 0.002,
              right: context.mw * 0.05,
              left: context.mw * 0.05,
              child: Image(image: AssetImage(ImageAsset.applogo))),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: EdgeInsets.only(
                top: context.mh * 0.35,
                left: context.mw * 0.05,
                right: context.mw * 0.05,
              ),
              child: Container(
                height: context.mh * 0.55,
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
                        0.04.ph,
                        Text(
                          'Create your account',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
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
                        0.03.ph,
                        MaterialButton(
                          height: context.mh * 0.05,
                          minWidth: context.mw * 0.80,
                          color: AppColor.cgreenColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            signUpController.signUpAccount(
                                emailController, passwordController);
                          },
                          child: Text(
                            'Create Account',
                            style:
                                GoogleFonts.poppins(color: AppColor.whiteColor),
                          ),
                        ),
                        0.02.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account",
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: AppColor.geryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            0.01.pw,
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Login",
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    color: AppColor.cgreenColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ),
          Positioned(
              top: context.mh * 0.06,
              left: context.mw * 0.04,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(IconlyBold.arrow_left))),
        ],
      ),
    );
  }
}
