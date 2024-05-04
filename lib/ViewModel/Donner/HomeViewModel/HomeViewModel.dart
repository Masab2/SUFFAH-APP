import 'package:flutter/foundation.dart';
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
   static const double _usdExchangeRate = 0.0036;
  static const double _eurExchangeRate = 0.0033;

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

  // Convert the Donnation Ammount Into the Desired Currency
  double convertCurrency(double amount, String targetCurrency) {
    double convertedAmount = 0;
    switch (targetCurrency) {
      case 'USD':
        convertedAmount = amount * _usdExchangeRate;
        if (kDebugMode) {
          print('$amount PKR is $convertedAmount USD');
        }
        break;
      case 'EUR':
        convertedAmount = amount * _eurExchangeRate;
        if (kDebugMode) {
          print('$amount PKR is $convertedAmount EUR');
        }
        break;
      default:
        convertedAmount = amount;
        if (kDebugMode) {
          print('$amount PKR is $convertedAmount PKR');
        }
        break;
    }
    return convertedAmount;
  }
}
