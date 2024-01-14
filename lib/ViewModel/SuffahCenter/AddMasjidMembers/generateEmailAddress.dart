import 'dart:io';

import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:suffa_app/Repository/SuffaCenterRepos/AddMasjidmembers/generateEmailRepo.dart';

class CreateEmailAddressSuffaMembersViewModel extends GetxController {
  final GenerateEmailSuffaMembersRepo _createEmailRepo =
      GenerateEmailSuffaMembersRepo();
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
        The Member Requested To enter innto  the team 
        Email    : $email
        Password : $pass
      ''';
    try {
      await send(message, smtpServer);
      Get.snackbar('Successfull', 'Mail Sent to Admin');
    } catch (e) {
      Get.snackbar('Error', 'Error Occured');
    }
  }

  Future<void> createEmail(File file, name, emailAddress, phoneno, city,
      country, address, genEmail, genPassword) async {
    final result = await _createEmailRepo.createEmail(file, name, emailAddress,
        phoneno, city, country, address, genEmail, genPassword);
    if (result == null) {
      await sendEmail(
          'masabhaider4@gmail.com', genEmail.text, genPassword.text);
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
