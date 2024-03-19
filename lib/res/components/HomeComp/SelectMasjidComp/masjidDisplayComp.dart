import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/utils/color/appColor.dart';
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
  const MasjidDisplayComp({
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
  });

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
                          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
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
                                    l10n!.recivedTitle,
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
                            SimpleAnimationProgressBar(
                              height: context.mh * 0.02,
                              width: context.mw * 0.53,
                              backgroundColor: AppColor.brownColor,
                              foregrondColor: AppColor.mehroonColor,
                              ratio: 0.5,
                              direction: Axis.horizontal,
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(seconds: 3),
                              borderRadius: BorderRadius.circular(5),
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
                                    '20',
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.017,
                                    ),
                                  ),
                                  Text(
                                    '20',
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.017,
                                    ),
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
        MaterialButton(
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
        )
      ],
    );
  }
}
