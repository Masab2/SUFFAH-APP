import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/utils/constant/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class GenerateEmailSuffaMembersRepo {
  Future<String?> createEmail(
    File file,
    TextEditingController name,
    TextEditingController emailAddress,
    TextEditingController phoneno,
    city,
    country,
    TextEditingController address,
    TextEditingController genEmail,
    TextEditingController genPasword,
    masjidid,
    state,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context);
    if (genEmail.text.isEmpty || genPasword.text.isEmpty) {
      return l10n!.dataEnterError;
    }
    else {
      final id = await SharePrefs.getData('id');
      QuerySnapshot snapshot =
          await Apis.firestore.collection(suffahCenterMembers).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["suffahemail"] == genEmail.text) {
          return l10n!.emailAlreadyAvailable;
        }
      }

      final emailDomain = genEmail.text.split('@').last;
      switch (emailDomain) {
        case 'suffacenter.com':
          try {
            await Apis.addSuffahCommitteMembers(
              file,
              name.text,
              emailAddress.text,
              genEmail.text,
              genPasword.text,
              phoneno.text,
              city,
              country,
              address.text,
              id,
              masjidid,
              state,
            );
          } catch (e) {
            return e.toString();
          }
          break;
        default:
          return l10n!.enterAuthrizedDomain;
      }
    }
    return null;
  }
}
