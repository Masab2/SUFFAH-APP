import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:suffa_app/data/Network/BaseApiServices.dart';

class NetworkApis extends BaseApi {
  @override
  Future getPostApiServies(String url, dynamic data) async {
    dynamic responsejson;
    try {
      final response = await http.post(Uri.parse(url), body: data);
      responsejson = returnresponse(response);
    } on SocketException {
      throw Exception('Network Error');
    }
    return responsejson;
  }


  dynamic returnresponse(http.Response response) {
    if (response.statusCode == 200) {
      dynamic responsejson = jsonDecode(response.body);
      return responsejson;
    } else {
      throw Exception('Network Error');
    }
  }
}
