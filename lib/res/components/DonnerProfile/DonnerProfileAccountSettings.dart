import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DonnerProfileView extends StatelessWidget {
  final String title1, subtitle;
  final IconData icon1;
  const DonnerProfileView({
    super.key,
    required this.title1,
    required this.subtitle,
    required this.icon1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: context.mh * 0.02),
          height: context.mh * 0.10,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey
                    .withOpacity(0.5), // You can set the shadow color here
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: context.mw * 0.04,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColor.mehroonColor,
                      AppColor.brownColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              0.02.pw,
              SizedBox(
                width: context.mw * 0.12,
                child: Icon(
                  icon1,
                  size: context.mh * 0.035,
                ),
              ),
              0.03.pw,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title1,
                        style: GoogleFonts.poppins(
                          fontSize: context.mh * 0.020,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.017,
                            fontWeight: FontWeight.w500,
                            color: AppColor.geryColor),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
