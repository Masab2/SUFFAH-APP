import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class SuffaStoreAuthRepo {
  Future<String?> suffaStoreLoginAccount(
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
          await Apis.firestore.collection(adminCollection).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["email"] == email.text && data['password'] == password.text) {
          final id = data['id'];
          await SharePrefs.saveData('id', id);
          return null;
        }
      }
      return 'Invalid email or password';
    }
  }
}
