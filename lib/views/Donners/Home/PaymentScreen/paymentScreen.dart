import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/ViewModel/Donner/PaymentViewModels/PaymentViewModel.dart';
import 'package:suffa_app/res/components/DonnerDisplayNeedy/displayNeedypeople.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final paymentController = Get.put(PaymentViewModel());
  late String donnationAmmount;
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
    donnationAmmount = Get.arguments[0].toString();
    requiredDonnation = Get.arguments[1].toString();
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
    paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PaymentUperheading(
              image: image,
              donnationprice: '$currency $donnationAmmount',
              title: l10n!.totalAmount,
            ),
            0.02.ph,
            Align(
              alignment: Alignment.center,
              child: Text(
                l10n.paymentMethods,
                style: GoogleFonts.poppins(
                  fontSize: context.mh * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            0.01.ph,
            Column(
              children: [
                DisplayPaymentMethodComp(
                  paymentname: masjidid,
                  image: ImageAsset.jazzcashimg,
                  ontap: () {
                    Get.toNamed(
                      RoutesNames.jazzCashPaymentScreen,
                      arguments: [
                        donnationAmmount,
                        requiredDonnation,
                        image,
                        currency,
                        personcnic,
                        personame,
                        dateofBirth,
                        dateofCardExpire,
                        dateofCardIssue,
                        personId,
                        personPhoneNo,
                        personaddress,
                        personprofile,
                        personGender,
                        masjidname,
                        masjidid,
                        masjidAddress,
                        masjidCountry,
                        masjidCity,
                        masjidState,
                        masjidemail,
                        program,
                      ],
                    );
                  },
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With JazzCash',
                ),
                0.02.ph,
                DisplayPaymentMethodComp(
                  paymentname: 'EasyPaisa',
                  image: ImageAsset.easyPisaimg,
                  ontap: () {},
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With EasyPaisa',
                ),
                0.02.ph,
                DisplayPaymentMethodComp(
                  paymentname: 'PayPal',
                  image: ImageAsset.paypalimg,
                  ontap: () {},
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With PayPal',
                ),
                0.02.ph,
                DisplayPaymentMethodComp(
                  paymentname: 'GooglePay',
                  image: ImageAsset.googlePayimg,
                  ontap: () {},
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With GooglePay',
                ),
                0.02.ph,
                DisplayPaymentMethodComp(
                  paymentname: 'ApplePay',
                  image: ImageAsset.applePayimg,
                  ontap: () {},
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With ApplePay',
                ),
                0.02.ph,
                DisplayPaymentMethodComp(
                  paymentname: 'Stripe',
                  image: ImageAsset.stripeicon,
                  ontap: () {},
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With Stripe',
                ),
                0.02.ph,
              ],
            ),
            0.03.ph,
          ],
        ),
      ),
    );
  }
}
