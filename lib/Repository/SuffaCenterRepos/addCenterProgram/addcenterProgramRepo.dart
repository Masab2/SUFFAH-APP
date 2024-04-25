import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    masjidEmail,
    TextEditingController phoneNoController,
    address,
    country,
    state,
    city,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context);
    if (title.text.isEmpty ||
        price.text.isEmpty ||
        purpose.text.isEmpty ||
        holdername.text.isEmpty ||
        cnicNo.text.isEmpty ||
        dob.text.isEmpty ||
        doCardissue.text.isEmpty ||
        doCardExpire.text.isEmpty) {
      return l10n!.dataEnterError;
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
        holdername.text,
        masjidEmail,
        phoneNoController.text,
        address,
        country,
        state,
        city,
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
