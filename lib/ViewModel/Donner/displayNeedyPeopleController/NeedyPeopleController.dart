import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/alSuffahPersonModel/suffaPersonModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class NeedyPeopleController extends GetxController {
  final isLoading = false.obs;
  final _status = 'Added'.obs;
  final RxList<SuffahPersonModel> needyPeople = <SuffahPersonModel>[].obs;
  final RxList<SuffahPersonModel> filteredPeople = <SuffahPersonModel>[].obs;
  static const double _usdExchangeRate = 0.0036;
  static const double _eurExchangeRate = 0.0033;
  String get status => _status.value;

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
        );
      }).toList();
      if (kDebugMode) {
        print('Fetched data: $data');
      } // Add this line to check fetched data
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

  // Check The Donnation Validation
  void validateDonnation(
    int requiredAmmount,
    String image,
    String currency,
    TextEditingController donnateController,
    personcnic,
    personname,
    dateofBirth,
    dateofCardExpire,
    dateofCardIssue,
    personId,
    personPhoneNo,
    personAddress,
    personprofile,
    persongender,
    masjidname,
    masjidid,
    masjidAddress,
    masjidCountry,
    masjidCity,
    masjidState,
    masjidEmail,
    program,
  ) {
    if (donnateController.text.isNotEmpty) {
      final String donate = donnateController.text;
      final int donnationAmmount = int.parse(donate);
      if (donnationAmmount == 0) {
        Get.snackbar('oopps', 'Please Enter the Required Ammount');
      } else if (donnationAmmount > requiredAmmount) {
        Get.snackbar('oopps', 'Please Enter the Required Ammount');
      } else {
        final String ammount = donnationAmmount.toString();
        final String reqAmmount = requiredAmmount.toString();
        Get.toNamed(
          RoutesNames.donatePaymentScreen,
          arguments: <String>[
            ammount,
            reqAmmount,
            image,
            currency,
            personcnic,
            personname,
            dateofBirth,
            dateofCardExpire,
            dateofCardIssue,
            personId,
            personPhoneNo,
            personAddress,
            personprofile,
            persongender,
            masjidname,
            masjidid,
            masjidAddress,
            masjidCountry,
            masjidCity,
            masjidState,
            masjidEmail,
          ],
        );
      }
    } else {
      Get.snackbar('Error', 'Please Enter the ammount');
    }
  }

  // Convert the Currency Into the Desired Currency
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
