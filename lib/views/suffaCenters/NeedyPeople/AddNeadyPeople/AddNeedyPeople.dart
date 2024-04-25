import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/NeedyPeople/addNeedyPeopleViewModel.dart';
import 'package:suffa_app/res/components/CNICFormComp/CnicFormComp.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/loginOrRow/loginOrRow.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddNeedyPeople extends StatefulWidget {
  const AddNeedyPeople({super.key});

  @override
  State<AddNeedyPeople> createState() => _AddNeedyPeopleState();
}

class _AddNeedyPeopleState extends State<AddNeedyPeople> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dateofCardIssueController = TextEditingController();
  TextEditingController dateofCardExpireController = TextEditingController();
  final addNeedyController = Get.put(AddNeedyPeopleViewModel());
  late String image;
  late String phoneno;
  late String address;
  late String masjidname;
  late String id;
  late String gender;
  late String program;
  late String masjidid;
  late String masjidEmail;
  late String masjidCountry;
  late String masjidState;
  late String masjidCity;
  late String masjidaddress;
  late String donatePrice;

  @override
  void initState() {
    image = Get.arguments[0];
    phoneno = Get.arguments[1];
    address = Get.arguments[2];
    masjidname = Get.arguments[3];
    id = Get.arguments[4];
    gender = Get.arguments[5];
    program = Get.arguments[6];
    masjidid = Get.arguments[7];
    masjidEmail = Get.arguments[8];
    masjidCountry = Get.arguments[9];
    masjidState = Get.arguments[10];
    masjidCity = Get.arguments[11];
    masjidaddress = Get.arguments[12];
    donatePrice = Get.arguments[13];
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    cnicController.dispose();
    dobController.dispose();
    dateofCardIssueController.dispose();
    dateofCardExpireController.dispose();
    addNeedyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(id);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              // 0.01.ph,
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
                            fontWeight: FontWeight.bold,
                          ),
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
              0.05.ph,
              CnicFormComp(
                cardHoldername: nameController,
                doIssue: dateofCardIssueController,
                doExpire: dateofCardExpireController,
                doBirth: dobController,
                cnicno: cnicController,
              ),
              0.02.ph,
              Column(
                children: [
                  ReuseAblebtn(
                    title: 'Insert Data',
                    onPressed: () {
                      addNeedyController.addDataManually(
                        nameController,
                        cnicController,
                        dobController,
                        dateofCardIssueController,
                        dateofCardExpireController,
                        File(image),
                        phoneno,
                        address,
                        masjidname,
                        program,
                        id,
                        gender == '0' ? 'Male' : 'Female',
                        masjidid,
                        masjidEmail,
                        masjidCountry,
                        masjidState,
                        masjidCity,
                        masjidaddress,
                        donatePrice,
                        context,
                      );
                    },
                  ),
                  0.03.ph,
                  const LoginOrRow(),
                  0.03.ph,
                  ReuseAblebtn(
                    title: 'Scan ID Card',
                    onPressed: () {
                      addNeedyController.scanCnic(
                        ImageSource.camera,
                        nameController,
                        cnicController,
                        dobController,
                        dateofCardIssueController,
                        dateofCardExpireController,
                        File(image),
                        phoneno,
                        address,
                        masjidname,
                        program,
                        id,
                        gender,
                        masjidid,
                        masjidEmail,
                        masjidCountry,
                        masjidState,
                        masjidCity,
                        masjidaddress,
                        donatePrice,
                        context,
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
