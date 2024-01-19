// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class AddNeedyPeopleRepo {
  Future<String?> addNeedyPeople(File file, TextEditingController phoneno,
      TextEditingController address, TextEditingController masjid) async {
    if (file == null &&
        phoneno.text.isEmpty &&
        address.text.isEmpty &&
        masjid.text.isEmpty) {
      return 'Please Enter The Data';
    } else if (phoneno.text.isEmpty) {
      return 'Please Enter The Phone No';
    } else if (address.text.isEmpty) {
      return 'Please Enter The Address';
    } else if (masjid.text.isEmpty) {
      return 'Please Enter The Name of Masjid';
    } else {
      return null;
    }
  }

  Future<String?> addCnicDataManually(
      TextEditingController holdername,
      TextEditingController cnicNo,
      TextEditingController dob,
      TextEditingController doCardissue,
      TextEditingController doCardExpire,
      File file,
      String phoneno,
      String address,
      String masjid,
      program,
      muntazimid,
      gender) async {
    if (holdername.text.isEmpty &&
        cnicNo.text.isEmpty &&
        dob.text.isEmpty &&
        doCardissue.text.isEmpty &&
        doCardExpire.text.isEmpty) {
      return 'Please Enter the Data';
    } else if (holdername.text.isEmpty) {
      return 'Please Enter The Card Holder Name';
    } else if (cnicNo.text.isEmpty) {
      return 'Please Enter The CNIC NO';
    } else if (dob.text.isEmpty) {
      return 'Please Enter The Date of Birth';
    } else if (doCardissue.text.isEmpty) {
      return 'Please Enter The date of Card Issue';
    } else if (doCardExpire.text.isEmpty) {
      return 'Please Enter The Date of Card Expire';
    } else {
      try {
        await Apis.addNeedyPeople(
            file,
            muntazimid,
            phoneno,
            address,
            masjid,
            program,
            gender,
            cnicNo.text,
            holdername.text,
            dob.text,
            doCardissue.text,
            doCardExpire.text);
      } catch (e) {
        return e.toString();
      }
      return null;
    }
  }

  // Add Cnic Data While Scanning
  Future<String?> addCnicDataScan(
      TextEditingController holdername,
      TextEditingController cnicNo,
      TextEditingController dob,
      TextEditingController doCardissue,
      TextEditingController doCardExpire,
      File file,
      String phoneno,
      String address,
      String masjid,
      program,
      muntazimid,
      gender) async {
    try {
      await Apis.addNeedyPeople(
          file,
          muntazimid,
          phoneno,
          address,
          masjid,
          program,
          gender,
          cnicNo.text,
          holdername.text,
          dob.text,
          doCardissue.text,
          doCardExpire.text);
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}
