// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class CustomContainer extends StatelessWidget {
  final String title, profile;
  const CustomContainer({
    super.key,
    required this.title,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profile == ''
            ? CircleAvatar(
                radius: context.mh * 0.10,
                backgroundColor: AppColor.brownColor,
                child: Icon(
                  IconlyBold.profile,
                  size: context.mh * 0.10,
                ),
              )
            : CachedNetworkImage(
                height: context.mw * 0.4,
                width: context.mw * 0.4,
                fit: BoxFit.cover,
                imageUrl: profile,
                placeholder: (context, url) => const SpinKitChasingDots(
                  color: AppColor.mehroonColor,
                  duration: Duration(seconds: 5),
                  size: 40,
                ),
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error);
                },
              ),
        0.02.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(IconlyBold.message),
            0.02.pw,
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.020,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        0.01.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyBold.location,
              size: context.mh * 0.022,
            ),
            0.02.pw,
            Text(
              'Pakistan',
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.015,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor,
              ),
            ),
            0.02.pw,
            Icon(
              Icons.monetization_on_outlined,
              size: context.mh * 0.022,
            ),
            0.02.pw,
            Text(
              'PKR',
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.015,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor,
              ),
            ),
            0.02.pw,
            Icon(
              Icons.language,
              size: context.mh * 0.022,
            ),
            0.02.pw,
            Text(
              'English',
              style: GoogleFonts.poppins(
                fontSize: context.mh * 0.015,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor,
              ),
            )
          ],
        ),
      ],
    );
  }
}
