// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AdminDashBoardtiles extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback ontap;

  const AdminDashBoardtiles(
      {super.key,
      required this.title,
      required this.ontap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height: context.mh * 0.20,
          width: context.mw / 2.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[300],
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
              Icon(
                icon,
                size: context.mh * 0.0400,
              ),
              0.02.ph,
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.013,
                    fontWeight: FontWeight.bold,
                    color: AppColor.geryColor),
              )
            ],
          )),
    );
  }
}
