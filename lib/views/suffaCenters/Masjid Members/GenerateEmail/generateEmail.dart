import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/AddMasjidMembers/generateEmailAddress.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class GenerateEmailSuffaMembers extends StatefulWidget {
  const GenerateEmailSuffaMembers({super.key});

  @override
  State<GenerateEmailSuffaMembers> createState() =>
      _GenerateEmailSuffaMembersState();
}

class _GenerateEmailSuffaMembersState extends State<GenerateEmailSuffaMembers> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final createEmailController =
      Get.put(CreateEmailAddressSuffaMembersViewModel());
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
    final masjidid = Get.arguments[7];
    final state = Get.arguments[8];

    return Scaffold(
        appBar: AppBar(
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
                  color: AppColor.mehroonColor,
                ),
                controller: emailController,
                title: 'Email',
                hint: 'abc@suffacenter.com',
              ),
              CustomizedFeild(
                prefixIcon: const Icon(
                  IconlyBold.password,
                  color: AppColor.mehroonColor,
                ),
                controller: passwordController,
                title: 'Password',
                hint: '*******',
              ),
              0.03.ph,
              ReuseAblebtn(
                title: 'Generate Email',
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
                    masjidid,
                    state,
                    context,
                  );
                },
              )
            ],
          ),
        ));
  }
}
