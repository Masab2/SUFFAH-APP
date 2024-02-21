import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/ViewModel/Admin/AddSuffahCenter/AddSuffahCenterViewModel.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/BottomSheetContainer.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/PickImage.dart';
import 'package:suffa_app/res/components/AddSuffahCenter/addSuffahCenter.dart';
import 'package:suffa_app/res/components/ResuableBtn/ReuseAbleBtn.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddSuffahCenter extends StatefulWidget {
  const AddSuffahCenter({super.key});

  @override
  State<AddSuffahCenter> createState() => _AddSuffahCenterState();
}

class _AddSuffahCenterState extends State<AddSuffahCenter> {
  final muntazimController = TextEditingController();
  final masjidController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final addsuffahControlller = Get.put(AddSuffahCenterViewModel());
  @override
  void dispose() {
    muntazimController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    addressController.dispose();
    addsuffahControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Center',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: context.mh * 0.024,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          0.03.ph,
          Obx(
            () => addsuffahControlller.imagePath.isEmpty
                ? PickImageWidget(
                    ontap: () {
                      Get.bottomSheet(BottomSheetContainer(
                        ongallery: () {
                          addsuffahControlller
                              .getImageFromgallery(ImageSource.gallery);
                        },
                        oncamera: () {
                          addsuffahControlller
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
                                addsuffahControlller.imagePath.toString()))),
                      ),
                    ),
                  ),
          ),
          0.05.ph,
          AddSuffahCenterComp(
              title: 'Muntazim Name',
              icon: IconlyBold.add_user,
              controller: masjidController),
          0.01.ph,
          AddSuffahCenterComp(
              title: 'Masjid Name',
              icon: Icons.mosque,
              hint: 'Jamia Masjid',
              controller: muntazimController),
          0.01.ph,
          AddSuffahCenterComp(
              hint: 'abc@gmail.com',
              title: 'Eamil Address',
              icon: IconlyBold.message,
              controller: emailController),
          0.01.ph,
          AddSuffahCenterComp(
              hint: 'Must be 11 digit',
              title: 'Phone No',
              icon: IconlyBold.call,
              controller: phoneController),
          0.01.ph,
          AddSuffahCenterComp(
              hint: 'PK',
              title: 'Country',
              icon: IconlyBold.home,
              controller: countryController),
          0.01.ph,
          AddSuffahCenterComp(
              hint: 'LHR',
              title: 'City',
              icon: Icons.location_city_rounded,
              controller: cityController),
          0.01.ph,
          AddSuffahCenterComp(
              hint: 'Street 20 B xxxx',
              title: 'Address',
              icon: IconlyBold.location,
              controller: addressController),
        ],
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.mw * 0.03, vertical: context.mh * 0.03),
          child: ReuseAblebtn(
            title: 'Next',
            onPressed: () {
              addsuffahControlller.addSuffahCenter(
                  muntazimController,
                  emailController,
                  phoneController,
                  cityController,
                  countryController,
                  addressController,
                  masjidController);
            },
          )),
    );
  }
}
