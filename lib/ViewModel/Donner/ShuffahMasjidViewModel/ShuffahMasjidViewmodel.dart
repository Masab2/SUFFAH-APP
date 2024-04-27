import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/ShuffahMasjidModel/ShuffamasjidModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
class ShuffahMasjidViewModel extends GetxController {
  final RxList<ShuffahMasjidModel> needyPeople = <ShuffahMasjidModel>[].obs;
  final RxList<ShuffahMasjidModel> filteredPeople = <ShuffahMasjidModel>[].obs;
  static const double _usdExchangeRate = 0.0036;
  static const double _eurExchangeRate = 0.0033;

  void fetchMasjidProgramOneClick(targetCurrency) {
    Apis.getAllSuffahCenterDefinePrograms()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final List<ShuffahMasjidModel> data = snapshot.docs.map((doc) {
        var convertedReceivedDonation = convertCurrency(
            double.parse(doc['recivedDonnation']), targetCurrency);
        var convertedRequiredDonation =
            convertCurrency(double.parse(doc['Price']), targetCurrency);
        log(convertedRequiredDonation.toString());
        return ShuffahMasjidModel(
          cardHolderName: doc['CardHolderName'],
          cnicNo: doc['CnicNo'],
          masjidId: doc['MasjidId'],
          phoneno: doc['PhoneNo'],
          price: convertedRequiredDonation.toString(),
          status: doc['Status'],
          doExpire: doc['doExpire'],
          doIssue: doc['doIssue'],
          dob: doc['dob'],
          image: doc['image'],
          masjidEmail: doc['masjidEmail'],
          muntazimId: doc['muntazimId'],
          programId: doc['programId'],
          programTitle: doc['programTitle'],
          programPurpose: doc['purpose'],
          recivedDonnation: convertedReceivedDonation.toString(),
          address: doc['MasjidAddress'],
          country: doc['countryMasjid'],
          city: doc['masjidCity'],
          state: doc['masjidState'],
          massjidname: doc['masjidname'],
          masjidid: doc['MasjidId'],
          masjidAddress: doc['MasjidAddress'],
          masjidCountry: doc['countryMasjid'],
          masjidCity: doc['masjidCity'],
          masjidState: doc['masjidState'],
          masjidemail: doc['masjidEmail'],
        );
      }).toList();
      if (kDebugMode) {
        print('Fetched data: $data');
      }
      needyPeople.assignAll(data);
      filteredPeople.assignAll(data);
    });
  }

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

  // Open Google Maps According to Address
  void openGoogleMap(String address) async {
    String url = "https://www.google.com/maps/search/?api=1&query=$address";
    await launcher.launchUrl(Uri.parse(url));
  }
}
