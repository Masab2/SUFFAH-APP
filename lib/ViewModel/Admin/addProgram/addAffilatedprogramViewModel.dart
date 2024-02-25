// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Repository/AdminRepo/addProgram/addAffiliatedProgramRepo.dart';

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

  void addAffiliatedProgram(title, status, price) async {
    final result = await _addProgramRepo.addAffiliatedProgram(
      imagePath.value.toString(),
      title,
      status,
      price,
      selectedCurrency.value,
    );
    if (result == null) {
      Get.snackbar('Program Added', 'Program Added Successfully');
    } else {
      Get.snackbar('Error', result.toString());
    }
  }

  // For DropDown
  void onItemSelected(String? newValue) {
    selectedValue.value = newValue ?? "Active";
  }
}
