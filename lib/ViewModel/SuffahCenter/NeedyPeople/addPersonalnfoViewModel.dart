import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/NeedyPeopleRepos/addNeedyPeopleRepo.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class AddPersonalInfoViewModel extends GetxController {
  final RxList<String> programs = ['Rashan Program', 'One Time Meal'].obs;
  var selectedValue = "Rashan Program".obs;
  RxString imagePath = ''.obs;
  RxInt selectedGender = 0.obs;

  final ImagePicker _picker = ImagePicker();
  final AddNeedyPeopleRepo _addNeedyPeopleRepo = AddNeedyPeopleRepo();
  var image;

  // For DropDown
  void onItemSelected(String? newValue) {
    selectedValue.value = newValue ?? "Rashan Program";
  }

  // For Radio Button
  void onGenderSelected(int value) {
    selectedGender.value = value;
  }

  Future getImageFromgallery(ImageSource source) async {
    image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      Get.snackbar('Fail', 'No Image Selected');
    }
  }

  // Add Data Into DataBase
  void addNeedyPerson(phoneno, address, masjid, program, gender) async {
    final result = await _addNeedyPeopleRepo.addNeedyPeople(
        File(imagePath.value.toString()), phoneno, address, masjid);
    await SharePrefs.getId('id').then((value) {
      if (result == null) {
        Get.toNamed(RoutesNames.addNeedyPeopleScreen, arguments: <String>[
          imagePath.value.toString(),
          phoneno.text.toString(),
          address.text.toString(),
          masjid.text.toString(),
          value.toString(),
          gender.toString(),
          program.toString()
        ]);
      } else {
        Get.snackbar('Error', result.toString());
      }
    }).onError((error, stackTrace) {
      Get.snackbar('Error', error.toString());
    });
  }
}
