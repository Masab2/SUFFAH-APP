// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:csc_picker/csc_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBar {
  static PreferredSizeWidget HomeBar(
    BuildContext context,
    Widget leading,
    Widget trailing,
  ) {
    return AppBar(
      backgroundColor: AppColor.brownColor,
      leadingWidth: context.mw * 0.25,
      leading: leading,
      title: Text(
        AppLocalizations.of(context)!.apptitlefirst,
        style: GoogleFonts.poppins(
          fontSize: context.mh * 0.023,
          color: AppColor.whiteColor,
        ),
      ),
      centerTitle: true,
      actions: [
        Column(
          children: [
            trailing,
          ],
        ),
      ],
    );
  }
}
