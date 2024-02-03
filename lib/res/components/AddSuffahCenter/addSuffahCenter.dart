// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddSuffahCenterComp extends StatelessWidget {
  String title;
  String? hint;
  IconData icon;
  int? maxlines;
  TextInputType? keyboardtype;
  TextEditingController controller;
  AddSuffahCenterComp(
      {super.key,
      this.hint,
      required this.title,
      required this.icon,
      required this.controller,
      this.keyboardtype,
      this.maxlines});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          radius: context.mh * 0.030,
          backgroundColor: AppColor.cgreenColor,
          child: Center(
              child: Icon(
            icon,
            size: context.mh * 0.025,
            color: AppColor.whiteColor,
          )),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: TextFormField(
          keyboardType: keyboardtype,
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.cgreenColor)),
            hintText: hint,
          ),
        ));
  }
}
