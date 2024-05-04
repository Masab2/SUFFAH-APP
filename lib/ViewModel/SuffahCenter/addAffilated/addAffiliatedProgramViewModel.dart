// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';

import 'package:cnic_scanner/cnic_scanner.dart';
import 'package:cnic_scanner/model/cnic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Mail/sendEmail.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/addCenterProgram/addcenterProgramRepo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCenterProgramController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var image;
  RxString imagePath = ''.obs;
  var currentCountry = 'Pakistan'.obs;
  var currentCity = 'Lahore'.obs;
  var currentState = 'Punjab'.obs;
  final AddCenterProgramRepo _programRepo = AddCenterProgramRepo();

  Future getImageFromgallery(ImageSource source) async {
    image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      Get.snackbar('Fail', 'No Image Selected');
    }
  }

  // Select The Country
  void onCountryChanged(value) {
    currentCountry.value = value;
    update();
  }

  // Select The City
  void onCityChanged(String value) {
    currentCity.value = value;
    update();
  }

  // Select The State
  void onStateChanged(String value) {
    currentState.value = value;
    update();
  }

  // Add Program to The Database And Request to The Admin
  void requestProgramManually(
    TextEditingController title,
    TextEditingController price,
    TextEditingController purpose,
    TextEditingController holdername,
    TextEditingController cnicNo,
    TextEditingController dob,
    TextEditingController doCardissue,
    TextEditingController doCardExpire,
    status,
    muntazimId,
    masjidname,
    masjidId,
    muntazimEmail,
    TextEditingController phoneNoController,
    address,
    country,
    state,
    city,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context);
    try {
      final result = await _programRepo.requestProgramManually(
        title,
        price,
        purpose,
        holdername,
        cnicNo,
        dob,
        doCardissue,
        doCardExpire,
        File(imagePath.value.toString()),
        status,
        muntazimId.toString(),
        masjidname.toString(),
        masjidId.toString(),
        muntazimEmail,
        phoneNoController,
        address,
        country,
        state,
        city,
        context,
      );

      if (result == null) {
        await EmailAuth.sendEmailForProgram(
            muntazimEmail, 'Al-Suffah Center', masjidname);
        Get.snackbar('Success', l10n!.addedSuccessfully);
      } else {
        log(result);
        Get.snackbar('Error', result);
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

  // Scan Id Card For Automation
  void scanIdcardforAutomate(
    TextEditingController title,
    TextEditingController price,
    TextEditingController purpose,
    TextEditingController holdername,
    TextEditingController cnicNo,
    TextEditingController dob,
    TextEditingController doCardissue,
    TextEditingController doCardExpire,
    status,
    muntazimId,
    masjidname,
    masjidId,
    muntazimEmail,
    TextEditingController phoneNoController,
    address,
    country,
    state,
    city,
    BuildContext context,
    ImageSource imageSource,
  ) async {
    final l10n = AppLocalizations.of(context);
    CnicModel cnicModel =
        await CnicScanner().scanImage(imageSource: imageSource);
    if (cnicModel == null) {
      Get.snackbar('Oops', l10n!.scanYourIdCard);
    } else {
      holdername.text = cnicModel.cnicHolderName;
      cnicNo.text = cnicModel.cnicNumber;
      dob.text = cnicModel.cnicHolderDateOfBirth;
      doCardissue.text = cnicModel.cnicIssueDate;
      doCardExpire.text = cnicModel.cnicExpiryDate;
      if (holdername.text.isEmpty &&
          cnicNo.text.isEmpty &&
          dob.text.isEmpty &&
          doCardissue.text.isEmpty &&
          doCardExpire.text.isEmpty) {
        Get.snackbar('Oops', l10n!.scanYourIdCard);
      } else {
        try {
          final result = await _programRepo.scanIdCard(
            title,
            price,
            purpose,
            holdername,
            cnicNo,
            dob,
            doCardissue,
            doCardExpire,
            File(imagePath.value.toString()),
            status,
            muntazimId.toString(),
            masjidname.toString(),
            masjidId.toString(),
            muntazimEmail,
            phoneNoController,
            address,
            country,
            state,
            city,
            context,
          );

          if (result == null) {
            await EmailAuth.sendEmailForProgram(
                muntazimEmail, 'Al-Suffah Center', masjidname);
            Get.snackbar('Success', l10n!.addedSuccessfully);
          } else {
            log(result);
            Get.snackbar('Error', result);
          }
        } catch (e) {
          log(e.toString());
          Get.snackbar('Error', e.toString());
        }
      }
    }
  }
}
