import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Repository/AdminRepo/MemberRequestRepo/MemberRequestRepo.dart';

class MemberRequestAcceptViewModel extends GetxController {
  final MemberRequestRepo _requestRepo = MemberRequestRepo();

  void acceptRequest(id, BuildContext context) async {
    final result = await _requestRepo.acceptRequest(
      id,
      context,
    );
    if (result == null) {
      Get.snackbar('Successfull', result.toString());
    } else {
      Get.snackbar('Error', result.toString());
    }
  }
}
