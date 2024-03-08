import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Model/alSuffahPersonModel/suffaPersonModel.dart';
import 'package:suffa_app/ViewModel/Donner/PaymentViewModels/PaymentViewModel.dart';
import 'package:suffa_app/res/components/DonnerDisplayNeedy/displayNeedypeople.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final paymentController = Get.put(PaymentViewModel());
  late String totalPrice;
  late String price;
  @override
  void initState() {
    totalPrice = Get.arguments[1];
    price = Get.arguments[2];
    super.initState();
  }

  @override
  void dispose() {
    paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donatation Summary',
            style: GoogleFonts.poppins(
              fontSize: context.mh * 0.024,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            PaymentUperheading(
              image: ImageAsset.hungryimg,
              program: 'OneTimeMeal',
              donnationprice: 'PKR $totalPrice',
              noofMeals: 'Meal ${1.toString()}',
              actualPrice: price,
            ),
            0.05.ph,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.mw * 0.05,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Payment Methods',
                  style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            0.02.ph,
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                DisplayPaymentMethodComp(
                  paymentname: 'JazzCash',
                  image: ImageAsset.jazzcashimg,
                  ontap: () {
                    // Get.toNamed(
                    //   RoutesNames.jazzCashPaymentScreen,
                    //   arguments: [
                    //     totalPrice,
                    //   ],
                    // );
                  },
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With JazzCash',
                ),
                0.03.ph,
                DisplayPaymentMethodComp(
                  paymentname: 'EasyPaisa',
                  image: ImageAsset.easyPisaimg,
                  ontap: () {},
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With EasyPaisa',
                ),
                0.03.ph,
                DisplayPaymentMethodComp(
                  paymentname: 'PayPal',
                  image: ImageAsset.paypalimg,
                  ontap: () {},
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With PayPal',
                ),
                0.03.ph,
                DisplayPaymentMethodComp(
                  paymentname: 'GooglePay',
                  image: ImageAsset.googlePayimg,
                  ontap: () {},
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With GooglePay',
                ),
                0.03.ph,
                DisplayPaymentMethodComp(
                  paymentname: 'ApplePay',
                  image: ImageAsset.applePayimg,
                  ontap: () {},
                  color: AppColor.whiteColor,
                  paymentDescrip: 'Pay With ApplePay',
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
