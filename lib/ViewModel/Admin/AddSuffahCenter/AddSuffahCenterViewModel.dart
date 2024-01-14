import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Repository/AdminRepo/AddSuffahCenter/addSuffahCenterRepo.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class AddSuffahCenterViewModel extends GetxController {
  RxString imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final AddSuffahCenterRepo _addSuffahCenterRepo = AddSuffahCenterRepo();
  var image;
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
      name, emailAddress, phoneno, city, country, address, masjidname) async {
    final result = await _addSuffahCenterRepo.addSuffahCenter(
        File(imagePath.value.toString()),
        name,
        emailAddress,
        phoneno,
        city,
        country,
        address,
        masjidname);
    if (result == null) {
      Get.toNamed(RoutesNames.createEmailScreen, arguments: [
        imagePath.value,
        name,
        emailAddress,
        phoneno,
        city,
        country,
        address,
        masjidname
      ]);
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
