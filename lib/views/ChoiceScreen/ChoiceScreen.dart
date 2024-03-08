import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/ChoiceComp/ChoiceComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({super.key});

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WELCOME TO AL-SUFFAH',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: context.mh * 0.023,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChoiceComp(
                title: 'Al-Suffah Admin',
                ontap: () {
                  Get.toNamed(RoutesNames.loginDashBoardScreen);
                },
                image: ImageAsset.shopIcon,
              ),
              0.03.ph,
              ChoiceComp(
                title: 'Al-Suffah Center',
                ontap: () {
                  Get.toNamed(RoutesNames.suffahloginDashBoardScreen);
                },
                image: ImageAsset.shopIcon,
              ),
              0.03.ph,
              ChoiceComp(
                title: 'Al-Suffah Shop',
                ontap: () {
                  Get.toNamed(RoutesNames.suffahStoreloginScreen);
                },
                image: ImageAsset.shopIcon,
              ),
              0.03.ph,
            ],
          )
        ],
      ),
    );
  }
}
