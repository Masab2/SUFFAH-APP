// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class AddSuffahCenterRepo {
  Future<String?> addSuffahCenter(
    File file,
    TextEditingController name,
    TextEditingController emailAddress,
    TextEditingController phoneno,
    city,
    country,
    TextEditingController address,
    TextEditingController masjid,
    state,
  ) async {
    if (file == null &&
        name.text.isEmpty &&
        emailAddress.text.isEmpty &&
        phoneno.text.isEmpty &&
        address.text.isEmpty) {
      return 'Please Enter The Data';
    } else if (name.text.isEmpty) {
      return 'Please Enter The Name of The Muntazim';
    } else if (emailAddress.text.isEmpty) {
      return 'Please Enter The Email Address';
    } else if (phoneno.text.isEmpty) {
      return 'Please Enter The Phone No';
    } else if (address.text.isEmpty) {
      return 'Please Enter The Address';
    } else {
      final RegExp emailRegExp =
          RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
      if (emailRegExp.hasMatch(emailAddress.text)) {
        return null;
      } else {
        return 'Please Enter the Email Address in the Proper Format';
      }
    }
  }

  // Create Email And Password For the Shuffa Center
  Future<String?> createEmail(
    File file,
    name,
    emailAddress,
    phoneno,
    city,
    country,
    address,
    TextEditingController genEmail,
    TextEditingController genPasword,
    String masjidname,
    state,
  ) async {
    if (genEmail.text.isEmpty && genPasword.text.isEmpty) {
      return 'Please Enter the Email address and Password';
    } else if (genEmail.text.isEmpty) {
      return 'Please Enter the Email Address';
    } else if (genPasword.text.isEmpty) {
      return 'Please Enter the Password';
    } else {
      final String emailText = genEmail.text;
      final String passwordText = genPasword.text;
      SharePrefs.generateRandomNumber();
      await SharePrefs.saveRandomId();
      final int uniqueId = await SharePrefs.getRandomId();
      QuerySnapshot snapshot =
          await Apis.firestore.collection(suffahCenterCollection).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["suffahemail"] == genEmail.text) {
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
              name,
              emailAddress,
              emailText,
              passwordText,
              phoneno,
              city,
              country,
              address,
              uniqueId.toString(),
              masjidname,
              state,
            );
          } catch (e) {
            log(e.toString());
            return e.toString();
          }
          break;
        default:
          return 'Please Enter the Authorized Domain';
      }
    }
    return null;
  }
}
