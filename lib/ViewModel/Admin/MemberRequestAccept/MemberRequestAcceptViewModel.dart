import 'package:get/get.dart';
import 'package:suffa_app/Repository/AdminRepo/MemberRequestRepo/MemberRequestRepo.dart';

class MemberRequestAcceptViewModel extends GetxController {
  final MemberRequestRepo _requestRepo = MemberRequestRepo();

  void acceptRequest(id) async {
    final result = await _requestRepo.acceptRequest(id);
    if (result == null) {
      Get.snackbar('Successfull', result.toString());
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
