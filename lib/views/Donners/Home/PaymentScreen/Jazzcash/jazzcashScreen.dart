import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Model/alSuffahPersonModel/suffaPersonModel.dart';
import 'package:suffa_app/ViewModel/PaymentMethods/JazzCash/jazzcashPaymentViewModel.dart';
import 'package:suffa_app/res/components/Payments/JazzCashPayment/jazzCashPaymentComp.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../../../../../utils/constant/constant.dart';

class JazzCashView extends StatefulWidget {
  const JazzCashView({super.key});

  @override
  State<JazzCashView> createState() => _JazzCashViewState();
}

class _JazzCashViewState extends State<JazzCashView> {
  final jazzcashPayment = Get.put(JazcashPaymentViewModel());
  final paymentNoController = TextEditingController();
  late String totalPrice;
  late List<SuffahPersonModel> addedPeople;
  @override
  void initState() {
    totalPrice = Get.arguments[0];
    addedPeople = Get.arguments[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JazzCash Payment',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
          child: Column(
            children: [
              Image.asset(
                ImageAsset.jazzcashimg, // Path to JazzCash logo image
                width: 150.0,
              ),
              0.02.ph,
              Text(
                'Enter JazzCash Number:',
                style: TextStyle(
                  fontSize: context.mh * 0.017,
                  fontWeight: FontWeight.w600,
                ),
              ),
              0.02.ph,
              JazzCashNumberFormField(
                controller: paymentNoController,
              ),
              0.02.ph,
              Obx(() {
                return jazzcashPayment.isLoading.value == false
                    ? MaterialButton(
                        minWidth: context.mw * 0.70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () async {
                          var key = utf8.encode(IntegeritySalt);
                          var bytes = utf8.encode(superdata);
                          var hmacSha256 = Hmac(sha256, key);
                          Digest sha256Result = hmacSha256.convert(bytes);
                          await jazzcashPayment.jazzCashPayment(
                            totalPrice,
                            paymentNoController.text.toString(),
                            sha256Result.toString(),
                            context,
                          );
                        },
                        color: const Color(0xFF00A859), // JazzCash color
                        textColor: Colors.white,
                        child: Text(
                          'Proceed to Payment',
                          style: TextStyle(
                            fontSize: context.mh * 0.017,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : const CircularProgressIndicator.adaptive();
              })
            ],
          ),
        ),
      ),
    );
  }
}
