import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/Registered%20Shops/AddAlShuffahShopsViewModel.dart';
import 'package:suffa_app/res/components/CNICFormComp/CnicFormComp.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/loginOrRow/loginOrRow.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddSuffahShopCnic extends StatefulWidget {
  const AddSuffahShopCnic({super.key});

  @override
  State<AddSuffahShopCnic> createState() => _AddSuffahShopCnicState();
}

class _AddSuffahShopCnicState extends State<AddSuffahShopCnic> {
  var cnicnoController = TextEditingController();
  var doIssueController = TextEditingController();
  var doExpireController = TextEditingController();
  var dobController = TextEditingController();
  var holdernameController = TextEditingController();
  late String shopTitle;
  late String phonenno;
  late String emailAddress;

  late String address;
  late String imagePath;
  late String muntazimId;
  late String masjidId;
  late String masjidname;
  final controller = Get.find<AddAlsuffahShopsViewModel>();
  @override
  void initState() {
    shopTitle = Get.arguments[0] ?? "";
    phonenno = Get.arguments[1] ?? "";
    emailAddress = Get.arguments[2] ?? "";
    address = Get.arguments[3] ?? "";
    imagePath = Get.arguments[4] ?? "";
    muntazimId = Get.arguments[5] ?? "";
    masjidId = Get.arguments[6] ?? "";
    masjidname = Get.arguments[7] ?? "";
    super.initState();
  }

  @override
  void dispose() {
    cnicnoController.dispose();
    doIssueController.dispose();
    doExpireController.dispose();
    dobController.dispose();
    holdernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Enter The ID Cards Details',
                        style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.018,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'To Verify Your Details Please Enter Your CNIC Details',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.013,
                          fontWeight: FontWeight.w400,
                          color: AppColor.geryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            0.02.ph,
            CnicFormComp(
              cardHoldername: holdernameController,
              doIssue: doIssueController,
              doExpire: doExpireController,
              doBirth: dobController,
              cnicno: cnicnoController,
            ),
            Column(
              children: [
                ReuseAblebtn(
                  title: 'Insert Data',
                  onPressed: () {
                    controller.addDataManuallyInDB(
                      holdernameController,
                      cnicnoController,
                      dobController,
                      doIssueController,
                      doExpireController,
                      shopTitle,
                      address,
                      phonenno,
                      muntazimId,
                      masjidId,
                      masjidname,
                      emailAddress,
                    );
                  },
                ),
                const LoginOrRow(),
                ReuseAblebtn(
                  title: 'Scan ID Card',
                  onPressed: () {
                    controller.scanID(
                      ImageSource.camera,
                      holdernameController,
                      cnicnoController,
                      dobController,
                      doIssueController,
                      doExpireController,
                      shopTitle,
                      address,
                      phonenno,
                      muntazimId,
                      masjidId,
                      masjidname,
                      emailAddress,
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
