import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/utils/Utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ZakatCalculatorViewModel extends GetxController {
  void calculateZakat(
    TextEditingController savingController,
    TextEditingController assetsController,
    TextEditingController debitsController,
    TextEditingController otherWealthController,
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context);
    // Check if any of the input fields are empty
    if (savingController.text.isEmpty ||
        assetsController.text.isEmpty ||
        debitsController.text.isEmpty ||
        otherWealthController.text.isEmpty) {
      Get.snackbar('Oops', l10n!.dataEnterError);
      return;
    }

    // Parse input values
    double savings = double.tryParse(savingController.text) ?? 0;
    double assets = double.tryParse(assetsController.text) ?? 0;
    double debts = double.tryParse(debitsController.text) ?? 0;
    double otherWealth = double.tryParse(otherWealthController.text) ?? 0;

    // Calculate total Zakatable assets
    double zakatableAssets = savings + assets + otherWealth;

    // Subtract debts
    zakatableAssets -= debts;

    // Check if Zakat is payable
    if (zakatableAssets >= 0.025) {
      // Apply Zakat rate (2.5%)
      double zakatAmount = zakatableAssets * 0.025;
      Utils.showZakatDialog(zakatAmount);
    } else {
      Get.snackbar('Oops', l10n!.zakatTitleError);
    }
  }
}
