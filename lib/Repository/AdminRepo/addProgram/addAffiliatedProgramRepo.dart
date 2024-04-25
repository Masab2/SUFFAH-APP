// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AffiliatedProgramRepo {
  Future<String?> addAffiliatedProgram(
    String file,
    TextEditingController title,
    status,
    TextEditingController price,
    cuurency,
    TextEditingController purpose,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context);
    if (file == null ||
        title.text.isEmpty ||
        price.text.isEmpty ||
        file.isEmpty) {
      return l10n!.dataEnterError;
    } else {
      try {
        await Apis.addAffiliatedProgramByAdmin(
          File(file),
          title.text,
          status,
          price.text,
          cuurency,
          purpose.text,
        );
      } catch (e) {
        return e.toString();
      }
    }
    return null;
  }
}
