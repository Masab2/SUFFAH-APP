
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/constant/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminAuthRepo {
  Future<String?> adminLoginAccount(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context);
    if (email.text.isEmpty && password.text.isEmpty) {
      return l10n!.dataEnterError;
    } else if (email.text.isEmpty) {
      return l10n!.emailEnterError;
    } else if (password.text.isEmpty) {
      return l10n!.passwordEnterError;
    } else {
      QuerySnapshot snapshot =
          await Apis.firestore.collection(adminCollection).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["email"] == email.text && data['password'] == password.text) {
          return null;
        }
      }
       return 'Invalid email or password'; 
    }
  }
}
