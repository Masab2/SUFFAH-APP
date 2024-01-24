// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class PickImageWidget extends StatelessWidget {
  VoidCallback ontap;
   final String? title;
  PickImageWidget({super.key, required this.ontap, this.title = 'Choose Image'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: context.mh * 0.20,
          width: context.mw * 0.60,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.cgreenColor),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                IconlyBold.camera,
                color: AppColor.cgreenColor,
                size: 36,
              ),
              0.02.ph,
              Text(
                title!,
                style: GoogleFonts.roboto(
                    fontSize: 18, color: AppColor.cgreenColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
