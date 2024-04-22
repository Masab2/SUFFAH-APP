import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/DonnationTrackMasjidModel/DonnationTrackMasjidModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

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

  // Masjid Donnation Verify for Donate
  void validateDonnation(
    requiredAmmount,
    String image,
    String currency,
    TextEditingController donnateController,
    DonnationTrackMasjidModel model,
    List<DonnerModel> donnermodel,
    BuildContext context,
    String  programStatus,
  ) {
    if (donnateController.text.isNotEmpty) {
      final String donate = donnateController.text;
      final int donnationAmmount = int.parse(donate);
      if (donnationAmmount == 0) {
        Get.snackbar('oopps', 'Please Enter the Required Ammount');
      } else if (donnationAmmount > requiredAmmount) {
        Get.snackbar('oopps', 'Please Enter the Required Ammount');
      } else {
        Get.toNamed(
          RoutesNames.donatePaymentScreen,
          arguments: [
            programStatus,
            model,
            donnermodel,
          ],
        );
      }
    } else {
      Get.snackbar('Error', 'Please Enter the ammount');
    }
  }
}
