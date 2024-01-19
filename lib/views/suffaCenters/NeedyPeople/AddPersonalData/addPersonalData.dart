// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/NeedyPeople/addPersonalnfoViewModel.dart';
import 'package:suffa_app/res/components/AddNeedyPeople/addNeedyPeopleComp.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/BottomSheetContainer.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/PickImage.dart';
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
    // final id = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(IconlyBold.arrow_left_circle)),
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
          AddNeedyPeopleComp(
              title: 'Masjid Name',
              hint: 'Jamia Masjid',
              prefixIcon: const Icon(Icons.mosque, color: AppColor.cgreenColor),
              icon: Icons.phone,
              controller: masjidController),
          0.01.ph,
          AddNeedyPeopleComp(
              title: 'Phone No',
              hint: '03114064498',
              prefixIcon:
                  const Icon(IconlyBold.call, color: AppColor.cgreenColor),
              icon: Icons.phone,
              controller: phonenoController),
          0.01.ph,
          AddNeedyPeopleComp(
              title: 'Address',
              hint: 'Street 42 xyz',
              prefixIcon:
                  const Icon(Icons.location_city, color: AppColor.cgreenColor),
              icon: Icons.phone,
              controller: addressController),
          0.02.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                  child: Text('Program',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                0.01.ph,
                Obx(
                  () => Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.mw * 0.02),
                    margin: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: const Border.fromBorderSide(
                            BorderSide(color: AppColor.cgreenColor))),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: peronalInfoController.selectedValue.value,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: peronalInfoController.programs.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        peronalInfoController.onItemSelected(newValue);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
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
              masjidController,
              peronalInfoController.selectedValue.value,
              peronalInfoController.selectedGender.value.toString() == '0'
                  ? 'Male'
                  : 'Female',
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
