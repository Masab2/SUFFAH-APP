import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/AppBar/AppBar.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/DonnationChoiceComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.HomeBar(
        context,
        (value) {},
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            0.02.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Donation Choices',
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mehroonColor,
                    ),
                  ),
                  Text(
                    'See All',
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mehroonColor,
                    ),
                  ),
                ],
              ),
            ),
            0.01.ph,
            StreamBuilder(
              stream: Apis.getAllPrograms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(
                      color: AppColor.mehroonColor,
                      duration: Duration(seconds: 5),
                      size: 40,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No Data');
                } else {
                  return SizedBox(
                    height: context.mh * 0.36,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return DonnationChoice(
                          image: data['image'],
                          title: data['programTitle'],
                          ontap: () {
                            Get.toNamed(RoutesNames.selectMasjidScreen,
                                arguments: [
                                  data['programTitle'],
                                  data['Price'],
                                ]);
                          },
                          program: data['programTitle'],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            0.01.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Masjid Donnation Choices',
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mehroonColor,
                    ),
                  ),
                  Text(
                    'See All',
                    style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.017,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mehroonColor,
                    ),
                  ),
                ],
              ),
            ),
            0.01.ph,
            StreamBuilder(
              stream: Apis.getAllSuffahCenterDefinePrograms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(
                      color: AppColor.mehroonColor,
                      duration: Duration(seconds: 5),
                      size: 40,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No Data');
                } else {
                  return SizedBox(
                    height: context.mh * 0.3,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return DonnationChoiceMasjidComp(
                          image: data['image'],
                          title: data['programTitle'],
                          ontap: () {
                            Get.toNamed(
                              RoutesNames.selectMasjidScreen,
                              arguments: [
                                data['programTitle'],
                                data['Price'],
                              ],
                            );
                          },
                          program: data['programTitle'],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
