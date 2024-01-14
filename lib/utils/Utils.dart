import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class Utils {
  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // Blur Dialog For LogOut
  static showBlurDialog(
      BuildContext context,
      VoidCallback ontap,
      TextEditingController emailcontroller,
      TextEditingController passwordController) {
    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: context.mw * 0.30,
                      color: AppColor.cgreenColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: ontap,
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(color: AppColor.whiteColor),
                      ),
                    ),
                    0.02.pw,
                  ],
                )
              ],
              backgroundColor: AppColor.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: context.mw * 0.03, vertical: context.mh * 0.01),
              title: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Login First',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, color: AppColor.cgreenColor),
                ),
              ),
              titlePadding: EdgeInsets.symmetric(
                  horizontal: context.mw * 0.03, vertical: context.mh * 0.03),
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomizedFeild(
                        title: 'Email Address', controller: emailcontroller),
                    CustomizedFeild(
                        title: 'Password', controller: passwordController),
                    0.01.ph,
                  ],
                ),
              ),
            ));
      },
    );
  }
}
