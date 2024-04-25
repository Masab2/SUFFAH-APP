import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/utils/constant/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShuffaCenterAuthRepo {
  Future<String?> suffahLoginAccount(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context);
    if (email.text.isEmpty || password.text.isEmpty) {
      return l10n!.dataEnterError;
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
          final email = data['email'];
          final country = data['country'];
          final city = data['city'];
          final state = data['state'];
          final address = data['address'];

          // Save user ID and Masjid information simultaneously
          log(centerId);
          final futures = [
            SharePrefs.saveData('id', id),
            SharePrefs.saveData('masjidName', masjidname),
            SharePrefs.saveData('centerId', centerId),
            SharePrefs.saveData('email', email),
            SharePrefs.saveData('country', country),
            SharePrefs.saveData('state', state),
            SharePrefs.saveData('city', city),
            SharePrefs.saveData('address', address),
          ];
          await Future.wait(futures);

          log(id.toString());
          return null;
        }
      }
      return l10n!.emailEnterError;
    }
  }
}
