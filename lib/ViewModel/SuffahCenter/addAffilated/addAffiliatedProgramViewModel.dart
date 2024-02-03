// ignore_for_file: non_constant_identifier_names


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/affiliatedProgramModel/affiliatedProgramModel.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class AddAffiliatedViewModel extends GetxController {
  final _status = true.obs;
  final RxList program = <AffiliatedProgramModel>[].obs;
  bool get status => _status.value;

  @override
  void onInit() {
    super.onInit();
    fetchPrograms();
  }

  void fetchPrograms() {
    Apis.getAllPrograms()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final List<AffiliatedProgramModel> data = snapshot.docs.map((doc) {
        return AffiliatedProgramModel(
          programTitle: doc['programTitle'],
          isSelected: false,
        );
      }).toList();
      if (kDebugMode) {
        print('Fetched data: $data');
      }
      program.assignAll(data);
    });
  }

  // Function to toggle the selection of a program
  void toggleProgramSelection(int index) {
    program[index].isSelected = !program[index].isSelected;
    update();
  }
}
