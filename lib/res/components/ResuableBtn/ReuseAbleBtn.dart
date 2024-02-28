import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class ReuseAblebtn extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  const ReuseAblebtn({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = AppColor.mehroonColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: context.mw * 0.80,
      height: context.mh * 0.06,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: onPressed,
      color: color,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: AppColor.whiteColor,
          fontSize: context.mh * 0.017,
        ),
      ),
    );
  }
}

class GoogleSignbtn extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  const GoogleSignbtn({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = AppColor.mehroonColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: context.mw * 0.80,
      height: context.mh * 0.06,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: onPressed,
      color: color,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage(ImageAsset.googleicon),
              height: context.mw * 0.1,
              width: context.mw * 0.1,
            ),
            0.04.pw,
            Text(
              title,
              style: GoogleFonts.poppins(
                color: AppColor.whiteColor,
                fontSize: context.mh * 0.017,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
