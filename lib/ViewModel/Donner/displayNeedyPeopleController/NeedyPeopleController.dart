import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/alSuffahPersonModel/suffaPersonModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/enum/AffiliatedProgramEnum.dart';

class NeedyPeopleController extends GetxController {
  final _status = 'Added'.obs;
  final RxList needyPeople = <SuffahPersonModel>[].obs;

  String get status => _status.value;

  void fetchData(program, String muntazimid) {
    Apis.getAllNeedyPeopleByProgramMasjid(
      "OneTimeMeal",
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
        );
      }).toList();
      if (kDebugMode) {
        print('Fetched data: $data');
      } // Add this line to check fetched data
      needyPeople.assignAll(data);
    });
  }

  Future<void> updateStatus(personId) async {
    await Apis.updateStatusAlSuffahPerson(personId, _status.value.toString())
        .then((value) {
      log('Then Executed');
      _status.value = _status.value == 'Added' ? 'Waiting' : 'Added';
    }).onError((error, stackTrace) {
      _status.value = _status.value == 'Added' ? 'Waiting' : 'Added';
    });
  }
}
