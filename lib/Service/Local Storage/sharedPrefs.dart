import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  
  // Create the Unique Id for the Service provider
  static int generateRandomNumber() {
    final random = Random();
    return 10000 + random.nextInt(900000);
  }

  static Future<void> saveRandomId() async {
    final prefs = await SharedPreferences.getInstance();
    final randomNumber = generateRandomNumber();
    await prefs.setInt('uniqueId', randomNumber);
  }

  static Future<int> getRandomId() async {
    final prefs = await SharedPreferences.getInstance();
    final int uniqueId = prefs.getInt('uniqueId') ?? 0;
    return uniqueId;
  }
}
