import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Mail/sendEmail.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/addCenterProgram/addcenterProgramRepo.dart';

class AddCenterProgramController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var image;
  RxString imagePath = ''.obs;
  final AddCenterProgramRepo _programRepo = AddCenterProgramRepo();

  Future getImageFromgallery(ImageSource source) async {
    image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      Get.snackbar('Fail', 'No Image Selected');
    }
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
  ) async {
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
      );

      if (result == null) {
        await EmailAuth.sendEmailForProgram(
            muntazimEmail, 'Al-Suffah Center', masjidname);
        Get.snackbar('Successfull', 'Program Request Is Successfully Sent');
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
