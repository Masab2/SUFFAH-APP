// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/NeedyPeople/addPersonalnfoViewModel.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/BottomSheetContainer.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/PickImage.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/addSuffahCenter.dart';
import 'package:suffa_app/res/components/SuffahCenterProfile/suffaCenterProfile.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddPersonalData extends StatefulWidget {
  const AddPersonalData({super.key});

  @override
  State<AddPersonalData> createState() => _AddPersonalDataState();
}

class _AddPersonalDataState extends State<AddPersonalData> {
  final peronalInfoController = Get.put(AddPersonalInfoViewModel());
  final phonenoController = TextEditingController();
  final addressController = TextEditingController();
  final masjidController = TextEditingController();
  late String id;
  late String masjidname;
  late String program;
  late String masjidid;

  @override
  void initState() {
    id = Get.arguments[0] ?? '';
    masjidname = Get.arguments[1] ?? '';
    program = Get.arguments[2] ?? '';
    masjidid = Get.arguments[3] ?? '';
    super.initState();
  }

  @override
  void dispose() {
    peronalInfoController.dispose();
    phonenoController.dispose();
    addressController.dispose();
    masjidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SUFFAH PERSON',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Obx(
            () => peronalInfoController.imagePath.isEmpty
                ? PickImageWidget(
                    ontap: () {
                      Get.bottomSheet(BottomSheetContainer(
                        ongallery: () {
                          peronalInfoController
                              .getImageFromgallery(ImageSource.gallery);
                        },
                        oncamera: () {
                          peronalInfoController
                              .getImageFromgallery(ImageSource.camera);
                        },
                      ));
                    },
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                    child: SizedBox(
                      height: context.mh * 0.20,
                      width: context.mw * 0.60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                            height: context.mh * 0.20,
                            width: context.mw * 0.40,
                            fit: BoxFit.cover,
                            image: FileImage(File(
                                peronalInfoController.imagePath.toString()))),
                      ),
                    ),
                  ),
          ),
          0.04.ph,
          UserInfoListTile(
              icon: Icons.mosque_outlined,
              title: 'Masjid',
              subtitle: masjidname),
          0.01.ph,
          UserInfoListTile(
            icon: Icons.notes,
            title: 'Program',
            subtitle: program,
          ),
          0.01.ph,
          AddSuffahCenterComp(
            title: 'PhoneNo',
            hint: '0322********',
            icon: Icons.phone,
            controller: phonenoController,
          ),
          0.01.ph,
          AddSuffahCenterComp(
            title: 'Address',
            icon: Icons.location_city,
            hint: 'StreetNo 24 z5',
            controller: addressController,
          ),
          0.01.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                0.01.ph,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                  child: Text('Gender',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => RadioListTile<int>.adaptive(
                          title: Text(
                            'Male',
                            style: GoogleFonts.poppins(),
                          ),
                          value: 0,
                          groupValue:
                              peronalInfoController.selectedGender.value,
                          onChanged: (value) {
                            peronalInfoController.onGenderSelected(value ?? 0);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => RadioListTile<int>.adaptive(
                          title: Text(
                            'Female',
                            style: GoogleFonts.poppins(),
                          ),
                          value: 1,
                          groupValue:
                              peronalInfoController.selectedGender.value,
                          onChanged: (value) {
                            peronalInfoController.onGenderSelected(value ?? 0);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          0.02.ph,
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.mw * 0.03, vertical: context.mh * 0.01),
        child: MaterialButton(
          height: context.mh * 0.05,
          color: AppColor.cgreenColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            peronalInfoController.addNeedyPerson(
              phonenoController,
              addressController,
              masjidname,
              program,
              peronalInfoController.selectedGender.value.toString() == '0'
                  ? 'Male'
                  : 'Female',
              masjidid,
            );
          },
          child: Text(
            'Next',
            style: GoogleFonts.poppins(
                fontSize: context.mh * 0.022, color: AppColor.whiteColor),
          ),
        ),
      ),
    );
  }
}
