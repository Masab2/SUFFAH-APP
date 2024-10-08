import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/ChoiceComp/ChoiceComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({super.key});

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n!.adminProtalsTitle,
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.mehroonColor,
                AppColor.brownColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          0.02.ph,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChoiceComp(
                title: l10n.portalOneAdmin,
                ontap: () {
                  Get.toNamed(RoutesNames.loginDashBoardScreen);
                },
                image: ImageAsset.shopIcon,
              ),
              0.03.ph,
              ChoiceComp(
                title: l10n.portalTwoAdmin,
                ontap: () {
                  Get.toNamed(RoutesNames.suffahloginDashBoardScreen);
                },
                image: ImageAsset.shopIcon,
              ),
              0.03.ph,
              ChoiceComp(
                title: l10n.portalThreeAdmin,
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
