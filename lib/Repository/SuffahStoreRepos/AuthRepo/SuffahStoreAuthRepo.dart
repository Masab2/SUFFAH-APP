import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/utils/constant/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuffaStoreAuthRepo {
  Future<String?> suffaStoreLoginAccount(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context);
    if (email.text.isEmpty || password.text.isEmpty) {
      return l10n!.dataEnterError;
    } else {
      QuerySnapshot snapshot =
          await Apis.firestore.collection(suffahShop).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        log(data['genUsername']);
        if (data["genUsername"] == email.text.trim() &&
            data['genPassword'] == password.text.trim()) {
          final id = data['ShopId'];
          final shopName = data['ShopTitle'];
          log(shopName);
          final futures = [
            SharePrefs.saveData('Shopid', id),
            SharePrefs.saveData('Shopname', shopName),
          ];
          await Future.wait(futures);
          return null;
        }
      }
      return l10n!.emailEnterError;
    }
  }
}