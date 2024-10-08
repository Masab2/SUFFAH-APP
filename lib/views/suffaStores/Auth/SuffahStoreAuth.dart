// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/SuffaStore/Auth/ShuffaShopAuth.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SuffahStoreLoginDashBoard extends StatefulWidget {
  const SuffahStoreLoginDashBoard({super.key});

  @override
  State<SuffahStoreLoginDashBoard> createState() =>
      _SuffahStoreLoginDashBoardState();
}

class _SuffahStoreLoginDashBoardState extends State<SuffahStoreLoginDashBoard> {
  final suffahAuthController = Get.put(ShuffaShopAuthViewModel());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurepass = ValueNotifier(true);
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _obscurepass.dispose();
    suffahAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                      l10n!.portalThreeAdmin,
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
                      l10n.loginTitle,
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
                title: l10n.emailHint,
                hint: 'abc@gmail.com',
              ),
              0.03.ph,
              ValueListenableBuilder(
                valueListenable: _obscurepass,
                builder: (context, value, child) {
                  return CustomizedFeild(
                    title: l10n.passwordHint,
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
                return suffahAuthController.isLoading.value == true
                    ? const CircularProgressIndicator.adaptive()
                    : ReuseAblebtn(
                        title: l10n.loginButton,
                        onPressed: () {
                          suffahAuthController.suffaLoginAccount(
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
