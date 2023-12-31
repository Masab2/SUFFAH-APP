import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/Admin/createEmailViewModel/CreateEmailViewModel.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class CreateEmail extends StatefulWidget {
  const CreateEmail({super.key});

  @override
  State<CreateEmail> createState() => _CreateEmailState();
}

class _CreateEmailState extends State<CreateEmail> {
  @override
  Widget build(BuildContext context) {
    final image = Get.arguments[0];
    final name = Get.arguments[1];
    final email = Get.arguments[2];
    final phone = Get.arguments[3];
    final city = Get.arguments[4];
    final country = Get.arguments[5];
    final address = Get.arguments[6];
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final createEmailController = Get.put(CreateEmailViewModel());
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomizedFeild(
          controller: emailController,
          title: 'Email',
        ),
        CustomizedFeild(
          controller: passwordController,
          title: 'Password',
        ),
        0.03.ph,
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColor.cgreenColor,
          minWidth: context.mw * 0.80,
          height: context.mh * 0.06,
          onPressed: () {
            createEmailController.createEmail(File(image), name, email, phone,
                city, country, address, emailController, passwordController);
          },
          child: Text(
            'Register Masjid',
            style:
                GoogleFonts.poppins(color: AppColor.whiteColor, fontSize: 16),
          ),
        ),
      ],
    ));
  }
}
