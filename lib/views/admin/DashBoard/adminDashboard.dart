import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/res/components/adminDashBoardTiles/adminDashBoardtiles.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../../../res/components/adminDashBoardTiles/adminTilesUperheading/upperHeading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            l10n!.adminPanelTitle,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              const UpperHeading(
                icon: Icons.admin_panel_settings,
                title: 'Masab Haider',
              ),
              0.01.ph,
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdminDashBoardtiles(
                      title: l10n.shuffahCenterTitle,
                      ontap: () {
                        Get.toNamed(RoutesNames.viewSuffahCenterScreen);
                      },
                      icon: Icons.mosque,
                    ),
                    AdminDashBoardtiles(
                      title: l10n.donnationTrackTitle,
                      ontap: () {
                        Get.toNamed(RoutesNames.adminDonnationTrackScreen);
                      },
                      icon: IconlyBold.heart,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdminDashBoardtiles(
                      title: l10n.memberRequestTitle,
                      ontap: () {
                        Get.toNamed(RoutesNames.memberRequestScreen);
                      },
                      icon: Icons.remove_from_queue,
                    ),
                    AdminDashBoardtiles(
                      title: l10n.requestedProgramTitle,
                      ontap: () {
                        Get.toNamed(RoutesNames.requestProgramScreen);
                      },
                      icon: Icons.control_camera_outlined,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdminDashBoardtiles(
                      title: l10n.affiliatedProgramTitle,
                      ontap: () {
                        Get.toNamed(
                          RoutesNames.displayaffiliatedProgramScreenforAdmin,
                        );
                      },
                      icon: Icons.ac_unit_outlined,
                    ),
                    // AdminDashBoardtiles(
                    //   title: 'Requested Program',
                    //   ontap: () {
                    //     Get.toNamed(RoutesNames.requestProgramScreen);
                    //   },
                    //   icon: Icons.control_camera_outlined,
                    // ),
                  ],
                ),
              ),
            ]));
  }
}
