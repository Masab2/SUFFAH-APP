import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class ReuseAblebtn extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const ReuseAblebtn({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: context.mw * 0.80,
      height: context.mh * 0.05,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      color: AppColor.cgreenColor,
      child: Text(
        title,
        style: GoogleFonts.poppins(
            color: AppColor.whiteColor, fontSize: context.mh * 0.017),
      ),
    );
  }
}
