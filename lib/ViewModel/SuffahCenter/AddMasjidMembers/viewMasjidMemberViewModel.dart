import 'dart:developer';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class ViewMasjidMemberViewModel extends GetxController {
  Future<void> launchPhoneApp(String phoneNumber) async {
    Uri uri = Uri.parse('tel:$phoneNumber');
    if (!await launcher.launchUrl(uri)) {
      log('Could Not Launch The Url$uri');
    }
  }

  // Open Google Maps According to Address
  void openGoogleMap(String address) async {
    String url = "https://www.google.com/maps/search/?api=1&query=$address";
    await launcher.launchUrl(Uri.parse(url));
  }
}
