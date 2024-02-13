import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/res/components/ChoiceComp/ChoiceComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
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
          'Adminstration',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Center(
            child: Image(
                height: context.mh * 0.35,
                image: AssetImage(ImageAsset.verifyemail)),
          ),
          0.08.ph,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChoiceComp(
                title: 'Admin Login',
                ontap: () {
                  Get.toNamed(RoutesNames.loginDashBoardScreen);
                },
                color: AppColor.cgreenColor,
              ),
              0.03.ph,
              ChoiceComp(
                title: 'SUFFFAH CENTER LOGIN',
                ontap: () {
                  Get.toNamed(RoutesNames.suffahloginDashBoardScreen);
                },
                color: Colors.teal,
              ),
              0.03.ph,
              ChoiceComp(
                title: 'SUFFFAH SHOP LOGIN',
                ontap: () {
                  Get.toNamed(RoutesNames.suffahStoreloginScreen);
                },
                color: AppColor.cgreenColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
