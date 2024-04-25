import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/adminDashBoardTiles/adminDashBoardtiles.dart';
import 'package:suffa_app/res/components/adminDashBoardTiles/adminTilesUperheading/upperHeading.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuffaCenterDashboard extends StatefulWidget {
  const SuffaCenterDashboard({super.key});

  @override
  State<SuffaCenterDashboard> createState() => _SuffaCenterDashboardState();
}

class _SuffaCenterDashboardState extends State<SuffaCenterDashboard> {
  late String id;
  late String masjidname;
  late String masjidId;
  late String muntazimEmail;
  late String country;
  late String state;
  late String city;
  late String address;

  @override
  void initState() {
    super.initState();
    id = Get.arguments?[0] ?? "";
    masjidname = Get.arguments?[1] ?? "";
    masjidId = Get.arguments?[2] ?? "";
    muntazimEmail = Get.arguments?[3] ?? "";
    country = Get.arguments?[4] ?? "";
    state = Get.arguments?[5] ?? "";
    city = Get.arguments?[6] ?? "";
    address = Get.arguments?[7] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n!.portalTwoAdmin,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            UpperHeading(icon: Icons.mosque, title: masjidname),
            0.01.ph,
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdminDashBoardtiles(
                    title: l10n.needyPeopleTitle,
                    ontap: () {
                      Get.toNamed(
                        RoutesNames.selectProgramScreen,
                        arguments: [
                          id,
                          masjidname,
                          masjidId,
                          muntazimEmail,
                          country,
                          state,
                          city,
                          address,
                        ],
                      );
                    },
                    icon: Icons.person,
                  ),
                  AdminDashBoardtiles(
                    title: 'Recived Donnations',
                    ontap: () {
                      Get.toNamed(
                        RoutesNames.recivedDonnationScreen,
                        arguments: [
                          id,
                          masjidId,
                        ],
                      );
                    },
                    icon: IconlyBold.heart,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdminDashBoardtiles(
                    title: l10n.masjidProfileTitle,
                    ontap: () {
                      Get.toNamed(RoutesNames.suffacenterProfileScreen,
                          arguments: [
                            id,
                            masjidname,
                          ]);
                    },
                    icon: Icons.mosque_rounded,
                  ),
                  AdminDashBoardtiles(
                    title: l10n.shuffahCenterProgramTitle,
                    ontap: () {
                      Get.toNamed(RoutesNames.centerProgramDisplayScreen,
                          arguments: [
                            id,
                            masjidname,
                            masjidId,
                            muntazimEmail,
                            address,
                            country,
                            state,
                            city,
                          ]);
                    },
                    icon: Icons.dashboard,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdminDashBoardtiles(
                    title: l10n.addStoresAccountTitle,
                    ontap: () {
                      Get.toNamed(
                        RoutesNames.selectProgramForShopsAddScreen,
                        arguments: [
                          id,
                          masjidId,
                          masjidname,
                        ],
                      );
                    },
                    icon: IconlyBold.bag,
                  ),
                  AdminDashBoardtiles(
                    title: l10n.shuffahStoreTitle,
                    ontap: () {
                      Get.toNamed(RoutesNames.displayShopScreen, arguments: [
                        masjidId,
                      ]);
                    },
                    icon: Icons.verified,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdminDashBoardtiles(
                    title: l10n.masjidMemberTitle,
                    ontap: () {
                      Get.toNamed(RoutesNames.suffacenterViewMembersScreen,
                          arguments: [
                            id,
                            masjidId,
                          ]);
                    },
                    icon: Icons.mosque,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
