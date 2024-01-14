import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailAuth {
  static Future<void> sendEmail(
      String recipentEmail, String email, String pass, subject) async {
    String username = 'suffa36@gmail.com';
    String password = 'myxmbldopdwvvvpv';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'SUFFAH APP')
      ..recipients.add(recipentEmail)
      ..subject = subject
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
}