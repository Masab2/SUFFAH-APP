// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class CustomizedFeild extends StatelessWidget {
  String? title;
  String? hint;
  Widget? sufixIcon;
  Widget? prefixIcon;
  bool? obscuretext = false;
  VoidCallback? onchanged;
  TextEditingController controller;
  int maxlines;
  CustomizedFeild(
      {super.key,
      this.title,
      this.onchanged,
      required this.controller,
      this.hint,
      this.sufixIcon,
      this.prefixIcon,
      this.maxlines = 1,
      this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title ?? "",
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              )
            ],
          ),
          0.01.ph,
          Container(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.geryColor.withOpacity(0.34)),
            child: TextFormField(
              controller: controller,
              obscureText: obscuretext ?? false,
              maxLines: maxlines,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  prefixIcon: prefixIcon,
                  suffixIcon: sufixIcon),
            ),
          ),
        ],
      ),
    );
  }
}