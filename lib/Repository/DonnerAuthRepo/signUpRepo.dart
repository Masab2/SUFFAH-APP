// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpRepo {
  Future<String?> signUpAccount(TextEditingController email,
      TextEditingController password, BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    if (email.text.isEmpty || password.text.isEmpty) {
      return l10n!.dataEnterError;
    } else {
      final RegExp emailRegExp =
          RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
      if (emailRegExp.hasMatch(email.text) && password.text.length >= 6) {
        try {
          await Apis.signUpAccount(email.text, password.text);
          await Apis.saveUserData(Apis.user, email.text);
          return null;
        } catch (error) {
          log('SignUp Error: $error');
          return l10n!.technicalError;
        }
      } else {
        return l10n!.emailEnterError;
      }
    }
  }
}
