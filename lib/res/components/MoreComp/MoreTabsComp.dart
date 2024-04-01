import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class MoreTabsComp extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const MoreTabsComp(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: context.mw * 0.03, vertical: context.mh * 0.02),
            height: context.mw * 0.18,
            width: context.mw * 0.18,
            decoration: BoxDecoration(
              color: AppColor.brownColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                icon,
                size: context.mh * 0.033,
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: context.mh * 0.017,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
