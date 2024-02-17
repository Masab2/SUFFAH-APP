import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class ChoiceComp extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final String image;
  const ChoiceComp(
      {super.key,
      required this.title,
      required this.ontap,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
          height: context.mh * 0.20,
          width: context.mw / 1.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Colors.transparent,
                AppColor.cgreenColor
              ], // Example gradient colors
              begin: Alignment.topLeft,
              end: Alignment.center,
            ),
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
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    0.04.pw,
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.022,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Image(
                          height: context.mw * 0.2,
                          width: context.mw * 0.2,
                          image: AssetImage(
                            image,
                          )),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
