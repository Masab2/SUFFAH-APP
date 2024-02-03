import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/adminDashBoardTiles/adminDashBoardtiles.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SuffaCenterDashboard extends StatefulWidget {
  const SuffaCenterDashboard({super.key});

  @override
  State<SuffaCenterDashboard> createState() => _SuffaCenterDashboardState();
}

class _SuffaCenterDashboardState extends State<SuffaCenterDashboard> {
  late String id;
  late String masjidname;
  late String masjidId;

  @override
  void initState() {
    super.initState();
    id = Get.arguments?[0] ?? "";
    masjidname = Get.arguments?[1] ?? "";
    masjidId = Get.arguments?[2] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(IconlyBold.arrow_left_circle)),
        title: Text(
          'SUFFAH CENTER',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Masjid Name : ',
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.020,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      masjidname,
                      style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.020,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            0.02.ph,
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdminDashBoardtiles(
                    title: 'Neady People',
                    ontap: () {
                      Get.toNamed(RoutesNames.selectProgramScreen, arguments: [
                        id,
                        masjidname,
                        masjidId,
                      ]);
                    },
                    icon: Icons.person,
                  ),
                  AdminDashBoardtiles(
                    title: "Masjid Member's",
                    ontap: () {
                      Get.toNamed(RoutesNames.suffacenterViewMembersScreen,
                          arguments: id);
                    },
                    icon: Icons.mosque,
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
                    title: 'Masjid Profile',
                    ontap: () {
                      Get.toNamed(RoutesNames.suffacenterProfileScreen,
                          arguments: id);
                    },
                    icon: Icons.mosque_rounded,
                  ),
                  AdminDashBoardtiles(
                    title: 'Affiliated Program',
                    ontap: () {
                      Get.toNamed(RoutesNames.affiliatedProgramScreen,
                          arguments: id);
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
                    title: 'Add Stores Account',
                    ontap: () {},
                    icon: IconlyBold.bag,
                  ),
                  AdminDashBoardtiles(
                    title: 'List Registered Stores',
                    ontap: () {},
                    icon: Icons.verified,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
