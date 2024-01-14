// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:get/get.dart';
import 'package:suffa_app/Mail/sendEmail.dart';
import 'package:suffa_app/Repository/AdminRepo/AddSuffahCenter/CreateEmailAddressRepo.dart';

class CreateEmailViewModel extends GetxController {
  final CreateEmailRepo _createEmailRepo = CreateEmailRepo();

  Future<void> createEmail(File file, name, emailAddress, phoneno, city,
      country, address, genEmail, genPassword, image, masjidname) async {
    final result = await _createEmailRepo.createEmail(
        file,
        name,
        emailAddress,
        phoneno,
        city,
        country,
        address,
        genEmail,
        genPassword,
        image,
        masjidname);
    if (result == null) {
      await EmailAuth.sendEmail(
          emailAddress.text, genEmail.text, genPassword.text, 'SUFFAH APP');
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
