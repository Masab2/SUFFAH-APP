import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DonnationChoice extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback ontap;
  const DonnationChoice(
      {super.key,
      required this.image,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.mh * 0.25,
          width: context.mw * 0.90,
          margin: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
          decoration: BoxDecoration(
            // color: AppColor.cgreenColor,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              opacity: 0.63,
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16),
        ),
        Positioned(
          top: context.mh * 0.15,
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            height: context.mh * 0.06,
            width: context.mw * 0.90,
            margin: EdgeInsets.symmetric(horizontal: context.mw * 0.10),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColor.cgreenColor.withOpacity(0.33),
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
              children: [
                0.016.ph,
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
                0.007.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: ontap,
                      child: Text(
                        'Donnate Now',
                        style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.020,
                            fontWeight: FontWeight.bold,
                            color: AppColor.cgreenColor),
                      ),
                    ),
                    0.02.pw,
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
