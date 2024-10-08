// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suffa_app/Model/DonnationTrackMasjidModel/DonnationTrackMasjidModel.dart';
import 'package:suffa_app/Model/DonnationTrackModel/donnationTrackModel.dart';
import 'package:suffa_app/Model/JazzCashpaymentModel/jazzCashPayment.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
import 'package:suffa_app/Repository/PaymentMenthods/JazzcashPayment/jazzcashPaymentRepo.dart';
import 'package:suffa_app/Repository/PaymentMenthods/PaymentRepo/paymentRepo.dart';
import 'package:suffa_app/res/components/Payments/JazzCashPayment/PaymentReciptDialog/paymentReciptDialog.dart';
import 'package:suffa_app/utils/Utils.dart';
import 'package:suffa_app/utils/constant/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JazcashPaymentViewModel extends GetxController {
  final JazzcashPaymentRepo _repo = JazzcashPaymentRepo();
  final PaymentRepo _paymentRepo = PaymentRepo();
  RxBool isLoading = false.obs;

  Future<void> jazzCashPaymentForPerson(
    ammount,
    TextEditingController phoneno,
    ppsecurehash,
    BuildContext context,
    DonnationTrackModel? model,
    List<DonnerModel> donnerlist,
  ) async {
    final l10n = AppLocalizations.of(context);
    try {
     isLoading(true);
      if (phoneno.text.isEmpty || phoneno.text.length != 11) {
        Get.snackbar('Error', l10n!.dataEnterError);
        return;
      }
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
        "ppmpf_1": phoneno.text,
      });

      if (response != null) {
        JazzcashModel jazzcashResponse = response;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return JazzCashPaymentReceiptDialog(
              amount: "$ammount PKR",
              recipientName: jazzcashResponse.ppmpf1.toString(),
              transactionId: jazzcashResponse.ppTxnRefNo.toString(),
              date: Utils.dateFormated(
                DateTime.now().toString(),
              ),
            );
          },
        );
        if (kDebugMode) {
          print(jazzcashResponse.ppResponseMessage);
        }
        final result = await _paymentRepo.donnationTrackForPerson(
          model,
          donnerlist,
        );
        if (result == null) {
          Get.snackbar('Successfull', l10n!.donatedSuccessfully);
        } else {
          Get.snackbar('Error', l10n!.transactionError);
        }
      } else {
        if (kDebugMode) {
          print("Error occurred during Jazzcash payment.");
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // For Masjid Program
  Future<void> jazzCashPaymentForMasjid(
    ammount,
    TextEditingController phoneno,
    ppsecurehash,
    BuildContext context,
    DonnationTrackMasjidModel? model,
    List<DonnerModel> donnerlist,
  ) async {
    final l10n = AppLocalizations.of(context);
    try {
      isLoading(true);
      if (phoneno.text.isEmpty || phoneno.text.length != 11) {
        Get.snackbar('Error', l10n!.dataEnterError);
        return;
      }
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
        "ppmpf_1": phoneno.text,
      });

      if (response != null) {
        JazzcashModel jazzcashResponse = response;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return JazzCashPaymentReceiptDialog(
              amount: "$ammount PKR",
              recipientName: jazzcashResponse.ppmpf1.toString(),
              transactionId: jazzcashResponse.ppTxnRefNo.toString(),
              date: Utils.dateFormated(
                DateTime.now().toString(),
              ),
            );
          },
        );
        if (kDebugMode) {
          print(jazzcashResponse.ppResponseMessage);
        }
        final result = await _paymentRepo.donnationTrackForMasjid(
          model,
          donnerlist,
        );
        if (result == null) {
          Get.snackbar('Successfull', l10n!.donatedSuccessfully);
        } else {
          Get.snackbar('Error', l10n!.transactionError);
        }
      } else {
        if (kDebugMode) {
          print("Error occurred during Jazzcash payment.");
        }
      }
    } catch (e) {
      Get.snackbar('Error', l10n!.transactionError);
    } finally {
      isLoading(false);
    }
  }
}
