import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class LoginRepo {
  Future<String?> loginAccount(
      TextEditingController email, TextEditingController password) async {
    if (email.text.isEmpty && password.text.isEmpty) {
      return 'Please Enter the Data';
    } else if (email.text.isEmpty) {
      return 'Please Enter the Email address';
    } else if (password.text.isEmpty) {
      return 'Please Enter the Password';
    } else {
      final RegExp emailRegExp =
          RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
      if (emailRegExp.hasMatch(email.text) && password.text.length >= 6) {
        try {
          await Apis.loginAccount(email.text, password.text);
          log('Login Successful');
          return null; // Return null on successful login
        } catch (error) {
          log('Login Error: $error');
          return 'An error occurred while logging in';
        }
      } else {
        return 'Incorrect Format';
      }
    }
  }
}
