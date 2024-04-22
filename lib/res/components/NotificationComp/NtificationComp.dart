import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/utils/Utils.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class NotificationComp extends StatelessWidget {
  final String title, body, time;
  const NotificationComp(
      {super.key, required this.title, required this.body, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.mh * 0.16,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 3), // Offset from the top-left corner
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: context.mw * 0.02,
        vertical: context.mw * 0.03,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.mw * 0.02,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.mehroonColor,
            radius: context.mh * 0.040,
            child: Icon(
              IconlyLight.notification,
              size: context.mh * 0.040,
              color: AppColor.whiteColor,
            ),
          ),
          0.05.pw,
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    0.02.ph,
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: AppColor.mehroonColor,
                      ),
                    ),
                    Text(
                      body,
                      style: GoogleFonts.poppins(
                        color: AppColor.blackColor,
                        fontSize: context.mh * 0.015,
                      ),
                    ),
                    0.01.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          Utils.dateFormatedForNotifs(time),
                          style: GoogleFonts.poppins(
                            color: AppColor.mehroonColor,
                            fontSize: context.mh * 0.015,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        0.05.pw,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
