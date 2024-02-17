import 'dart:developer';
import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/ViewModel/SuffahCenter/Registered%20Shops/AddAlShuffahShopsViewModel.dart';
import 'package:suffa_app/res/components/AddNeedyPeople/addNeedyPeopleComp.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/BottomSheetContainer.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/addSuffahCenter.dart';
import 'package:suffa_app/res/components/CNICFormComp/CnicFormComp.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/components/loginOrRow/loginOrRow.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../../res/components/AddSuffahCenter/PickImage.dart';

class AddAlSuffahShops extends StatefulWidget {
  const AddAlSuffahShops({super.key});

  @override
  State<AddAlSuffahShops> createState() => _AddAlSuffahShopsState();
}

class _AddAlSuffahShopsState extends State<AddAlSuffahShops> {
  var titleController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();

  final controller = Get.put(AddAlsuffahShopsViewModel());
  late String muntazid;
  late String masjidId;
  late String masjidname;
  
  @override
  void initState() {
    muntazid = Get.arguments[0];
    masjidId = Get.arguments[1];
    masjidname = Get.arguments[2];
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    phoneController.dispose();
    emailController.dispose();
    countryController.dispose();
    cityController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registered Shops',
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
            Obx(
              () => controller.imagePath.isEmpty
                  ? PickImageWidgetCircle(
                      ontap: () {
                        Get.bottomSheet(BottomSheetContainer(
                          ongallery: () {
                            controller.getImageFromgallery(ImageSource.gallery);
                          },
                          oncamera: () {
                            controller.getImageFromgallery(ImageSource.camera);
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
                              image: FileImage(
                                  File(controller.imagePath.toString()))),
                        ),
                      ),
                    ),
            ),
            0.02.ph,
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.mw * 0.05,
                ),
                child: Obx(() {
                  return CSCPicker(
                    dropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border:
                            Border.all(color: AppColor.cgreenColor, width: 1)),
                    layout: Layout.horizontal,
                    showCities: true,
                    showStates: true,
                    flagState: CountryFlag.ENABLE,
                    currentCountry: controller.currentCountry.value,
                    currentCity: controller.currentCity.value,
                    currentState: controller.currentState.value,
                    onCountryChanged: (value) {
                      controller.onCountryChanged(value);
                    },
                    onCityChanged: (value) {
                      controller.onCityChanged(value ?? '');
                      log(value.toString());
                    },
                    onStateChanged: (value) {
                      controller.onStateChanged(value ?? '');
                    },
                  );
                })),
            0.02.ph,
            AddSuffahCenterComp(
              title: 'Shop Title',
              icon: Icons.shop,
              controller: titleController,
              hint: 'Tandoor / Utility Store',
            ),
            AddSuffahCenterComp(
              title: 'Phone No',
              icon: Icons.phone,
              controller: phoneController,
              hint: '0311 *****',
            ),
            AddSuffahCenterComp(
              title: 'Email Address',
              icon: Icons.email,
              controller: emailController,
              hint: 'abc@gmail.com',
            ),
            AddSuffahCenterComp(
              title: 'Address',
              icon: IconlyBold.location,
              controller: addressController,
              hint: 'xyz Market city etc',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.mw * 0.06,
            vertical: context.mw * 0.03,
          ),
          child: ReuseAblebtn(
            title: 'Next',
            onPressed: () {
              controller.addNewSuffahStore(
                titleController,
                phoneController,
                emailController,
                addressController,
                muntazid,
                masjidId,
                masjidname,
              );
            },
          )),
    );
  }
}
