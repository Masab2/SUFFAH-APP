// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:suffa_app/Repository/AdminRepo/AddSuffahCenter/CreateEmailAddressRepo.dart';

class CreateEmailViewModel extends GetxController {
  final CreateEmailRepo _createEmailRepo = CreateEmailRepo();

  Future<void> sendEmail(
      String recipentEmail, String email, String pass) async {
    String username = 'suffa36@gmail.com';
    String password = 'myxmbldopdwvvvpv';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Mail Service')
      ..recipients.add(recipentEmail)
      ..subject = 'SUFFAH APP'
      ..text = '''
        Your Email Address for Access your Portal 
        Email    : $email 
        Password : $pass
      ''';
    try {
      await send(message, smtpServer);
      Get.snackbar('Successfull', 'Mail Sent Successfully');
    } catch (e) {
      Get.snackbar('Error', 'Error Occured');
    }
  }

  Future<void> createEmail(File file, name, emailAddress, phoneno, city,
      country, address, genEmail, genPassword) async {
    final result = await _createEmailRepo.createEmail(file, name, emailAddress,
        phoneno, city, country, address, genEmail, genPassword);
    if (result == null) {
      await sendEmail(emailAddress.text, genEmail.text, genPassword.text);
      Get.snackbar('Successfull', 'Center Registerd Successully');
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
