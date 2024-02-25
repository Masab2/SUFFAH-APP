// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class SignUpRepo {
  Future<String?> signUpAccount(
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
          // Check if the email is already registered with Google
          // final googleSignInMethods =
          //     await Apis.isEmailRegisteredWithGoogle(email.text);
          // if (googleSignInMethods.isNotEmpty) {
          //   return 'Email is already registered with Google';
          // }

          // Proceed with email/password signup
          await Apis.signUpAccount(email.text, password.text);
          await Apis.saveUserData(Apis.user, email.text);
          return null;
        } catch (error) {
          log('SignUp Error: $error');
          return 'An error occurred while signing up';
        }
      } else {
        return 'Incorrect Format';
      }
    }
  }
}
