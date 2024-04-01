import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../../res/routes/routesNames.dart';

class SplashChoices extends StatelessWidget {
  const SplashChoices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.08.ph,
            Text(
              'Welcome To!',
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.030,
                fontWeight: FontWeight.bold,
                color: AppColor.mehroonColor,
              ),
            ),
            0.04.ph,
            Image(
              image: AssetImage(
                ImageAsset.applogo,
              ),
            ),
            0.06.ph,
            ReuseAblebtn(
              title: 'Login',
              onPressed: () {
                Get.offAndToNamed(RoutesNames.loginScreen);
              },
            ),
            0.04.ph,
            ReuseAblebtn(
              title: 'Sign Up',
              color: AppColor.brownColor,
              onPressed: () {
                Get.offAndToNamed(RoutesNames.signUpScreen);
              },
            )
          ],
        ),
      ),
    );
  }
}
