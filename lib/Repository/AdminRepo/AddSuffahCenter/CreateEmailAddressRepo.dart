import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class CreateEmailRepo {
  Future<String?> createEmail(
    File file,
    TextEditingController name,
    TextEditingController emailAddress,
    TextEditingController phoneno,
    TextEditingController city,
    TextEditingController country,
    TextEditingController address,
    TextEditingController genEmail,
    TextEditingController genPasword,
  ) async {
    if (genEmail.text.isEmpty && genPasword.text.isEmpty) {
      return 'Please Enter the Email address and Password';
    } else if (genEmail.text.isEmpty) {
      return 'Please Enter the Email Address';
    } else if (genPasword.text.isEmpty) {
      return 'Please Enter the Password';
    } else {
      SharePrefs.generateRandomNumber();
      await SharePrefs.saveRandomId();
      final int uniqueId = await SharePrefs.getRandomId();
      QuerySnapshot snapshot =
          await Apis.firestore.collection(adminCollection).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["email"] == genEmail.text) {
          return 'The Email is Already Available';
        }
      }
      // If the loop completes and does not find a matching email, proceed with registration
      final emailDomain = genEmail.text.split('@').last;
      switch (emailDomain) {
        case 'suffacenter.com':
          try {
            await Apis.addSuffahCenter(
                file,
                name.text,
                emailAddress.text,
                genEmail.text,
                genPasword.text,
                phoneno.text,
                city.text,
                country.text,
                address.text,
                uniqueId.toString());
            await Apis.updateEmailInAdminCollection(
                genEmail.text, genPasword.text, uniqueId.toString());
          } catch (e) {
            return e.toString();
          }
          break;
        default:
          return 'Please Enter the Authorized Domain suffacenter.com';
      }
    }
    return null;
  }
}
