// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class AffiliatedProgramRepo {
  Future<String?> addAffiliatedProgram(
    File file,
    TextEditingController title,
    status,
    TextEditingController price,
  ) async {
    if (file == null && title.text.isEmpty) {
      return 'Please Enter The Data';
    } else if (title.text.isEmpty) {
      return 'Please Enter The Tile of teh Program';
    } else {
      try {
        await Apis.addAffiliatedProgramByAdmin(
          file,
          title.text,
          status,
          price.text,
        );
      } catch (e) {
        return e.toString();
      }
    }
    return null;
  }
}
