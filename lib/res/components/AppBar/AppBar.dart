// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';

class HomeAppBar {
  static PreferredSizeWidget HomeBar() {
    return AppBar(
      title: RichText(
          text: TextSpan(
              text: 'AL ',
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: AppColor.cgreenColor,
                  fontWeight: FontWeight.bold),
              children: [
            TextSpan(
                text: 'SUFFAH',
                style: GoogleFonts.poppins(
                    fontSize: 23,
                    color: AppColor.geryColor,
                    fontWeight: FontWeight.bold))
          ])),
      centerTitle: true,
    );
  }
}
