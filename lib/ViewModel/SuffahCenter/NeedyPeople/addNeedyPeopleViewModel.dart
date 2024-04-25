// ignore_for_file: unnecessary_null_comparison
import 'package:cnic_scanner/cnic_scanner.dart';
import 'package:cnic_scanner/model/cnic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/NeedyPeopleRepos/addNeedyPeopleRepo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNeedyPeopleViewModel extends GetxController {
  final AddNeedyPeopleRepo _addNeedyPeopleRepo = AddNeedyPeopleRepo();

  // Insert Data Manually
  Future<void> addDataManually(
    TextEditingController name,
    TextEditingController cnicno,
    TextEditingController dob,
    TextEditingController doCardIssue,
    TextEditingController doCardExpire,
    image,
    phoneno,
    address,
    masjid,
    program,
    muntazimid,
    gender,
    masjidid,
    masjidEmail,
    masjidCountry,
    masjidState,
    masjidCity,
    masjidaddress,
    donatePrice,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context);
    try {
      final result = await _addNeedyPeopleRepo.addCnicDataManually(
        name,
        cnicno,
        dob,
        doCardIssue,
        doCardExpire,
        image,
        phoneno,
        address,
        masjid,
        program,
        muntazimid,
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
      if (result == null) {
        Get.snackbar('Successfull', l10n!.addedSuccessfully);
      } else {
        Get.snackbar('Error', result);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Add Data While Scanning
  Future<void> scanCnic(
    ImageSource imageSource,
    TextEditingController name,
    TextEditingController cnicno,
    TextEditingController dob,
    TextEditingController doCardIssue,
    TextEditingController doCardExpire,
    image,
    phoneno,
    address,
    masjid,
    program,
    muntazimid,
    gender,
    masjidid,
    masjidEmail,
    masjidCountry,
    masjidState,
    masjidCity,
    masjidaddress,
    donatePrice,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context);
    CnicModel cnicModel =
        await CnicScanner().scanImage(imageSource: imageSource);
    if (cnicModel == null) {
      Get.snackbar('Oops', l10n!.scanYourIdCard);
    } else {
      name.text = cnicModel.cnicHolderName;
      cnicno.text = cnicModel.cnicNumber;
      dob.text = cnicModel.cnicHolderDateOfBirth;
      doCardIssue.text = cnicModel.cnicIssueDate;
      doCardExpire.text = cnicModel.cnicExpiryDate;
      if (name.text.isEmpty &&
          cnicno.text.isEmpty &&
          dob.text.isEmpty &&
          doCardIssue.text.isEmpty &&
          doCardExpire.text.isEmpty) {
        Get.snackbar('Oops', l10n!.scanYourIdCard);
      } else {
        try {
          final result = await _addNeedyPeopleRepo.addCnicDataScan(
            name,
            cnicno,
            dob,
            doCardIssue,
            doCardExpire,
            image,
            phoneno,
            address,
            masjid,
            program,
            muntazimid,
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
          if (result == null) {
            Get.snackbar('Successfull', l10n!.addedSuccessfully);
          } else {
            Get.snackbar('Error', result);
          }
        } catch (e) {
          Get.snackbar('Error', e.toString());
        }
      }
      update();
    }
  }
}
