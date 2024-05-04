import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginRepo {
  Future<String?> loginAccount(
      TextEditingController email, TextEditingController password,BuildContext context) async {
        final l10n = AppLocalizations.of(context);
    if (email.text.isEmpty && password.text.isEmpty) {
      return l10n!.dataEnterError;
    } else if (email.text.isEmpty) {
      return l10n!.emailEnterError;
    } else if (password.text.isEmpty) {
      return l10n!.passwordEnterError;
    } else {
      final RegExp emailRegExp =
          RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
      if (emailRegExp.hasMatch(email.text) && password.text.length >= 6) {
        try {
          await Apis.loginAccount(email.text, password.text);
          log('Login Successful');
          return null;
        } catch (error) {
          log('Login Error: $error');
          return l10n!.technicalError;
        }
      } else {
        return 'Incorrect Format';
      }
    }
  }
}
