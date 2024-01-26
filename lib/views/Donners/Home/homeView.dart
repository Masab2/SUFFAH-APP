import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/enum/AffiliatedProgramEnum.dart';
import 'package:suffa_app/res/components/AppBar/AppBar.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/DonnationChoiceComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.HomeBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.05.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
              child: Row(
                children: [
                  Text(
                    'Our Donnation Choices',
                    style: GoogleFonts.poppins(
                        fontSize: context.mh * 0.020,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            0.02.ph,
            DonnationChoice(
              image: ImageAsset.hungryimg,
              title: 'One Time Meal',
              ontap: () {
                Get.toNamed(RoutesNames.selectMasjidScreen,
                    arguments: ProgramType.ONETIMEMEAL);
              },
            ),
            0.04.ph,
            DonnationChoice(
              image: ImageAsset.rashanimg,
              title: 'Rashan Program',
              ontap: () {
                Get.toNamed(RoutesNames.selectMasjidScreen,
                    arguments: ProgramType.RASHANPROGRAM);
              },
            )
          ],
        ),
      ),
    );
  }
}
