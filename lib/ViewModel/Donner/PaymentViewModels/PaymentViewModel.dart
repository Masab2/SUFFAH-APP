import 'package:get/get.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';

class PaymentViewModel extends GetxController {
  RxList paymentMethods = [
    ImageAsset.jazzcashimg,
    ImageAsset.easyPisaimg,
    ImageAsset.paypalimg,
    ImageAsset.googlePayimg,
    ImageAsset.applePayimg,
  ].obs;

  var paymentName = ImageAsset.jazzcashimg.obs;
  setMethods(value) {
    paymentName.value = value;
  }
}
