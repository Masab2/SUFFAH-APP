import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/Registered%20Shops/AddAlShuffahShopsViewModel.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class GenUserNamePassShopScreen extends StatefulWidget {
  const GenUserNamePassShopScreen({super.key});

  @override
  State<GenUserNamePassShopScreen> createState() =>
      _GenUserNamePassShopScreenState();
}

class _GenUserNamePassShopScreenState extends State<GenUserNamePassShopScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final controller = Get.find<AddAlsuffahShopsViewModel>();
  late String name;
  late String cnicno;
  late String dob;
  late String doCardIssue;
  late String doCardExpire;
  late dynamic image;
  late String shopTitle;
  late String address;
  late String country;
  late String city;
  late String state;
  late String phone;
  late String muntazimId;
  late String masjidid;
  late String masjidname;
  late String email;
  late String program;
  @override
  void initState() {
    name = Get.arguments[0];
    cnicno = Get.arguments[1];
    dob = Get.arguments[2];
    doCardIssue = Get.arguments[3];
    doCardExpire = Get.arguments[4];
    image = Get.arguments[5] ?? '';
    shopTitle = Get.arguments[6];
    address = Get.arguments[7];
    country = Get.arguments[8];
    city = Get.arguments[9];
    phone = Get.arguments[10];
    muntazimId = Get.arguments[11];
    masjidid = Get.arguments[12];
    masjidname = Get.arguments[13];
    email = Get.arguments[14];
    state = Get.arguments[15];
    program = Get.arguments[16];
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Generate Username',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            Image(
              height: context.mh * 0.40,
              image: AssetImage(ImageAsset.verifyemail),
            ),
            CustomizedFeild(
              prefixIcon: const Icon(
                IconlyBold.user_2,
                color: AppColor.cgreenColor,
              ),
              controller: emailController,
              title: 'Username',
              hint: '',
            ),
            CustomizedFeild(
              prefixIcon: const Icon(
                IconlyBold.password,
                color: AppColor.cgreenColor,
              ),
              controller: passController,
              title: 'Password',
              hint: '*******',
            ),
            0.03.ph,
            ReuseAblebtn(
              title: 'Add Shop',
              onPressed: () {
                controller.genUserAndSendEmail(
                  name,
                  cnicno,
                  dob,
                  doCardIssue,
                  doCardExpire,
                  File(image.toString()),
                  shopTitle,
                  address,
                  phone,
                  muntazimId,
                  masjidid,
                  masjidname,
                  emailController,
                  passController,
                  email,
                  program,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
