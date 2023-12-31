import 'package:flutter/material.dart';

class Utils {
  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
