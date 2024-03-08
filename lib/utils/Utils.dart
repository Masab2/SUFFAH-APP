import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
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

  // Donnation Ammount Dialog
  static showDonnationDialog(
    TextEditingController controller,
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Donation Amount'),
          content: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
              hintText: 'Enter donation amount',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Donate'),
            ),
          ],
        );
      },
    );
  }
}
