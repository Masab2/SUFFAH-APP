import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/Admin/createEmailViewModel/CreateEmailViewModel.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';

class CreateEmail extends StatefulWidget {
  const CreateEmail({super.key});

  @override
  State<CreateEmail> createState() => _CreateEmailState();
}

class _CreateEmailState extends State<CreateEmail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final createEmailController = Get.put(CreateEmailViewModel());
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    createEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = Get.arguments[0];
    final name = Get.arguments[1];
    final email = Get.arguments[2];
    final phone = Get.arguments[3];
    final city = Get.arguments[4];
    final country = Get.arguments[5];
    final address = Get.arguments[6];
    final masjidname = Get.arguments[7];

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(IconlyBold.arrow_left_circle)),
          title: Text(
            'Generate Email',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                height: context.mh * 0.40,
                image: AssetImage(ImageAsset.verifyemail),
              ),
              CustomizedFeild(
                prefixIcon: const Icon(
                  IconlyBold.message,
                  color: AppColor.cgreenColor,
                ),
                controller: emailController,
                title: 'Email',
                hint: 'abc@suffacenter.com',
              ),
              CustomizedFeild(
                prefixIcon: const Icon(
                  IconlyBold.password,
                  color: AppColor.cgreenColor,
                ),
                controller: passwordController,
                title: 'Password',
                hint: '*******',
              ),
              0.03.ph,
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppColor.cgreenColor,
                minWidth: context.mw * 0.80,
                height: context.mh * 0.06,
                onPressed: () {
                  createEmailController.createEmail(
                      File(image),
                      name,
                      email,
                      phone,
                      city,
                      country,
                      address,
                      emailController,
                      passwordController,
                      image,
                      masjidname);
                },
                child: Text(
                  'Register Masjid',
                  style: GoogleFonts.poppins(
                      color: AppColor.whiteColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }
}
