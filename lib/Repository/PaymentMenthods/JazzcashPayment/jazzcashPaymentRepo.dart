import 'dart:developer';

import 'package:suffa_app/data/Network/BaseApiServices.dart';
import 'package:suffa_app/data/Network/NetworkApiService.dart';
import 'package:suffa_app/utils/Api/appurl.dart';

class JazzcashPaymentRepo {
  final BaseApi _api = NetworkApis();
  Future<dynamic> jazzCashPayment(data) async {
    try {
      dynamic response = await _api.getPostApiServies(AppUrls.baseUrl, data);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
