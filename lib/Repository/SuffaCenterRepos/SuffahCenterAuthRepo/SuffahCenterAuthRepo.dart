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
          await SharePrefs.saveData('id', id);
          log(id.toString());
          return null;
        }
      }
      return 'Invalid email or password';
    }
  }
}
