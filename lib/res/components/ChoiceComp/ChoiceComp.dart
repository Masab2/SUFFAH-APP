import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class ChoiceComp extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final Color color;
  const ChoiceComp(
      {super.key,
      required this.title,
      required this.ontap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
          height: context.mh * 0.10,
          width: context.mw / 1.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            boxShadow: const [
              BoxShadow(
                color: AppColor.whiteColor,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 0.01.ph,
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.017,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteColor),
              )
            ],
          )),
    );
  }
}
