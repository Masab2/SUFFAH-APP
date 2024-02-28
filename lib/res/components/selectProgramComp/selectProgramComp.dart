import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SelectProgramComp extends StatelessWidget {
  final String image;
  final String title;
  final String buttonTitle;
  final VoidCallback ontap;
  const SelectProgramComp(
      {super.key,
      required this.image,
      required this.title,
      required this.buttonTitle,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.mh * 0.25,
          width: context.mw * 0.90,
          margin: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.01),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              height: context.mh * 0.15,
              width: context.mw * 0.30,
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
        ),
        Positioned(
            left: context.mw * 0.030,
            bottom: -10,
            right: context.mw * 0.030,
            child: Container(
              height: context.mh * 0.10,
              width: context.mw * 0.70,
              margin: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.mehroonColor.withOpacity(0.33),
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  TextButton(
                      onPressed: ontap,
                      child: Text(
                        buttonTitle,
                        style: GoogleFonts.poppins(
                          color: AppColor.mehroonColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  0.04.ph,
                ],
              ),
            )),
      ],
    );
  }
}
