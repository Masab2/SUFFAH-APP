import 'package:get/get.dart';
import 'package:suffa_app/Repository/PaymentMenthods/JazzcashPayment/jazzcashPaymentRepo.dart';
import 'package:suffa_app/utils/constant/constant.dart';

class JazcashPaymentViewModel extends GetxController {
  final JazzcashPaymentRepo _repo = JazzcashPaymentRepo();
  Future<void> jazzCashPayment(ammount, phoneno, ppsecurehash) async {
    _repo.jazzCashPayment({
      "pp_Version": pp_ver,
      "pp_TxnType": pp_TxnType,
      "pp_Language": pp_Language,
      "pp_MerchantID": pp_MerchantID,
      "pp_Password": pp_Password,
      "pp_TxnRefNo": tre,
      "pp_Amount": ammount,
      "pp_TxnCurrency": pp_TxnCurrency,
      "pp_TxnDateTime": pp_TxnDateTime,
      "pp_BillReference": pp_BillReference,
      "pp_Description": pp_Description,
      "pp_TxnExpiryDateTime": pp_TxnExpireDateTime,
      "pp_ReturnURL": pp_ReturnUrl,
      "pp_SecureHash": ppsecurehash,
      "ppmpf_1": phoneno,
    }).then((value) {
      Get.snackbar(
          'Paymant Successfull', 'Your Donnation is Successfull Transfer');
    }).onError((error, stackTrace) {
      Get.snackbar('Error', 'Error Occured While Transaction');
    });
  }
}
