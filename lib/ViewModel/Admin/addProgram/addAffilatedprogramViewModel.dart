// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Repository/AdminRepo/addProgram/addAffiliatedProgramRepo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AffiliatedViewModel extends GetxController {
  RxString imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final RxList<String> programs = ['Active', 'Disable'].obs;
  var selectedValue = "Active".obs;
  var selectedCurrency = 'PKR'.obs;
  final AffiliatedProgramRepo _addProgramRepo = AffiliatedProgramRepo();
  var image;

  Future getImageFromgallery(ImageSource source) async {
    image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      Get.snackbar('Fail', 'No Image Selected');
    }
  }

  void addAffiliatedProgram(
      title, status, price, purpose, BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final result = await _addProgramRepo.addAffiliatedProgram(
      imagePath.value.toString(),
      title,
      status,
      price,
      selectedCurrency.value,
      purpose,
      context,
    );
    if (result == null) {
      Get.snackbar('Success', l10n!.addedSuccessfully);
    } else {
      Get.snackbar('Error', result.toString());
    }
  }

  // For DropDown
  void onItemSelected(String? newValue) {
    selectedValue.value = newValue ?? "Active";
  }
}
