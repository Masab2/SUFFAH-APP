import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisplayNeedyPeopleComp extends StatelessWidget {
  final String masjidname, image, masjidaddress, muntazimid, cnicno;
  final String program;
  final VoidCallback ontap;
  final String price, recivedDonnation, currency;
  const DisplayNeedyPeopleComp({
    super.key,
    required this.masjidname,
    required this.image,
    required this.masjidaddress,
    required this.ontap,
    required this.program,
    required this.muntazimid,
    required this.cnicno,
    required this.price,
    required this.recivedDonnation,
    required this.currency,
  });
  double calculatebar() {
    // Calculate the progress ratio
    double progressRatio = 0.0;
    try {
      double requiredAmount = double.parse(price);
      double receivedAmount = double.parse(recivedDonnation);
      if (requiredAmount > 0) {
        progressRatio = receivedAmount / requiredAmount;
      }
    } catch (e) {
      log('Error parsing donation amounts: $e');
    }
    return progressRatio;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: context.mw * 0.03,
              vertical: context.mh * 0.01,
            ),
            height: context.mh * 0.25,
            width: context.mw,
            decoration: BoxDecoration(
                color: AppColor.masjidgeryColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                0.02.ph,
                Row(
                  children: [
                    0.02.pw,
                    CircleAvatar(
                      radius: context.mh * 0.06,
                      backgroundImage: NetworkImage(image),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: context.mw * 0.03,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    l10n!.cnicTitle,
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.018,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    cnicno,
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.013,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    l10n.nameTitle,
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.018,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    masjidname,
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.013,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    l10n.addressTitle,
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.018,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    masjidaddress,
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.013,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                0.01.ph,
                Text(
                  program,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SimpleAnimationProgressBar(
                  height: context.mh * 0.01,
                  width: context.mw * 0.70,
                  backgroundColor: AppColor.brownColor,
                  foregrondColor: AppColor.mehroonColor,
                  ratio: calculatebar(),
                  direction: Axis.horizontal,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(seconds: 3),
                  borderRadius: BorderRadius.circular(5),
                ),
                0.01.ph,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.mw * 0.12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$currency $recivedDonnation',
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.015,
                        ),
                      ),
                      Text(
                        '$currency $price',
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.015,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            color: AppColor.mehroonColor,
            minWidth: context.mw * 0.55,
            onPressed: ontap,
            child: Text(
              l10n.donateNowtitle,
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.017,
                color: AppColor.whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DisplayPaymentMethodComp extends StatelessWidget {
  final String paymentname, image, paymentDescrip;
  final VoidCallback ontap;
  final Color color;
  const DisplayPaymentMethodComp({
    super.key,
    required this.paymentname,
    required this.image,
    required this.ontap,
    required this.color,
    required this.paymentDescrip,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: context.mw * 0.30,
                      padding:
                          EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.geryColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: AssetImage(image),
                          height: context.mw * 0.15,
                          width: context.mw * 0.20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: context.mw * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentname,
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.020,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paymentDescrip,
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.014,
                            fontWeight: FontWeight.w500,
                            color: AppColor.geryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentUperheading extends StatelessWidget {
  final String image, donnationprice ,title;
  const PaymentUperheading({
    super.key,
    required this.image,
    required this.donnationprice, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.mh * 0.30,
          width: double.infinity,
          child: Image(
            image: NetworkImage(image),
            fit: BoxFit.cover,
            height: context.mh * 0.30,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: context.mh * 0.07,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  gradient: const LinearGradient(
                    colors: [
                      AppColor.mehroonColor,
                      AppColor.brownColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                    child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.023,
                    color: AppColor.whiteColor,
                  ),
                )),
              ),
            ),
            Container(
              width: context.mw * 0.40,
              height: context.mh * 0.07,
              decoration: BoxDecoration(
                border: Border.all(width: 2),
              ),
              child: Center(
                  child: Text(
                donnationprice,
                style: GoogleFonts.poppins(
                  fontSize: context.mh * 0.023,
                ),
              )),
            ),
          ],
        )
      ],
    );
  }
}
