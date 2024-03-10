// ignore_for_file: unnecessary_null_comparison


import 'package:flutter/material.dart';

class AddMasjidRepo {
  Future<String?> addSuffahCenterMembers(
    String file,
    TextEditingController name,
    TextEditingController emailAddress,
    TextEditingController phoneno,
    city,
    country,
    TextEditingController address,
    state,
  ) async {
    if (file == null ||
        name.text.isEmpty ||
        emailAddress.text.isEmpty ||
        phoneno.text.isEmpty ||
        city == '' ||
        country == '' ||
        address.text.isEmpty ||
        state == '') {
      return 'Please Enter All The Required Data';
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
