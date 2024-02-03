import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  // Create the Unique Id for the Service provider
  static int generateRandomNumber() {
    final random = Random();
    return 10000 + random.nextInt(900000);
  }

  // Save the data into the Shared Preferences
  static Future<void> saveData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  static Future<String> getId(key) async {
    final prefs = await SharedPreferences.getInstance();
    final String Id = prefs.getString(key) ?? '';
    return Id;
  }
  static Future<String> getMasjid(key) async {
    final prefs = await SharedPreferences.getInstance();
    final String masjidname = prefs.getString(key) ?? '';
    return masjidname;
  }
  static Future<String> getMasjidID(key) async {
    final prefs = await SharedPreferences.getInstance();
    final String masjidname = prefs.getString(key) ?? '';
    return masjidname;
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
