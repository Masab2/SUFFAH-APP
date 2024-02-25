import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  late Timer timer ;
  @override
  void initState() {
    Apis.user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(ImageAsset.verifyemail)),
          0.02.ph,
          RichText(
            text: TextSpan(
              text: 'Verification Link is Send to ',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, color: AppColor.geryColor),
              children: [
                TextSpan(
                  text: '${Apis.user.email}',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, color: AppColor.cgreenColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    await Apis.user.reload();
    if (Apis.user.emailVerified) {
      timer.cancel();
      Get.offAndToNamed(RoutesNames.bottomNavbarScreen);
    }
  }
}
