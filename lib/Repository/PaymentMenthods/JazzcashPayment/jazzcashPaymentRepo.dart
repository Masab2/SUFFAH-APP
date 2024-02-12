import 'dart:developer';

import 'package:suffa_app/Model/JazzCashpaymentModel/jazzCashPayment.dart';
import 'package:suffa_app/data/Network/BaseApiServices.dart';
import 'package:suffa_app/data/Network/NetworkApiService.dart';
import 'package:suffa_app/utils/Api/appurl.dart';

class JazzcashPaymentRepo {
  final BaseApi _api = NetworkApis();
  Future<JazzcashModel?> jazzCashPayment(data) async {
    try {
      dynamic response = await _api.getPostApiServies(AppUrls.baseUrl, data);
      String responseMessage = response['pp_ResponseMessage'];
      log(responseMessage);
      return JazzcashModel.fromJson(response);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
