// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/JazzCashpaymentModel/jazzCashPayment.dart';
import 'package:suffa_app/Model/alSuffahPersonModel/suffaPersonModel.dart';
import 'package:suffa_app/Repository/PaymentMenthods/JazzcashPayment/jazzcashPaymentRepo.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/Payments/JazzCashPayment/PaymentReciptDialog/paymentReciptDialog.dart';
import 'package:suffa_app/utils/Utils.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class JazcashPaymentViewModel extends GetxController {
  final JazzcashPaymentRepo _repo = JazzcashPaymentRepo();
  RxBool isLoading = false.obs;

  Future<void> jazzCashPayment(
      ammount, phoneno, ppsecurehash, BuildContext context) async {
    try {
      isLoading(true);
      dynamic response = await _repo.jazzCashPayment({
        "pp_Version": pp_ver,
        "pp_TxnType": pp_TxnType,
        "pp_Language": pp_Language,
        "pp_MerchantID": pp_MerchantID,
        "pp_Password": pp_Password,
        "pp_TxnRefNo": "T${Utils.dateFormated(
          DateTime.now().toString(),
        )}",
        "pp_Amount": ammount,
        "pp_TxnCurrency": pp_TxnCurrency,
        "pp_TxnDateTime": Utils.dateFormated(
          DateTime.now().toString(),
        ),
        "pp_BillReference": pp_BillReference,
        "pp_Description": pp_Description,
        "pp_TxnExpiryDateTime": Utils.dateFormatedExpire(
          DateTime.now().toString(),
        ),
        "pp_ReturnURL": pp_ReturnUrl,
        "pp_SecureHash": ppsecurehash,
        "ppmpf_1": phoneno,
      });

      if (response != null) {
        JazzcashModel jazzcashResponse = response;
        updateStatusForAddedPeople();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return JazzCashPaymentReceiptDialog(
                amount: "$ammount PKR",
                recipientName: jazzcashResponse.ppmpf1.toString(),
                transactionId: jazzcashResponse.ppTxnRefNo.toString(),
                date: Utils.dateFormated(
                  DateTime.now().toString(),
                ));
          },
        );
        if (kDebugMode) {
          print(jazzcashResponse.ppResponseMessage);
        }
      } else {
        if (kDebugMode) {
          print("Error occurred during Jazzcash payment.");
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Error Occurred While Transaction');
    } finally {
      isLoading(false);
    }
  }

  void updateStatusForAddedPeople() {
    final List<SuffahPersonModel> addedPeople = Get.arguments[1];
    addedPeople.forEach((person) async {
      if (person.tempstatus == 'Added') {
        await Apis.updateStatusAlSuffahPersonGotDonnation(
            person.personId, 'Pending');
      }
    });
  }
}
