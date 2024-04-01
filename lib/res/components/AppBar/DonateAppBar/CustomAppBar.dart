import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(200);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          0.10.ph,
          Image(
            image: AssetImage(ImageAsset.applogo),
            height: context.mw * 0.30,
            width: context.mw * 0.30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                """ “Give Charity without the delay for it stands in the  """,
                style: GoogleFonts.poppins(
                  color: AppColor.mehroonColor,
                  fontSize: context.mh * 0.014,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                """ way of calamity.” """,
                style: GoogleFonts.poppins(
                  color: AppColor.mehroonColor,
                  fontSize: context.mh * 0.014,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}