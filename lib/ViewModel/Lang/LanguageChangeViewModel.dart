import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageController extends GetxController {
  final Rx<Locale?> _appLocale = Rx<Locale?>(null);
  Locale? get appLocal => _appLocale.value;
   Map<String, dynamic>? _translations;
  @override
  void onInit() {
    super.onInit();
    fetchLocale();
  }

  Future<void> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale.value = const Locale('en');
      return;
    }
    String local = prefs.getString('language_code') ?? 'en';
    _appLocale.value = Locale(local.toString());
    return;
  }

  Future<void> changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale.value == type) {
      return;
    }
    if (type == const Locale("de")) {
      log(type.toString());
      _appLocale.value = const Locale("de");
      await prefs.setString('language_code', 'de');
      await prefs.setString('countryCode', 'de');
    } else if (type == const Locale("en")) {
      log(type.toString());
      _appLocale.value = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'en');
    } else if (type == const Locale("ur")) {
      log(type.toString());
      _appLocale.value = const Locale("ur");
      await prefs.setString('language_code', 'ur');
      await prefs.setString('countryCode', 'ur');
    }
    update();
  }

  void loadTranslations() {
    String jsonContent = ''; // Load JSON content from your assets
    // Load translations based on the selected language
    switch (_appLocale.value?.languageCode) {
      case 'en':
        jsonContent = ''; // Load en.json content
        break;
      case 'de':
        jsonContent = ''; // Load de.json content
        break;
      case 'ur':
        jsonContent = ''; // Load ur.json content
        break;
      // Add cases for other supported languages
      default:
        jsonContent = ''; // Load default language content
    }

    // Parse JSON content into Map
    _translations = json.decode(jsonContent);
  }

  String translateDynamicData(String dynamicData) {
    // Replace placeholders in dynamic data with translations
    if (_translations != null) {
      _translations!.forEach((key, value) {
        dynamicData = dynamicData.replaceAll('{$key}', value);
      });
    }
    return dynamicData;
  }
}
