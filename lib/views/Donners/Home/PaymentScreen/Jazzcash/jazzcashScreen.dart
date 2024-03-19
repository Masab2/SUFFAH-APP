import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late String requiredDonnation;
  late String image;
  late String currency;
  late String personcnic;
  late String personame;
  late String dateofBirth;
  late String dateofCardExpire;
  late String dateofCardIssue;
  late String personId;
  late String personPhoneNo;
  late String personaddress;
  late String personprofile;
  late String personGender;
  late String masjidname;
  late String masjidid;
  late String masjidAddress;
  late String masjidCountry;
  late String masjidCity;
  late String masjidState;
  late String masjidemail;
  late String program;
  @override
  void initState() {
    totalPrice = Get.arguments[0];
    requiredDonnation = Get.arguments[1];
    image = Get.arguments[2].toString();
    currency = Get.arguments[3].toString();
    personcnic = Get.arguments[4];
    personame = Get.arguments[5];
    dateofBirth = Get.arguments[6];
    dateofCardExpire = Get.arguments[7];
    dateofCardIssue = Get.arguments[8] ?? '';
    personId = Get.arguments[9];
    personPhoneNo = Get.arguments[10];
    personaddress = Get.arguments[11];
    personprofile = Get.arguments[12];
    personGender = Get.arguments[13];
    masjidname = Get.arguments[14];
    masjidid = Get.arguments[15];
    masjidAddress = Get.arguments[16];
    masjidCountry = Get.arguments[17];
    masjidCity = Get.arguments[18];
    masjidState = Get.arguments[19];
    masjidemail = Get.arguments[20];
    program = Get.arguments[21];
    super.initState();
  }

  @override
  void dispose() {
    paymentNoController.dispose();
    super.dispose();
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async {
                          // program,
                          // requiredDonnation,
                          // masjidname,
                          // masjidId,
                          // muntazimId,
                          // masjidAddress,
                          // masjidCountry,
                          // masjidCity,
                          // masjidstate,
                          // masjidEmail,
                          // personcnic,
                          // personame,
                          // dateofBirth,
                          // dateofCardExpire,
                          // dateofCardIssue,
                          // personId,
                          // personPhoneNo,
                          // personaddress,
                          // personprofile,
                          // personGender,
                          // List<DonnerModel> donnerlist,
                          // var key = utf8.encode(IntegeritySalt);
                          // var bytes = utf8.encode(superdata);
                          // var hmacSha256 = Hmac(sha256, key);
                          // Digest sha256Result = hmacSha256.convert(bytes);
                          // await jazzcashPayment.jazzCashPayment(
                          //   totalPrice,
                          //   paymentNoController.text.toString(),
                          //   sha256Result.toString(),
                          //   context,
                          //   program,
                          //   requiredDonnation,
                          //   masjidname,
                          //   masjidid,
                            
                          // );
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
