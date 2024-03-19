import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/Admin/AddSuffahCenter/AddSuffahCenterViewModel.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
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
  final addSuffacenterController = Get.find<AddSuffahCenterViewModel>();

  late String image;
  late String name;
  late String email;
  late String phone;
  late String city;
  late String country;
  late String address;
  late String masjidname;
  late String state;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    image = Get.arguments[0];
    name = Get.arguments[1];
    email = Get.arguments[2];
    phone = Get.arguments[3];
    city = Get.arguments[4];
    country = Get.arguments[5];
    address = Get.arguments[6];
    masjidname = Get.arguments[7];
    state = Get.arguments[8];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
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
              image: AssetImage(ImageAsset.applogo),
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
              title: 'Register Masjid',
              onPressed: () {
                addSuffacenterController.createEmail(
                  File(image),
                  name,
                  email,
                  phone,
                  city,
                  country,
                  address,
                  emailController,
                  passwordController,
                  masjidname,
                  state,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
