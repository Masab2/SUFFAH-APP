import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class ShuffaCenterAuthRepo {
  Future<String?> suffahLoginAccount(
    TextEditingController email,
    TextEditingController password,
  ) async {
    if (email.text.isEmpty && password.text.isEmpty) {
      return 'Please Enter the Data';
    } else if (email.text.isEmpty) {
      return 'Please Enter the Email address';
    } else if (password.text.isEmpty) {
      return 'Please Enter the Password';
    } else {
      QuerySnapshot snapshot =
          await Apis.firestore.collection(suffahCenterMembers).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["suffahemail"] == email.text &&
            data['password'] == password.text &&
            data['status'] == 'Verified') {
          final id = data['MuntazimId'];
          final masjidname = data['masjidname'];
          final centerId = data['centerId'];

          // Save user ID and Masjid information simultaneously
          log(centerId);
          final futures = [
            SharePrefs.saveData('id', id),
            SharePrefs.saveData('masjidName', masjidname),
            SharePrefs.saveData('centerId', centerId),
          ];
          await Future.wait(futures);

          log(id.toString());
          return null;
        }
      }
      return 'Invalid email or password';
    }
  }
}
