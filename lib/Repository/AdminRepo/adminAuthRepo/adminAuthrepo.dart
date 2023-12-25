import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class AdminAuthRepo {
  Future<String?> adminLoginAccount(
    TextEditingController email,
    TextEditingController password,
    VoidCallback onSuccessfulLogin,
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
          onSuccessfulLogin();
          return null;
        }
      }
      return 'Invalid email or password';
    }
  }
}
