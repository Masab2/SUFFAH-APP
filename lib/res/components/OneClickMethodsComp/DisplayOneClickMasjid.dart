import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DisplayOneClickMasjid extends StatelessWidget {
  final String cnic, image, masjidaddress, muntazimid, masjidname, name;
  final String program;
  final VoidCallback ontap, onaddressClick;
  final String price, recivedDonnation, currency;
  const DisplayOneClickMasjid({
    super.key,
    required this.cnic,
    required this.image,
    required this.masjidaddress,
    required this.muntazimid,
    required this.program,
    required this.ontap,
    required this.price,
    required this.recivedDonnation,
    required this.currency,
    required this.onaddressClick,
    required this.masjidname,
    required this.name,
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
    return Container(
      margin: EdgeInsetsDirectional.only(
        bottom: context.mh * 0.02,
        start: context.mw * 0.02,
        end: context.mw * 0.02,
      ),
      height: context.mh * 0.32,
      decoration: BoxDecoration(
        color: AppColor.masjidgeryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: context.mw * 0.05,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [
                  AppColor.mehroonColor,
                  AppColor.brownColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    0.02.ph,
                    Row(
                      children: [
                        0.02.pw,
                        CircleAvatar(
                          radius: context.mh * 0.04,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        l10n!.cnicTitle,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        cnic,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.013,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Muntazim Name',
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        name,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.013,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        l10n.addressTitle,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.015,
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
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        l10n.masjidNameTitle,
                                        style: GoogleFonts.poppins(
                                          fontSize: context.mh * 0.015,
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
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: context.mw * 0.03,
                              ),
                              child: InkWell(
                                onTap: onaddressClick,
                                child: Icon(
                                  Icons.store,
                                  size: context.mh * 0.035,
                                ),
                              ),
                            ),
                            0.02.ph,
                            Padding(
                              padding: EdgeInsets.only(
                                right: context.mw * 0.03,
                              ),
                              child: InkWell(
                                onTap: onaddressClick,
                                child: Icon(
                                  Icons.location_on,
                                  size: context.mh * 0.035,
                                ),
                              ),
                            ),
                          ],
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mw * 0.12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ammount Recived',
                                style: GoogleFonts.poppins(
                                  fontSize: context.mh * 0.013,
                                ),
                              ),
                              Text(
                                'Ammount Raised',
                                style: GoogleFonts.poppins(
                                  fontSize: context.mh * 0.013,
                                ),
                              )
                            ],
                          ),
                          Row(
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
                        ],
                      ),
                    ),
                    Visibility(
                      visible: recivedDonnation == price ? false : true,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10),
                        ),
                        color: AppColor.mehroonColor,
                        minWidth: context.mw * 0.55,
                        onPressed: ontap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.donateNowtitle,
                              style: GoogleFonts.poppins(
                                fontSize: context.mh * 0.017,
                                color: AppColor.whiteColor,
                              ),
                            ),
                            0.03.pw,
                            Icon(
                              IconlyLight.heart,
                              color: AppColor.whiteColor,
                              size: context.mh * 0.023,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
