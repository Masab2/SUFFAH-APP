import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/alSuffahPersonModel/suffaPersonModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/enum/AffiliatedProgramEnum.dart';

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
          program: program == ProgramType.ONETIMEMEAL
              ? 'OneTimeMeal'
              : 'RashanProgram',
          masjidname: doc['MasjidName'],
          tempstatus: doc['tempStatus'],
          status: doc['status'],
          personId: doc['personId'],
          donnerSelectionId: doc['donerSelectionId'],
        );
      }).toList();
      if (kDebugMode) {
        print('Fetched data: $data');
      } // Add this line to check fetched data
      needyPeople.assignAll(data);
      filteredPeople.assignAll(data);
    });
  }

  // Update the status of the Selected Person
  Future<void> updateStatus(personId) async {
    await Apis.updateStatusAlSuffahPerson(personId, _status.value.toString())
        .then((value) {
      log('Then Executed');
      _status.value = _status.value == 'Added' ? 'Waiting' : 'Added';
    }).onError((error, stackTrace) {
      _status.value = _status.value == 'Added' ? 'Waiting' : 'Added';
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

  // // Calculate The price of the Person Donation
  int calulateTotalDonnation(int actualPrice) {
    final peopleLength =
        filteredPeople.where((person) => person.tempstatus == "Added").toList();
    return actualPrice * peopleLength.length;
  }

  

  // Future<void> updateStatusInDatabase(String personId) async {
  //   // Update status in the Firebase database
  //   await Apis.updateStatusAlSuffahPerson(personId, status);
  // }

  // Future<void> updateStatus(String personId) async {
  //   updateStatusLocally(personId);
  //   await updateStatusInDatabase(personId);
  // }

  // int calulateTotalDonnation(int price) {
  //   int total = 0;
  //   for (var person in needyPeople) {
  //     if (person.tempstatus == 'Added') {
  //       total += price;
  //     }
  //   }
  //   return total;
  // }
}
