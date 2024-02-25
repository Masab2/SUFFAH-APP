// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class AddSuffahStoreRepo {
  Future<String?> addNewSuffahStore(
    TextEditingController shopTitle,
    TextEditingController phoneno,
    TextEditingController email,
    country,
    city,
    TextEditingController address,
    muntazimid,
    masjidid,
    masjidname,
    state,
    image,
    program,
  ) async {
    if (shopTitle.text.isEmpty ||
        phoneno.text.isEmpty ||
        email.text.isEmpty ||
        country == '' ||
        city == '' ||
        address.text.isEmpty ||
        state == '' ||
        image == '') {
      return "Please fill all fields";
    } else {
      final RegExp emailRegExp =
          RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
      if (emailRegExp.hasMatch(email.text)) {
        return null;
      } else {
        return 'Please Enter the Email Address in the Proper Format';
      }
    }
  }

  // Insert Data manually
  Future<String?> addSuffahStoreInDBManually(
    TextEditingController holdername,
    TextEditingController cnicNo,
    TextEditingController dob,
    TextEditingController doCardissue,
    TextEditingController doCardExpire,
    File file,
    shopTitle,
    address,
    country,
    city,
    phone,
    muntazimId,
    masjidid,
    masjidname,
    email,
    state,
    program,
  ) async {
    if (holdername.text.isEmpty ||
        cnicNo.text.isEmpty ||
        dob.text.isEmpty ||
        doCardissue.text.isEmpty ||
        doCardExpire.text.isEmpty) {
      return 'Please enter all the required data';
    } else {
      QuerySnapshot snapshot =
          await Apis.firestore.collection(suffahCenterNeedyPeople).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["CNICNo"] == cnicNo.text) {
          return 'This CNIC is already registered';
        } else {
          return null;
        }
      }
    }
  }

  // Id Card Scanner
  Future<String?> addSuffahStoreInDBScan(
    TextEditingController holdername,
    TextEditingController cnicNo,
    TextEditingController dob,
    TextEditingController doCardissue,
    TextEditingController doCardExpire,
    File file,
    shopTitle,
    address,
    country,
    city,
    phone,
    muntazimId,
    masjidid,
    masjidname,
    email,
    state,
    program,
  ) async {
    if (holdername.text.isEmpty ||
        cnicNo.text.isEmpty ||
        dob.text.isEmpty ||
        doCardissue.text.isEmpty ||
        doCardExpire.text.isEmpty) {
      return 'Please enter all the required data';
    } else {
      QuerySnapshot snapshot =
          await Apis.firestore.collection(suffahCenterNeedyPeople).get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["CNICNo"] == cnicNo.text) {
          return 'This CNIC is already registered';
        } else {
          return null;
        }
      }
    }
  }

  // Add Store into firebase with Generated Username and Password
  Future<String?> addUserStoreWithGeneratedPassword(
    holdername,
    cnicNo,
    dob,
    doCardissue,
    doCardExpire,
    File file,
    shopTitle,
    address,
    country,
    city,
    phone,
    muntazimId,
    masjidid,
    masjidname,
    TextEditingController genUsername,
    TextEditingController genPass,
    email,
    state,
    program,
  ) async {
    if (genUsername.text.isEmpty || genUsername.text.isEmpty) {
      return 'Fill The Required Fields';
    } else {
      try {
        await Apis.addSuffahStore(
          file,
          cnicNo,
          dob,
          doCardissue,
          doCardExpire,
          shopTitle,
          address,
          country,
          city,
          phone,
          muntazimId,
          masjidid,
          masjidname,
          genUsername.text,
          genPass.text,
          email,
          state,
          program,
        );
        return null;
      } catch (e) {
        return e.toString();
      }
    }
  }
}
