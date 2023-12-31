import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/res/components/adminDashBoardTiles/adminDashBoardtiles.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
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
            'Admin Panel',
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
                      title: 'SUFFAH Center',
                      ontap: () {
                        Get.toNamed(RoutesNames.viewSuffahCenterScreen);
                      },
                      image: ImageAsset.mosqueIcon.toString(),
                    ),
                    AdminDashBoardtiles(
                      title: 'SUFFAH Store',
                      ontap: () {},
                      image: ImageAsset.storeIcon,
                    ),
                  ],
                ),
              ),
            ]));
  }
}
