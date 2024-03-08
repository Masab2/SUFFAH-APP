// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:csc_picker/csc_picker.dart';
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
      BuildContext context, ValueChanged<dynamic>? onChanged) {
    return AppBar(
      backgroundColor: AppColor.brownColor,
      leadingWidth: context.mw * 0.25,
      // leading: InkWell(
      //   onTap: () {

      //   },
      //   child: Row(
      //     children: [
      //       0.02.pw,
      //       Icon(
      //         IconlyBold.location,
      //         size: context.mh * 0.020,
      //       ),
      //       Text(
      //         'Pakistan',
      //         style: GoogleFonts.poppins(
      //           color: AppColor.whiteColor,
      //           fontSize: context.mh * 0.013,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      leading: Row(
        children: [
          0.02.pw,
          Expanded(
            child: CSCPicker(
              defaultCountry: CscCountry.Pakistan,
              dropdownDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColor.brownColor,
              ),
              layout: Layout.horizontal,
              showCities: false,
              showStates: false,
              flagState: CountryFlag.ENABLE,
              currentCountry: 'Pakistan',
              onCountryChanged: onChanged,
            ),
          ),
        ],
      ),
      title: Text(
        AppLocalizations.of(context)!.apptitlefirst,
        style: GoogleFonts.poppins(
          fontSize: context.mh * 0.023,
          color: AppColor.whiteColor,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              0.01.ph,
              Row(
                children: [
                  0.02.pw,
                  Icon(
                    Icons.language,
                    size: context.mh * 0.020,
                  ),
                  Text(
                    'English',
                    style: GoogleFonts.poppins(
                        color: AppColor.whiteColor,
                        fontSize: context.mh * 0.013),
                  ),
                ],
              ),
              0.003.ph,
              Row(
                children: [
                  0.02.pw,
                  Icon(
                    Icons.monetization_on_outlined,
                    size: context.mh * 0.020,
                  ),
                  Text(
                    'PKR',
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: context.mh * 0.013,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
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
