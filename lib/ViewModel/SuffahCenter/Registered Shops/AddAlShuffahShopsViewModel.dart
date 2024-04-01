// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cnic_scanner/cnic_scanner.dart';
import 'package:cnic_scanner/model/cnic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Mail/sendEmail.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/AddSuffahStores/AddSuffahStoreRepo.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class AddAlsuffahShopsViewModel extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var image;
  var currentCountry = 'Pakistan'.obs;
  var currentCity = 'Lahore'.obs;
  var currentState = 'Punjab'.obs;
  RxString imagePath = ''.obs;
  var isShopAdded = false.obs;
  final RxList popupMenuItems = [].obs;
  final selectedprogramPopUp = 'Select Program'.obs;

  void toggleShop(muntazim, masjidId, masjidname, data) {
    isShopAdded.value = !isShopAdded.value;
    if (isShopAdded.value) {
      Get.toNamed(RoutesNames.addShopsScreen, arguments: [
        muntazim,
        masjidId,
        masjidname,
        data,
      ]);
    }
  }

  void fetchPopupMenuItems() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(suffahCenterDefineProgram);
    QuerySnapshot querySnapshot =
        await collectionReference.where('Status', isEqualTo: 'Active').get();
    popupMenuItems.value =
        querySnapshot.docs.map((doc) => doc['programTitle']).toList();
  }

  // Selected Value Of the PopUp menu Item For One Click
  void handelSelectedItem(String selected) {
    selectedprogramPopUp.value = selected;
  }

  final AddSuffahStoreRepo _addSuffahStoreRepo = AddSuffahStoreRepo();
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

  // Validate The Feilds To enter into the database
  void addNewSuffahStore(
    shopTitle,
    phoneno,
    email,
    address,
    muntazimid,
    masjidid,
    masjidname,
    program,
  ) async {
    try {
      final result = await _addSuffahStoreRepo.addNewSuffahStore(
        shopTitle,
        phoneno,
        email,
        currentCountry.value,
        currentCity.value,
        address,
        muntazimid,
        masjidid,
        masjidname,
        currentState.value,
        File(
          imagePath.value,
        ),
        program,
      );
      if (result == null) {
        Get.toNamed(RoutesNames.addShopsCnicScreen, arguments: [
          shopTitle.text,
          phoneno.text,
          email.text,
          currentCountry.value,
          currentCity.value,
          address.text,
          imagePath.value,
          muntazimid,
          masjidid,
          masjidname,
          currentState.value,
          program,
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
    phone,
    muntazimId,
    masjidid,
    masjidname,
    email,
    program,
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
        currentCountry.value,
        currentCity.value,
        phone,
        muntazimId,
        masjidid,
        masjidname,
        email,
        currentState.value,
        program,
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
          currentCountry.value,
          currentCity.value,
          phone,
          muntazimId,
          masjidid,
          masjidname,
          email,
          currentState.value,
          program,
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
    phone,
    muntazimId,
    masjidid,
    masjidname,
    email,
    program,
  ) async {
    CnicModel cnicModel =
        await CnicScanner().scanImage(imageSource: imageSource);
    if (cnicModel == null) {
      Get.snackbar('No Image Found', 'Scan Your Id Card');
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
        Get.snackbar('No Image Found', 'Scan Your Id Card');
      } else {
        try {
          final result = await _addSuffahStoreRepo.addSuffahStoreInDBScan(
            name,
            cnicno,
            dob,
            doCardIssue,
            doCardExpire,
            File(imagePath.value),
            shopTitle,
            address,
            currentCountry.value,
            currentCity.value,
            phone,
            muntazimId,
            masjidid,
            masjidname,
            email,
            currentState.value,
            program,
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
              currentCountry.value,
              currentCity.value,
              phone,
              muntazimId,
              masjidid,
              masjidname,
              email,
              currentState.value,
              program,
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
    phone,
    muntazimId,
    masjidid,
    masjidname,
    TextEditingController genUsername,
    TextEditingController genPass,
    email,
    program,
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
        currentCountry.value,
        currentCity.value,
        phone,
        muntazimId,
        masjidid,
        masjidname,
        genUsername,
        genPass,
        email,
        currentState.value,
        program,
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
