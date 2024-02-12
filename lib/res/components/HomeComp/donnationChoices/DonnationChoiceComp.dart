// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DonnationChoice extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback ontap;
  final String program;
  // int previousTotalNeedyPeople;
  // static int totalDonations = 0;
  const DonnationChoice({
    super.key,
    required this.image,
    required this.title,
    required this.ontap,
    required this.program,
    // this.previousTotalNeedyPeople = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.mh * 0.25,
          width: context.mw,
          margin: EdgeInsets.symmetric(
            horizontal: context.mw * 0.02,
            vertical: context.mh * 0.02,
          ),
          decoration: BoxDecoration(
            // color: AppColor.cgreenColor,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              opacity: 0.83,
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(context.mw * 0.016),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            height: context.mh * 0.15,
            width: context.mw * 0.120,
            margin: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
            decoration: BoxDecoration(
              color: AppColor.whiteColor.withOpacity(0.43),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColor.cgreenColor.withOpacity(0.33),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  0.009.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.020,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  0.008.ph,
                  Column(
                    children: [
                      StreamBuilder(
                          stream: Apis.getAllNeedyPeopleByProgram(program),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: SpinKitChasingDots(
                                  color: AppColor.cgreenColor,
                                  duration: Duration(seconds: 5),
                                  size: 40,
                                ),
                              );
                            } else if (!snapshot.hasData) {
                              return const Center(child: Text('No Data Found'));
                            } else {
                              // int totalNeedyPeople = snapshot.data!.docs.length;
                              // int temp = totalNeedyPeople;
                              // log(temp.toString());
                              // if (totalNeedyPeople < 0) {
                              //   totalNeedyPeople = 0;
                              // } else {
                              //   totalNeedyPeople -= 1;
                              //   if (totalNeedyPeople < temp) {
                              //     totalDonations += 1;
                              //   }
                              // }
                              return Column(
                                children: [
                                  SimpleAnimationProgressBar(
                                    height: context.mh * 0.02,
                                    width: context.mw * 0.70,
                                    backgroundColor: Colors.grey.shade800,
                                    foregrondColor: AppColor.cgreenColor,
                                    ratio: 3 / 10,
                                    direction: Axis.horizontal,
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    duration: const Duration(seconds: 3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: context.mw * 0.10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Ammount Rasied',
                                          style: GoogleFonts.poppins(
                                            fontSize: context.mh * 0.014,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                        Text(
                                          '1000 Rs',
                                          style: GoogleFonts.poppins(
                                            fontSize: context.mh * 0.014,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                    ],
                  ),
                  // 0.007.ph,
                  MaterialButton(
                    minWidth: context.mw * 0.50,
                    height: context.mh * 0.04,
                    color: AppColor.cgreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: ontap,
                    child: Text(
                      AppLocalizations.of(context)!.donnateNow,
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.020,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                  0.01.ph,
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
