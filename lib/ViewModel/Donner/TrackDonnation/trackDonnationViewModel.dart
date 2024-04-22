import 'package:get/get.dart';

class TrackDonnationViewModel extends GetxController {
  var selectedIndex = 0.obs;

  void selectTab(int index) {
    selectedIndex.value = index;
  }
}