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
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                0.01.ph,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
                  child: Text(
                    'Gender',
                    style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.017, fontWeight: FontWeight.bold),
                  ),
                ),
                0.01.ph,
                Obx(
                  () => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.mw * 0.02),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: context.mh * 0.030,
                          backgroundColor: AppColor.mehroonColor,
                          child: const Icon(
                            Icons.ac_unit,
                            color: AppColor.whiteColor,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.mw * 0.02),
                            margin: EdgeInsets.symmetric(
                                horizontal: context.mw * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: peronalInfoController.selectedValue.value,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: peronalInfoController.programs
                                  .map((String items) {
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
                  ),
                ),
              ],
            ),
          ),
          0.02.ph,
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
          0.02.ph,
        ],
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.mw * 0.03, vertical: context.mh * 0.01),
          child: ReuseAblebtn(
            title: 'Next',
            onPressed: () {
              peronalInfoController.addNeedyPerson(
                phonenoController,
                addressController,
                masjidname,
                program,
                peronalInfoController.selectedValue.toString(),
                masjidid,
              );
            },
          )),
    );
  }
}
