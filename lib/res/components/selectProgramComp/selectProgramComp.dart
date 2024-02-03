import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SelectProgramComp extends StatelessWidget {
  final String image;
  final String title;
  final String buttonTitle;
  final VoidCallback ontap;
  const SelectProgramComp(
      {super.key,
      required this.image,
      required this.title,
      required this.buttonTitle,
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
              opacity: 0.83,
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16),
        ),
        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: context.mh * 0.15,
              width: context.mw * 0.100,
              margin: EdgeInsets.symmetric(horizontal: context.mw * 0.02),
              decoration: BoxDecoration(
                color: AppColor.whiteColor.withOpacity(0.43),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  0.009.ph,
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
                  MaterialButton(
                    minWidth: context.mw * 0.50,
                    height: context.mh * 0.04,
                    color: AppColor.cgreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: ontap,
                    child: Text(
                      buttonTitle,
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.020,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                  0.01.ph,
                ],
              ),
            )),
      ],
    );
  }
}
