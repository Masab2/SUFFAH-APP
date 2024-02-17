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
  var currentCountry = 'Pakistan'.obs;
  var currentCity = 'Lahore'.obs;
  var currentState = 'Punjab'.obs;
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

  Future<void> addSuffahCenterMasjidMembers(
      name, emailAddress, phoneno, city, country, address, masjidid,state) async {
    final result = await _addMasjidRepo.addSuffahCenterMembers(
      imagePath.value.toString(),
      name,
      emailAddress,
      phoneno,
      currentCity.value.toString(),
      currentCountry.value.toString(),
      address,
      currentState.value.toString(),
    );
    if (result == null) {
      Get.toNamed(RoutesNames.suffacentergenerateEmailScreen, arguments: [
        imagePath.value,
        name,
        emailAddress,
        phoneno,
        currentCity.value.toString(),
        currentCountry.value.toString(),
        address,
        masjidid,
        currentState.value.toString(),
      ]);
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
