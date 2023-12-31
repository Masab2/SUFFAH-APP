// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';

class AddSuffahCenterRepo {
  Future<String?> addSuffahCenter(
      File file,
      TextEditingController name,
      TextEditingController emailAddress,
      TextEditingController phoneno,
      TextEditingController city,
      TextEditingController country,
      TextEditingController address) async {
    if (file == null &&
        name.text.isEmpty &&
        emailAddress.text.isEmpty &&
        phoneno.text.isEmpty &&
        city.text.isEmpty &&
        country.text.isEmpty &&
        address.text.isEmpty) {
      return 'Please Enter The Data';
    } else if (name.text.isEmpty) {
      return 'Please Enter The Name of The Muntazim';
    } else if (emailAddress.text.isEmpty) {
      return 'Please Enter The Email Address';
    } else if (phoneno.text.isEmpty) {
      return 'Please Enter The Phone No';
    } else if (city.text.isEmpty) {
      return 'Please Enter The Phone No';
    } else if (country.text.isEmpty) {
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
}
