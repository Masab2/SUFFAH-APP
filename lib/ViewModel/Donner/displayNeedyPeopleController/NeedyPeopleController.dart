import 'dart:developer';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/DonnationTrackModel/donnationTrackModel.dart';
import 'package:suffa_app/Model/alSuffahPersonModel/suffaPersonModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/constant/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NeedyPeopleController extends GetxController {
  final isLoading = false.obs;
  final RxList<SuffahPersonModel> needyPeople = <SuffahPersonModel>[].obs;
  final RxList<SuffahPersonModel> filteredPeople = <SuffahPersonModel>[].obs;
  final RxList popupMenuItems = [].obs;
  final selectedprogram = 'All'.obs;

  static const double _usdExchangeRate = 0.0036;
  static const double _eurExchangeRate = 0.0033;

  void fetchData(program, String muntazimid, targetCurrency) {
    Apis.getAllNeedyPeopleByProgramMasjid(
      program,
      muntazimid,
    ).listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final List<SuffahPersonModel> data = snapshot.docs.map((doc) {
        var convertedReceivedDonation = convertCurrency(
            double.parse(doc['recivedDonnation']), targetCurrency);
        return SuffahPersonModel(
          personname: doc['PersonName'],
          image: doc['PersonProfile'],
          address: doc['PersonAddress'],
          cnicno: doc['CNICNo'],
          program: doc['program'],
          masjidname: doc['MasjidName'],
          tempstatus: doc['tempStatus'],
          status: doc['status'],
          personId: doc['personId'],
          requiredDonnation: doc['requiredDonnation'],
          recivedDonnation: convertedReceivedDonation.toString(),
          dateofBirth: doc['DateofBirth'],
          dateofIssue: doc['DateofCardIssue'],
          dateofExpire: doc['DateofCardExpire'],
          gender: doc['gender'],
          phoneno: doc['PersonPhoneNo'],
          masjidid: doc['masjidId'],
          masjidAddress: doc['masjidAddress'],
          masjidCountry: doc['masjidCountry'],
          masjidCity: doc['masjidCity'],
          masjidState: doc['masjidState'],
          masjidemail: doc['masjidEmail'],
          muntazimId: doc['MuntazimId'], programStatus: true,
        );
      }).toList();
      if (kDebugMode) {
        print('Fetched data: $data');
      }
      needyPeople.assignAll(data);
      filteredPeople.assignAll(data);
    });
  }

  // Fetch Data For the One Click
  void fetchDataForOneClick(targetCurrency) {
    Apis.getAllNeedyPeopleOneClick()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final List<SuffahPersonModel> data = snapshot.docs.map((doc) {
        var convertedReceivedDonation = convertCurrency(
            double.parse(doc['recivedDonnation']), targetCurrency);
        var convertedDonateAmount = convertCurrency(
            double.parse(doc['requiredDonnation']), targetCurrency);
        log(convertedDonateAmount.toString());
        log(targetCurrency);
        return SuffahPersonModel(
          personname: doc['PersonName'],
          image: doc['PersonProfile'],
          address: doc['PersonAddress'],
          cnicno: doc['CNICNo'],
          program: doc['program'],
          masjidname: doc['MasjidName'],
          tempstatus: doc['tempStatus'],
          status: doc['status'],
          personId: doc['personId'],
          requiredDonnation: convertedDonateAmount.toString(),
          recivedDonnation: convertedReceivedDonation.toString(),
          dateofBirth: doc['DateofBirth'],
          dateofIssue: doc['DateofCardIssue'],
          dateofExpire: doc['DateofCardExpire'],
          gender: doc['gender'],
          phoneno: doc['PersonPhoneNo'],
          masjidid: doc['masjidId'],
          masjidAddress: doc['masjidAddress'],
          masjidCountry: doc['masjidCountry'],
          masjidCity: doc['masjidCity'],
          masjidState: doc['masjidState'],
          masjidemail: doc['masjidEmail'],
          muntazimId: doc['MuntazimId'], programStatus: true,
        );
      }).toList();
      if (kDebugMode) {
        print('Fetched data: $data');
      }
      needyPeople.assignAll(data);
      filteredPeople.assignAll(data);
    });
  }

  // Filter List
  void filterList(String query) {
    if (query.isEmpty) {
      filteredPeople.assignAll(needyPeople);
    } else {
      final filtered = needyPeople.where((person) =>
          person.personname.toLowerCase().contains(query.toLowerCase()));
      filteredPeople.assignAll(filtered);
    }
  }

  // Filter List for the One Click
  void filterListForOneClick(String query) {
    if (query.toLowerCase() == 'all') {
      // Check if the query is "All"
      filteredPeople.assignAll(needyPeople);
    } else if (query.isEmpty) {
      filteredPeople.assignAll(needyPeople);
    } else {
      final filtered = needyPeople.where((person) =>
          person.program.toLowerCase().contains(query.toLowerCase()));
      filteredPeople.assignAll(filtered);
    }
  }

  // Check The Donnation Validation
  void validateDonnation(
    requiredAmmount,
    String image,
    String currency,
    TextEditingController donnateController,
    DonnationTrackModel model,
    List<DonnerModel> donnermodel,
    BuildContext context,
    String programStatus,
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

  // Fetch the Programs In the Popup Menu Item For One Click
  void fetchPopupMenuItems() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(suffahAffiliatedprogram);
    QuerySnapshot querySnapshot = await collectionReference.get();
    popupMenuItems.value =
        querySnapshot.docs.map((doc) => doc['programTitle']).toList();
  }

  // Selected Value Of the PopUp menu Item For One Click
  void handelSelectedItem(String selected) {
    selectedprogram.value = selected;
  }

  // Open Google Maps According to Address
  void openGoogleMap(String address) async {
    String url = "https://www.google.com/maps/search/?api=1&query=$address";
    await launcher.launchUrl(Uri.parse(url));
  }
}
