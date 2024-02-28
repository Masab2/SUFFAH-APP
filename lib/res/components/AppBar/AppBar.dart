// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:flutter/material.dart';
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
      leading: leading,
      title: RichText(
          text: TextSpan(
              text: "${AppLocalizations.of(context)!.apptitlefirst} ",
              style: GoogleFonts.poppins(
                  fontSize: context.mh * 0.025,
                  color: AppColor.mehroonColor,
                  fontWeight: FontWeight.bold),
              children: [
            TextSpan(
                text: AppLocalizations.of(context)!.apptitlesecond,
                style: GoogleFonts.poppins(
                    fontSize: context.mh * 0.025,
                    color: AppColor.geryColor,
                    fontWeight: FontWeight.bold))
          ])),
      centerTitle: true,
      actions: [
        trailing,
        0.04.pw,
      ],
    );
  }

  static PreferredSizeWidget alSuffahPersonbar(
      BuildContext context, VoidCallback ontap, program) {
    return AppBar(
      title: Text(
        'AL-SUFFAH PERSON',
        style: GoogleFonts.poppins(
          fontSize: context.mh * 0.024,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        StreamBuilder(
          stream: Apis.getAllNeedyPeopleDonateCount(program),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              int itemCount = snapshot.data?.docs.length ?? 0;
              log(itemCount.toString());
              if (itemCount > 0) {
                return badges.Badge(
                    badgeContent: Text(itemCount.toString(),
                        style: GoogleFonts.poppins(
                          color: AppColor.whiteColor,
                        )),
                    child: InkWell(
                      onTap: ontap,
                      child: Icon(
                        IconlyBold.heart,
                        size: context.mh * 0.035,
                      ),
                    ));
              } else {
                return const Icon(
                  IconlyBold.heart,
                );
              }
            }
          },
        ),
        0.05.pw,
      ],
    );
  }
}
