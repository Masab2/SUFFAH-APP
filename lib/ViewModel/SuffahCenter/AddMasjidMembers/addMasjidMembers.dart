import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/AddMasjidmembers/addMasjidRepo.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class AddMasjidMemberViewModel extends GetxController {
  RxString imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final AddMasjidRepo _addMasjidRepo = AddMasjidRepo();
  var image;
  Future getImageFromgallery(ImageSource source) async {
    image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      Get.snackbar('Fail', 'No Image Selected');
    }
  }

  Future<void> addSuffahCenterMasjidMembers(
      name, emailAddress, phoneno, city, country, address) async {
    final result = await _addMasjidRepo.addSuffahCenterMembers(
        File(imagePath.value.toString()),
        name,
        emailAddress,
        phoneno,
        city,
        country,
        address);
    if (result == null) {
      Get.toNamed(RoutesNames.suffacentergenerateEmailScreen, arguments: [
        imagePath.value,
        name,
        emailAddress,
        phoneno,
        city,
        country,
        address
      ]);
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
