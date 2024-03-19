import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Mail/sendEmail.dart';
import 'package:suffa_app/Repository/AdminRepo/AddSuffahCenter/addSuffahCenterRepo.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class AddSuffahCenterViewModel extends GetxController {
  RxString imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final AddSuffahCenterRepo _addSuffahCenterRepo = AddSuffahCenterRepo();
  var image;
  var country = 'Pakistan'.obs;
  var currentCity = 'Lahore'.obs;
  var currentState = 'Punjab'.obs;

  // Update the Country
  void updateCountry(value) {
    country.value = value;
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

  Future getImageFromgallery(ImageSource source) async {
    image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      Get.snackbar('Fail', 'No Image Selected');
    }
  }

  // Add Suffah Center
  Future<void> addSuffahCenter(
    TextEditingController name,
    TextEditingController emailAddress,
    TextEditingController phoneno,
    TextEditingController address,
    TextEditingController masjidname,
  ) async {
    final result = await _addSuffahCenterRepo.addSuffahCenter(
      File(imagePath.value.toString()),
      name,
      emailAddress,
      phoneno,
      currentCity.value,
      country.value,
      address,
      masjidname,
      currentState.value,
    );
    if (result == null) {
      Get.toNamed(RoutesNames.createEmailScreen, arguments: [
        imagePath.value,
        name.text,
        emailAddress.text,
        phoneno.text,
        currentCity.value,
        country.value,
        address.text,
        masjidname.text,
        currentState.value,
      ]);
    } else {
      Get.snackbar('Error', result.toString());
    }
  }

  // Create the Email And Password For the Al Shuffa Center
  Future<void> createEmail(
    File file,
    String name,
    String emailAddress,
    String phoneno,
    String city,
    String country,
    String address,
    genEmail,
    genPassword,
    String masjidname,
    state,
  ) async {
    final result = await _addSuffahCenterRepo.createEmail(
      file,
      name,
      emailAddress,
      phoneno,
      currentCity.value,
      country,
      address,
      genEmail,
      genPassword,
      masjidname,
      currentState.value,
    );
    if (result == null) {
      await EmailAuth.sendEmail(
        emailAddress,
        genEmail.text,
        genPassword.text,
        'DAR US SHUFFA FOUNDATION',
      );
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
