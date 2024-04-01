import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  static int generateRandomNumber() {
    final random = Random();
    return 10000 + random.nextInt(900000);
  }

  // Save the data into the Shared Preferences
  static Future<void> saveData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  // Get The Saved Data
  static Future<String> getData(key) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = prefs.getString(key) ?? '';
    return data;
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

  // Shops Local Storage
  static Future<String> getShopID(key) async {
    final prefs = await SharedPreferences.getInstance();
    final String shopId = prefs.getString(key) ?? '';
    return shopId;
  }

  static Future<String> getShopName(key) async {
    final prefs = await SharedPreferences.getInstance();
    final String shopname = prefs.getString(key) ?? '';
    return shopname;
  }
}
