// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/constant/constant.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MasjidDisplayComp extends StatelessWidget {
  final String masjidname, image, masjidaddress, muntazimid, country;
  final String program;
  final VoidCallback ontap;
  final VoidCallback onlocation;
  final dynamic receivedDonationsCount;
  final dynamic waitingCount;
  int? peopleCount = 0;
  double waitngPeople = 0.0;
  double receivedDonation = 0.0;

  MasjidDisplayComp({
    super.key,
    required this.masjidname,
    required this.image,
    required this.masjidaddress,
    required this.ontap,
    required this.program,
    required this.muntazimid,
    required this.receivedDonationsCount,
    required this.waitingCount,
    required this.onlocation,
    required this.country,
    this.peopleCount,
  });

  // Method to fetch waiting people count from Firebase
  Future<int> fetchWaitingPeopleCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection(suffahCenterNeedyPeople)
          .where('program', isEqualTo: program)
          .where('MuntazimId', isEqualTo: muntazimid)
          .get();
      return snapshot.size;
    } catch (e) {
      log('Error fetching waiting people count: $e');
      return 0;
    }
  }

  Future<double> calculatebar() async {
    double progressRatio = 0.0;
    try {
      int waitingPeopleint = await fetchWaitingPeopleCount();
      waitngPeople = waitingPeopleint.toDouble();
      receivedDonation = double.parse(receivedDonationsCount.toString());
      log(waitngPeople.toString());
      if (receivedDonation > 0) {
        progressRatio = receivedDonation / waitngPeople;
      }
    } catch (e) {
      log('Error parsing donation amounts: $e');
    }
    return progressRatio;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: context.mw * 0.03,
            vertical: context.mh * 0.01,
          ),
          width: context.mw,
          height: context.mh * 0.22,
          decoration: BoxDecoration(
            color: AppColor.masjidgeryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              0.03.pw,
              CircleAvatar(
                radius: context.mh * 0.08,
                backgroundImage: NetworkImage(image),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        0.01.ph,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.mw * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n!.countryTitle,
                                style: GoogleFonts.poppins(
                                  fontSize: context.mh * 0.018,
                                ),
                              ),
                              Text(
                                country,
                                style: GoogleFonts.poppins(
                                  fontSize: context.mh * 0.018,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              masjidname,
                              style: GoogleFonts.poppins(
                                fontSize: context.mh * 0.020,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              onPressed: onlocation,
                              icon: const Icon(IconlyBold.location),
                            )
                          ],
                        ),
                        0.02.ph,
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.mw * 0.04,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.recivedTitle,
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.017,
                                    ),
                                  ),
                                  Text(
                                    l10n.waiting,
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.017,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            0.01.ph,
                            FutureBuilder<double>(
                              future: calculatebar(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('Loading');
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  double progressRatio = snapshot.data ?? 0.0;

                                  return SimpleAnimationProgressBar(
                                    height: context.mh * 0.02,
                                    width: context.mw * 0.53,
                                    backgroundColor: AppColor.brownColor,
                                    foregrondColor: AppColor.mehroonColor,
                                    ratio:
                                        progressRatio, // Set ratio with the calculated value
                                    direction: Axis.horizontal,
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    duration: const Duration(seconds: 3),
                                    borderRadius: BorderRadius.circular(5),
                                  );
                                }
                              },
                            ),
                            0.01.ph,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.mw * 0.04,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    receivedDonationsCount.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.017,
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream:
                                        Apis.getAllNeedyPeopleByProgramMasjid(
                                            program, muntazimid),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text('Loading');
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.docs.isEmpty) {
                                        return const Text('0');
                                      } else {
                                        peopleCount =
                                            snapshot.data!.docs.length;
                                        return Text(peopleCount.toString());
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            0.01.ph,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        FutureBuilder<double>(
            future: calculatebar(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                double progressRatio = snapshot.data ?? 0.0;
                return Visibility(
                  visible: progressRatio == 1.0 ? false : true,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    color: AppColor.mehroonColor,
                    minWidth: context.mw * 0.55,
                    onPressed: ontap,
                    child: Text(
                      l10n.donateMasjid,
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.017,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }
}
