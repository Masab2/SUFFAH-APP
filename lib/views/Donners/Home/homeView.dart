import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/AppBar/AppBar.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/DonnationChoiceComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
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
          const Icon(
            IconlyLight.search,
            color: AppColor.cgreenColor,
          ),
          const Icon(
            IconlyLight.notification,
            color: AppColor.cgreenColor,
          )),
      body: Column(
        children: [
          0.05.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.ourDonnationTitle,
                  style: GoogleFonts.poppins(
                      fontSize: context.mh * 0.020,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          0.02.ph,
          StreamBuilder(
            stream: Apis.getAllPrograms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitChasingDots(
                    color: AppColor.cgreenColor,
                    duration: Duration(seconds: 5),
                    size: 40,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Text('No Data');
              } else {
                return Expanded(
                    child: ListView.builder(
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
                        Get.toNamed(RoutesNames.selectMasjidScreen, arguments: [
                          data['programTitle'],
                          data['Price'],
                        ]);
                      },
                      program: data['programTitle'],
                    );
                  },
                ));
              }
            },
          ),
          0.04.ph,
        ],
      ),
    );
  }
}
