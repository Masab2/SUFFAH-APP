import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Model/DonnationTrackModel/donnationTrackModel.dart';
import 'package:suffa_app/Model/donnerModel/donnerModel.dart';
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
  late DonnationTrackModel model;
  late List<DonnerModel> donnermodel;

  @override
  void initState() {
    model = Get.arguments[0];
    donnermodel = Get.arguments[1];
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
              image: model.image,
              donnationprice: '${model.currency} ${model.donnationAmmount}',
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
                  paymentname: 'JazzCash',
                  image: ImageAsset.jazzcashimg,
                  ontap: () {
                    Get.toNamed(
                      RoutesNames.jazzCashPaymentScreen,
                      arguments: [
                        model,
                        donnermodel,
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
