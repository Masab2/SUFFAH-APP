// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class BottomSheetContainer extends StatelessWidget {
  VoidCallback ongallery;
  VoidCallback oncamera;
  BottomSheetContainer(
      {super.key, required this.ongallery, required this.oncamera});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          0.04.ph,
          Text(
            'Choose Image',
            style:
                GoogleFonts.roboto(fontSize: 18, color: AppColor.cgreenColor),
          ),
          0.03.ph,
          ListTile(
            title: const Text('Pick Image From Gallery'),
            leading: const Icon(
              Icons.photo,
              color: AppColor.cgreenColor,
            ),
            onTap: ongallery,
          ),
          ListTile(
            title: const Text('Pick Image From Camera'),
            leading: const Icon(
              IconlyBold.camera,
              color: AppColor.cgreenColor,
            ),
            onTap: oncamera,
          ),
          0.03.ph,
        ],
      ),
    );
  }
}
