import 'package:get/get.dart';

class BottomnNavbarViewModel extends GetxController {
  RxInt page = 0.obs;

  void changePage(int newPage) {
    page.value = newPage;
  }
}
