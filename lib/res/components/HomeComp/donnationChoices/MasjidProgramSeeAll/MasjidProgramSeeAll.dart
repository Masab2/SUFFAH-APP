import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DonnationChoiceMasjidComp extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback ontap;
  final String program;
  const DonnationChoiceMasjidComp({
    super.key,
    required this.image,
    required this.title,
    required this.ontap,
    required this.program,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: context.mw * 0.85,
            margin: EdgeInsets.fromLTRB(context.mw * 0.05, context.mh * 0.01,
                context.mw * 0.002, context.mw * 0.01),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    height: context.mh * 0.15,
                    width: context.mw,
                    fadeOutCurve: const FlippedCurve(Curves.easeOutCirc),
                    imageUrl: image,
                    matchTextDirection: true,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SpinKitChasingDots(
                      color: AppColor.mehroonColor,
                      duration: Duration(seconds: 5),
                      size: 40,
                    ),
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.023,
                    fontWeight: FontWeight.w700,
                    color: AppColor.mehroonColor,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SimpleAnimationProgressBar(
                        height: context.mh * 0.01,
                        width: context.mw * 0.70,
                        backgroundColor: Colors.grey.shade800,
                        foregrondColor: AppColor.mehroonColor,
                        ratio: 3 / 10,
                        direction: Axis.horizontal,
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(seconds: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: context.mw * 0.10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n!.ammountTitle,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            l10n.latestDonnationTitle,
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.013,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '200 PKR',
                            style: GoogleFonts.poppins(
                              fontSize: context.mh * 0.013,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      MaterialButton(
                        color: AppColor.mehroonColor,
                        height: context.mh * 0.06,
                        minWidth: context.mw * 0.60,
                        onPressed: ontap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          l10n.selectProgram,
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.017,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
