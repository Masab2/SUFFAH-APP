// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/SuffaCenterAuth/suffaCenterAuth.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/components/loginOrRow/loginOrRow.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SuffahCenterLoginDashBoard extends StatefulWidget {
  const SuffahCenterLoginDashBoard({super.key});

  @override
  State<SuffahCenterLoginDashBoard> createState() =>
      _SuffahCenterLoginDashBoardState();
}

class _SuffahCenterLoginDashBoardState
    extends State<SuffahCenterLoginDashBoard> {
  final suffaCenterAuthController = Get.put(SuffaCenterAuthViewModel());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _obscurepass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              0.15.ph,
              Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Al-Suffah Center',
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.024,
                        color: AppColor.mehroonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Login Here',
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.018,
                        color: AppColor.mehroonColor,
                        fontWeight: FontWeight.w500,
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
                                color: AppColor.brownColor,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: AppColor.brownColor,
                              )),
                    controller: passwordController,
                  );
                },
              ),
              0.06.ph,
              Obx(() {
                return suffaCenterAuthController.isLoading.value == true
                    ? const CircularProgressIndicator.adaptive()
                    : ReuseAblebtn(
                        title: 'Login',
                        onPressed: () {
                          suffaCenterAuthController.suffaLoginAccount(
                              emailController, passwordController, context);
                        },
                      );
              }),
              0.03.ph,
            ],
          ),
        ));
  }
}
