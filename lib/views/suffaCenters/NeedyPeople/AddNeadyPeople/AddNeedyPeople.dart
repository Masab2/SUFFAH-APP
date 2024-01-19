import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/NeedyPeople/addNeedyPeopleViewModel.dart';
import 'package:suffa_app/res/components/AddNeedyPeople/addNeedyPeopleComp.dart';
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
    final image = Get.arguments[0];
    final phoneno = Get.arguments[1];
    final address = Get.arguments[2];
    final masjidname = Get.arguments[3];
    final id = Get.arguments[4];
    final gender = Get.arguments[5];
    final program = Get.arguments[6];
    log(id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(IconlyBold.arrow_left_circle)),
      ),
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
                              fontSize: 17, fontWeight: FontWeight.bold),
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
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColor.geryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              0.05.ph,
              AddNeedyPeopleComp(
                  title: 'Card Holder Name',
                  icon: Icons.person,
                  hint: 'Masab / Ayesha',
                  controller: nameController),
              AddNeedyPeopleComp(
                  title: 'CNIC Number',
                  icon: Icons.person,
                  hint: '352020-4545452-1',
                  controller: cnicController),
              Row(
                children: [
                  Expanded(
                    child: AddNeedyPeopleComp(
                        title: 'Date of Issue',
                        hint: 'DD/MM/YYYY',
                        icon: Icons.dataset,
                        controller: dateofCardIssueController),
                  ),
                  Expanded(
                    child: AddNeedyPeopleComp(
                        title: 'Date of Expire',
                        hint: 'DD/MM/YYYY',
                        icon: Icons.person,
                        controller: dateofCardExpireController),
                  ),
                ],
              ),
              AddNeedyPeopleComp(
                  title: 'Date of Birth',
                  icon: Icons.person,
                  hint: 'DD/MM/YYYY',
                  controller: dobController),
              0.02.ph,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                child: Column(
                  children: [
                    MaterialButton(
                      height: context.mh * 0.06,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
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
                            gender == '0' ? 'Male' : 'Female');
                      },
                      color: AppColor.cgreenColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Insert Data',
                            style: GoogleFonts.poppins(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: context.mh * 0.022),
                          ),
                          0.03.pw,
                          Icon(
                            IconlyBold.scan,
                            size: context.mh * 0.03,
                            color: AppColor.whiteColor,
                          )
                        ],
                      ),
                    ),
                    0.03.ph,
                    const LoginOrRow(),
                    0.03.ph,
                    MaterialButton(
                      height: context.mh * 0.06,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
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
                            gender);
                      },
                      color: AppColor.cgreenColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Scan ID Card',
                            style: GoogleFonts.poppins(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: context.mh * 0.022),
                          ),
                          0.03.pw,
                          Icon(
                            IconlyBold.scan,
                            size: context.mh * 0.03,
                            color: AppColor.whiteColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
