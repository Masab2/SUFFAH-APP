import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/res/components/MoreComp/MoreTabsComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class MoreScreenView extends StatefulWidget {
  const MoreScreenView({super.key});

  @override
  State<MoreScreenView> createState() => _MoreScreenViewState();
}

class _MoreScreenViewState extends State<MoreScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Portals',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.ph,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.mw * 0.016,
              ),
              child: Wrap(
                runAlignment: WrapAlignment.center,
                children: [
                  MoreTabsComp(
                    title: 'Videos',
                    icon: IconlyBold.video,
                    onTap: () {},
                  ),
                  MoreTabsComp(
                    title: 'Accounts',
                    icon: IconlyBold.profile,
                    onTap: () {
                      // Get.toNamed(RoutesNames.editProfileScreen);
                    },
                  ),
                  MoreTabsComp(
                    title: 'Guide',
                    icon: Icons.notes,
                    onTap: () {},
                  ),
                  MoreTabsComp(
                    title: 'Services',
                    icon: Icons.admin_panel_settings,
                    onTap: () {
                      Get.toNamed(RoutesNames.choiceScreen);
                    },
                  ),
                  MoreTabsComp(
                    title: 'FAQs',
                    icon: Icons.question_answer,
                    onTap: () {},
                  ),
                  MoreTabsComp(
                    title: 'Services',
                    icon: IconlyBold.video,
                    onTap: () {},
                  ),
                  MoreTabsComp(
                    title: 'Services',
                    icon: IconlyBold.video,
                    onTap: () {},
                  ),
                  MoreTabsComp(
                    title: 'Services',
                    icon: IconlyBold.video,
                    onTap: () {},
                  ),
                  MoreTabsComp(
                    title: 'Services',
                    icon: IconlyBold.video,
                    onTap: () {},
                  ),
                  MoreTabsComp(
                    title: 'Services',
                    icon: IconlyBold.video,
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
