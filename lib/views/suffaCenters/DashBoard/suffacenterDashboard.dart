import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suffa_app/Service/Local%20Storage/sharedPrefs.dart';
import 'package:suffa_app/res/components/adminDashBoardTiles/adminDashBoardtiles.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SuffaCenterDashboard extends StatefulWidget {
  const SuffaCenterDashboard({super.key});

  @override
  State<SuffaCenterDashboard> createState() => _SuffaCenterDashboardState();
}

class _SuffaCenterDashboardState extends State<SuffaCenterDashboard> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
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
              0.01.ph,
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdminDashBoardtiles(
                      title: 'Neady People',
                      ontap: () {},
                      image: ImageAsset.neadyIcon.toString(),
                    ),
                    AdminDashBoardtiles(
                      title: 'Masjid Members',
                      ontap: () {
                        Get.toNamed(RoutesNames.suffacenterViewMembersScreen,
                            arguments: id);
                      },
                      image: ImageAsset.mosqueIcon,
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
                      title: 'Muntazim Profile',
                      ontap: () {
                        Get.toNamed(RoutesNames.suffacenterProfileScreen,
                            arguments: id);
                      },
                      image: ImageAsset.islamicIcon.toString(),
                    ),
                    AdminDashBoardtiles(
                      title: 'Log out',
                      ontap: () {},
                      image: ImageAsset.mosqueIcon,
                    ),
                  ],
                ),
              ),
            ]));
  }
}
