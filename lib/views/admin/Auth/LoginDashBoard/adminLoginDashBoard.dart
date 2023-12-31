// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/Admin/adminAuth/adminLoginViewModel.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AdminLoginDashBoard extends StatefulWidget {
  const AdminLoginDashBoard({super.key});

  @override
  State<AdminLoginDashBoard> createState() => _AdminLoginDashBoardState();
}

class _AdminLoginDashBoardState extends State<AdminLoginDashBoard> {
  final adminAuthController = Get.put(AdminLoginViewModel());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _obscurepass.dispose();
    adminAuthController.dispose();
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
              top: context.mh * 0.0002,
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
                height: context.mh * 0.50,
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
                          'For Admin Login',
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
                        Obx(() {
                          return adminAuthController.isLoading == true
                              ? const CircularProgressIndicator.adaptive()
                              : MaterialButton(
                                  height: context.mh * 0.05,
                                  minWidth: context.mw * 0.80,
                                  color: AppColor.cgreenColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    adminAuthController.adminLoginAccount(
                                        emailController,
                                        passwordController,
                                        context);
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                        color: AppColor.whiteColor),
                                  ),
                                );
                        })
                      ]),
                ),
              ),
            ),
          ),
          Positioned(
              top: context.mh * 0.07,
              left: context.mw * 0.04,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(IconlyBold.arrow_left_circle,
                      color: AppColor.whiteColor))),
        ],
      ),
    );
  }
}
