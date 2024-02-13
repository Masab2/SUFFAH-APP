// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:cnic_scanner/cnic_scanner.dart';
import 'package:cnic_scanner/model/cnic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Mail/sendEmail.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/AddSuffahStores/AddSuffahStoreRepo.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class AddAlsuffahShopsViewModel extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var image;
  RxString imagePath = ''.obs;
  final AddSuffahStoreRepo _addSuffahStoreRepo = AddSuffahStoreRepo();
  Future getImageFromgallery(ImageSource source) async {
    image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      Get.snackbar('Fail', 'No Image Selected');
    }
  }

  // Validate The Feilds To enter into the database
  void addNewSuffahStore(
    shopTitle,
    phoneno,
    email,
    country,
    city,
    address,
    muntazimid,
    masjidid,
    masjidname,
  ) async {
    try {
      final result = await _addSuffahStoreRepo.addNewSuffahStore(
        shopTitle,
        phoneno,
        email,
        country,
        city,
        address,
        muntazimid,
        masjidid,
        masjidname,
      );
      if (result == null) {
        Get.toNamed(RoutesNames.addShopsCnicScreen, arguments: [
          shopTitle.text,
          phoneno.text,
          email.text,
          country.text,
          city.text,
          address.text,
          imagePath.value,
          muntazimid,
          masjidid,
          masjidname,
        ]);
      } else {
        Get.snackbar('Error', result);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Add Data Manually Into the database
  void addDataManuallyInDB(
    holdername,
    cnicNo,
    dob,
    doCardissue,
    doCardExpire,
    shopTitle,
    address,
    country,
    city,
    phone,
    muntazimId,
    masjidid,
    masjidname,
    email,
  ) async {
    try {
      final result = await _addSuffahStoreRepo.addSuffahStoreInDBManually(
        holdername,
        cnicNo,
        dob,
        doCardissue,
        doCardExpire,
        File(imagePath.value),
        shopTitle,
        address,
        country,
        city,
        phone,
        muntazimId,
        masjidid,
        masjidname,
        email,
      );
      if (result == null) {
        Get.toNamed(RoutesNames.genUsernamePassShopScreen, arguments: [
          holdername.text,
          cnicNo.text,
          dob.text,
          doCardissue.text,
          doCardExpire.text,
          imagePath.value,
          shopTitle,
          address,
          country,
          city,
          phone,
          muntazimId,
          masjidid,
          masjidname,
          email,
        ]);
      } else {
        log(result);
        Get.snackbar('Error', result);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Scan ID Card
  Future<void> scanID(
    ImageSource imageSource,
    TextEditingController name,
    TextEditingController cnicno,
    TextEditingController dob,
    TextEditingController doCardIssue,
    TextEditingController doCardExpire,
    shopTitle,
    address,
    country,
    city,
    phone,
    muntazimId,
    masjidid,
    masjidname,
    email,
  ) async {
    CnicModel cnicModel =
        await CnicScanner().scanImage(imageSource: imageSource);
    if (cnicModel == null) {
      Get.snackbar('No Image Found', 'Scan Your Id Card');
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
        Get.snackbar('No Image Found', 'Scan Your Id Card');
      } else {
        try {
          final result = await _addSuffahStoreRepo.addSuffahStoreInDBManually(
            name,
            cnicno,
            dob,
            doCardIssue,
            doCardExpire,
            File(imagePath.value),
            shopTitle,
            address,
            country,
            city,
            phone,
            muntazimId,
            masjidid,
            masjidname,
            email,
          );
          if (result == null) {
            Get.toNamed(RoutesNames.genUsernamePassShopScreen, arguments: [
              name.text,
              cnicno.text,
              dob.text,
              doCardIssue.text,
              doCardExpire.text,
              imagePath.value,
              shopTitle,
              address,
              country,
              city,
              phone,
              muntazimId,
              masjidid,
              masjidname,
              email,
            ]);
          } else {
            Get.snackbar('Error', result);
          }
        } catch (e) {
          Get.snackbar('Error', e.toString());
        }
      }
    }
  }

  // Add Geneated username and Password Into the database and Send Email
  void genUserAndSendEmail(
    holdername,
    cnicNo,
    dob,
    doCardissue,
    doCardExpire,
    image,
    shopTitle,
    address,
    country,
    city,
    phone,
    muntazimId,
    masjidid,
    masjidname,
    TextEditingController genUsername,
    TextEditingController genPass,
    email,
  ) async {
    try {
      final result =
          await _addSuffahStoreRepo.addUserStoreWithGeneratedPassword(
        holdername,
        cnicNo,
        dob,
        doCardissue,
        doCardExpire,
        image,
        shopTitle,
        address,
        country,
        city,
        phone,
        muntazimId,
        masjidid,
        masjidname,
        genUsername,
        genPass,
        email,
      );
      if (result == null) {
        await EmailAuth.sendEmail(
            email, genUsername.text, genPass.text, 'Al-Suffah');
        Get.snackbar('Successfull', 'Shop Added Successfully');
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
