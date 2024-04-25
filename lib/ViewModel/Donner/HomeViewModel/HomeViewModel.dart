import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/DonnationTrackMasjidModel/DonnationTrackMasjidModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);
    if (donnateController.text.isNotEmpty) {
      final String donate = donnateController.text;
      final int donnationAmmount = int.parse(donate);
      if (donnationAmmount == 0) {
        Get.snackbar('oopps', l10n!.requiredAmmount);
      } else if (donnationAmmount > requiredAmmount) {
        Get.snackbar('oopps', l10n!.requiredAmmount);
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
      Get.snackbar('Error', l10n!.requiredAmmount);
    }
  }
}
