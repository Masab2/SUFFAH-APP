import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  var country = 'Pakistan'.obs;
  var currentCity = ''.obs;
  var currentState = ''.obs;
  var selectedCurrency = 'PKR'.obs;

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
}
