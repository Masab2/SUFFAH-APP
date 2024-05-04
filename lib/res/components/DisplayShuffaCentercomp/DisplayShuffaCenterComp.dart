// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DisplayShuffaCenterCompToAdmin extends StatelessWidget {
  final VoidCallback onGreenBtnPressed, onGreyBtnPressed;
  final String greenBtnText, greyBtnText;
  final String title, image, email, address, centerId, city;
  const DisplayShuffaCenterCompToAdmin({
    super.key,
    required this.title,
    required this.image,
    required this.email,
    required this.onGreenBtnPressed,
    required this.centerId,
    required this.address,
    required this.city,
    required this.onGreyBtnPressed,
    required this.greenBtnText,
    required this.greyBtnText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(centerId,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.012,
                      color: AppColor.geryColor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  height: context.mw * 0.4,
                  width: context.mw * 0.4,
                  fit: BoxFit.cover,
                  imageUrl: image,
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
              0.02.pw,
              Container(
                padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
                height: context.mh * 0.20,
                width: context.mw / 2.2,
                // color: AppColor.geryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    0.03.ph,
                    Text(title,
                        style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.018,
                            color: AppColor.geryColor,
                            fontWeight: FontWeight.bold)),
                    0.01.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(email,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppColor.mehroonColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    0.01.ph,
                    Text(city.toUpperCase(),
                        style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.013,
                            color: AppColor.geryColor,
                            fontWeight: FontWeight.bold)),
                    0.01.ph,
                    Expanded(
                      child: Text(
                        address.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.015,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          0.01.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MaterialButton(
                    minWidth: context.mw * 0.30,
                    color: AppColor.mehroonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: onGreenBtnPressed,
                    child: Text(greenBtnText,
                        style: GoogleFonts.poppins(color: AppColor.whiteColor)),
                  ),
                ),
              ],
            ),
          ),
          0.02.ph,
          const Divider(
            thickness: 2.0,
            endIndent: 20,
            indent: 20,
            color: AppColor.geryColor,
          )
        ],
      ),
    );
  }
}
