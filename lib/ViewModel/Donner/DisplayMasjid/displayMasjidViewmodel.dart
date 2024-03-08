import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class DisplayMasjidViewModel extends GetxController {
  // Open Google Maps According to Address
  void openGoogleMap(String address) async {
    String url = "https://www.google.com/maps/search/?api=1&query=$address";
    await launcher.launchUrl(Uri.parse(url));
  }
}
