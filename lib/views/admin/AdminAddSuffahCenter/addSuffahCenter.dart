import 'dart:developer';
import 'dart:io';
import 'package:csc_picker/csc_picker.dart';
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
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final addressController = TextEditingController();
  final addsuffahControlller = Get.put(AddSuffahCenterViewModel());
  @override
  void dispose() {
    muntazimController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n!.registerCenter,
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
                          image: FileImage(
                            File(
                              addsuffahControlller.imagePath.toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          0.05.ph,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mw * 0.04,
            ),
            child: CSCPicker(
              dropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: AppColor.mehroonColor, width: 1)),
              layout: Layout.horizontal,
              showCities: true,
              showStates: true,
              flagState: CountryFlag.ENABLE,
              currentCountry: addsuffahControlller.country.value,
              currentCity: addsuffahControlller.currentCity.value,
              currentState: addsuffahControlller.currentState.value,
              onCountryChanged: (value) {
                addsuffahControlller.updateCountry(value);
              },
              onCityChanged: (value) {
                addsuffahControlller.onCityChanged(value ?? '');
                log(value.toString());
              },
              onStateChanged: (value) {
                addsuffahControlller.onStateChanged(value ?? '');
              },
            ),
          ),
          0.01.ph,
          AddSuffahCenterComp(
            title: l10n.muntazimNameTitle,
            icon: IconlyBold.add_user,
            controller: muntazimController,
          ),
          0.01.ph,
          AddSuffahCenterComp(
              title: l10n.masjidNameTitle,
              icon: Icons.mosque,
              hint: 'Jamia Masjid',
              controller: masjidController),
          0.01.ph,
          AddSuffahCenterComp(
              hint: 'abc@gmail.com',
              title: l10n.emailHint,
              icon: IconlyBold.message,
              controller: emailController),
          0.01.ph,
          AddSuffahCenterComp(
            hint: 'Must be 11 digit',
            title: l10n.phoneNoTitle,
            icon: IconlyBold.call,
            controller: phoneController,
          ),
          0.01.ph,
          AddSuffahCenterComp(
              hint: 'Street 20 B xxxx',
              title: l10n.addressTitle,
              icon: IconlyBold.location,
              controller: addressController),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.mw * 0.03, vertical: context.mh * 0.03),
        child: ReuseAblebtn(
          title: l10n.nextbtn,
          onPressed: () {
            addsuffahControlller.addSuffahCenter(
              muntazimController,
              emailController,
              phoneController,
              addressController,
              masjidController,
              context,
            );
          },
        ),
      ),
    );
  }
}
