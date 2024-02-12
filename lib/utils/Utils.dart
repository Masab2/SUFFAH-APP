import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  static String dateFormated(var date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyyMMddHHmmss').format(dateTime).toString();
  }

  static String dateFormatedExpire(var date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyyMMddHHmmss')
        .format(
          dateTime.add(
            const Duration(days: 1),
          ),
        )
        .toString();
  }

  static String translate(String data, String languageCode) {
    return Intl.message(data, locale: languageCode);
  }
}
