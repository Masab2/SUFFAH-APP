// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AddNeedyPeopleComp extends StatelessWidget {
  String title;
  String? hint;
  IconData icon;
  Widget? prefixIcon;
  int? maxlines;
  TextInputType? keyboardtype;
  TextEditingController controller;
  AddNeedyPeopleComp(
      {super.key,
      this.hint,
      required this.title,
      required this.icon,
      required this.controller,
      this.keyboardtype,
      this.maxlines,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: context.mh * 0.018, fontWeight: FontWeight.bold),
        ),
        subtitle: TextFormField(
          keyboardType: keyboardtype,
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColor.cgreenColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColor.cgreenColor)),
            hintText: hint,
          ),
        ));
  }
}
