import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';

class AddCenterProgramRepo {
  Future<String?> requestProgramManually(
    TextEditingController title,
    TextEditingController price,
    TextEditingController purpose,
    TextEditingController holdername,
    TextEditingController cnicNo,
    TextEditingController dob,
    TextEditingController doCardissue,
    TextEditingController doCardExpire,
    File file,
    status,
    muntazimId,
    masjidname,
    masjidId,
  ) async {
    if (title.text.isEmpty ||
        price.text.isEmpty ||
        purpose.text.isEmpty ||
        holdername.text.isEmpty ||
        cnicNo.text.isEmpty ||
        dob.text.isEmpty ||
        doCardissue.text.isEmpty ||
        doCardExpire.text.isEmpty) {
      return 'Please enter all the required data';
    }
    try {
      await Apis.addAffiliatedProgramBySuffahCenter(
        file,
        title.text,
        status,
        price.text,
        purpose.text,
        muntazimId,
        masjidname,
        masjidId,
        cnicNo.text,
        dob.text,
        doCardissue.text,
        doCardExpire.text,
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
