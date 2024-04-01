import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/NeedyPeopleRepos/addNeedyPeopleRepo.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class AddPersonalInfoViewModel extends GetxController {
  final RxList<String> programs = ['Male', 'Female'].obs;
  var selectedValue = "Male".obs;
  RxString imagePath = ''.obs;
  RxInt selectedGender = 0.obs;
  var currentCountry = 'Pakistan'.obs;
  var currentCity = 'Lahore'.obs;
  var currentState = 'Punjab'.obs;

  final ImagePicker _picker = ImagePicker();
  final AddNeedyPeopleRepo _addNeedyPeopleRepo = AddNeedyPeopleRepo();
  var image;

  // For DropDown
  void onItemSelected(String? newValue) {
    selectedValue.value = newValue ?? "Male";
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

  // Add Data Into DataBase
  void addNeedyPerson(
    phoneno,
    address,
    masjid,
    program,
    gender,
    masjidid,
    masjidEmail,
    country,
    state,
    city,
    masjidAddress,
    price,
  ) async {
    final result = await _addNeedyPeopleRepo.addNeedyPeople(
      imagePath.value.toString(),
      phoneno,
      address,
      masjid,
    );
    await SharePrefs.getData('id').then((value) {
      if (result == null) {
        Get.toNamed(RoutesNames.addNeedyPeopleScreen, arguments: <String>[
          imagePath.value.toString(),
          phoneno.text.toString(),
          address.text.toString(),
          masjid.toString(),
          value.toString(),
          gender.toString(),
          program.toString(),
          masjidid.toString(),
          masjidEmail.toString(),
          country.toString(),
          state.toString(),
          city.toString(),
          masjidAddress.toString(),
          price.toString(),
        ]);
      } else {
        Get.snackbar('Error', result.toString());
      }
    }).onError((error, stackTrace) {
      Get.snackbar('Error', error.toString());
    });
  }
}
