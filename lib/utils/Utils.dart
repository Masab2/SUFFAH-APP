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
}
