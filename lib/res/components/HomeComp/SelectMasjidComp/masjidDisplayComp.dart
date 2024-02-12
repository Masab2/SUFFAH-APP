import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MasjidDisplayComp extends StatelessWidget {
  final String masjidname, image, masjidaddress, muntazimid;
  final String program;
  final VoidCallback ontap;
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
  });

  @override
  Widget build(BuildContext context) {
    final totalDonationsCount = receivedDonationsCount + waitingCount;
    final double ratio = totalDonationsCount == 0
        ? 0
        : receivedDonationsCount / totalDonationsCount;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: context.mw * 0.03),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      height: context.mh * 0.15,
                      width: context.mw * 0.30,
                      imageUrl: image,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => const SpinKitChasingDots(
                        color: AppColor.cgreenColor,
                        duration: Duration(seconds: 5),
                        size: 40,
                      ),
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                  child: Column(
                    children: [
                      0.003.ph,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.mw * 0.03),
                              height: context.mh * 0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.geryColor.withOpacity(0.33),
                              ),
                              child: Center(
                                child: Text(
                                  program,
                                  style: GoogleFonts.poppins(
                                    fontSize: context.mh * 0.012,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          0.02.pw,
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.mw * 0.03),
                              height: context.mh * 0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.geryColor.withOpacity(0.33),
                              ),
                              child: Center(
                                child: Text(
                                  masjidname,
                                  style: GoogleFonts.poppins(
                                    fontSize: context.mh * 0.013,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      0.01.ph,
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                0.01.ph,
                                Text(
                                  'Recived',
                                  style: GoogleFonts.poppins(
                                    fontSize: context.mh * 0.015,
                                    fontWeight: FontWeight.bold,
                                    // color: AppColor.cgreenColor,
                                  ),
                                ),
                                Text(
                                  receivedDonationsCount.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: context.mh * 0.013,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.cgreenColor,
                                  ),
                                ),
                              ],
                            ),
                            0.23.pw,
                            Column(
                              children: [
                                0.01.ph,
                                Text(
                                  'Waiting',
                                  style: GoogleFonts.poppins(
                                    fontSize: context.mh * 0.015,
                                    fontWeight: FontWeight.bold,
                                    // color: AppColor.cgreenColor,
                                  ),
                                ),
                                Text(
                                  waitingCount.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: context.mh * 0.013,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.cgreenColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      0.01.ph,
                      SimpleAnimationProgressBar(
                        height: context.mh * 0.02,
                        width: context.mw * 0.55,
                        backgroundColor: Colors.grey.shade800,
                        foregrondColor: AppColor.cgreenColor,
                        ratio: ratio,
                        direction: Axis.horizontal,
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(seconds: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        0.02.ph,
        MaterialButton(
          minWidth: context.mw * 0.80,
          height: context.mh * 0.04,
          color: AppColor.cgreenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onPressed: ontap,
          child: Text(
            AppLocalizations.of(context)!.donateMasjid,
            style: GoogleFonts.poppins(
              fontSize: context.mh * 0.020,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        const Divider(
          endIndent: 20,
          indent: 20,
        ),
        0.02.ph,
      ],
    );
  }
}
