import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/alSuffahPersonModel/suffaPersonModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/routes/routesNames.dart';

class NeedyPeopleController extends GetxController {
  final isLoading = false.obs;
  final _status = 'Added'.obs;
  final RxList<SuffahPersonModel> needyPeople = <SuffahPersonModel>[].obs;
  final RxList<SuffahPersonModel> filteredPeople = <SuffahPersonModel>[].obs;

  String get status => _status.value;

  void fetchData(program, String muntazimid) {
    Apis.getAllNeedyPeopleByProgramMasjid(
      program,
      muntazimid,
    ).listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final List<SuffahPersonModel> data = snapshot.docs.map((doc) {
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
          donnerSelectionId: doc['donerSelectionId'],
          requiredDonnation: doc['requiredDonnation'],
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
  void validateDonnation(donnationAmmount, requiredAmmount) {
    if (donnationAmmount > requiredAmmount) {
      Get.snackbar('oopps', 'Please Enter the Required Ammount');
    } else {
      Get.toNamed(RoutesNames.donatePaymentScreen, arguments: [
        donnationAmmount,
      ]);
    }
  }
}
