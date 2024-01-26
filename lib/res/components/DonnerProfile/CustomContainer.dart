// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class CustomContainer extends StatelessWidget {
  String title, subtitle;
  CustomContainer({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.mh * 0.12,
      padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
      margin: EdgeInsets.symmetric(
          horizontal: context.mw * 0.04, vertical: context.mh * 0.02),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              4.0, // Move to right 5  horizontally
              4.0, // Move to bottom 5 Vertically
            ),
          )
        ],
      ),
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: context.mh * 0.01),
          leading: Icon(
            Icons.account_circle_rounded,
            color: AppColor.cgreenColor,
            size: context.mh * 0.070,
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: context.mh * 0.020, fontWeight: FontWeight.bold)),
          ),
          subtitle: Text(subtitle,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: AppColor.geryColor,
                      fontSize: context.mh * 0.016,
                      fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }
}
