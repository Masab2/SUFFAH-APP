import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Donner/DonnorAuth/loginViewModel.dart';
import 'package:suffa_app/res/components/DonnerProfile/DonnerProfileAccountSettings.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DonnerProfile extends StatefulWidget {
  const DonnerProfile({super.key});

  @override
  State<DonnerProfile> createState() => _DonnerProfileState();
}

class _DonnerProfileState extends State<DonnerProfile> {
  final donnerProfile = Get.put(LoginViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SUFFAH APP',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            0.02.ph,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ClipRRect(
                    child: CircleAvatar(
                        radius: context.mh * 0.100,
                        backgroundColor: AppColor.cgreenColor,
                        child: Image(
                            image: AssetImage(ImageAsset.applogobackremove))),
                  ),
                ),
                0.02.ph,
                StreamBuilder(
                  stream: Apis.getLoginDonnerInfo(),
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
                      return const Text('No Data Found');
                    } else {
                      var data = snapshot.data!.docs.first;
                      log(data['uid']);
                      return DonnerProfileView(
                          title1: AppLocalizations.of(context)!.uidTitle,
                          subtitle: data['uid'],
                          mainheading: AppLocalizations.of(context)!
                              .donnerProfileHeadingPersonalinfo,
                          title2: AppLocalizations.of(context)!.emailTitle,
                          subtitle2: data['email'],
                          icon1: IconlyBold.info_circle,
                          icon2: IconlyBold.message);
                    }
                  },
                ),
              ],
            ),
            DonnerProfileAccountSettings(
              onSettingsTap: () {
                Get.toNamed(RoutesNames.settingsScreen);
              },
              title1: AppLocalizations.of(context)!.appSetting,
              subtitle: AppLocalizations.of(context)!.editSettingSubtitle,
              mainheading: AppLocalizations.of(context)!
                  .donnerProfileHeadingAccountSetting,
              title2: AppLocalizations.of(context)!.myDonnationTitle,
              subtitle2: AppLocalizations.of(context)!.myDonnationSubtitle,
              icon1: IconlyBold.setting,
              icon2: IconlyBold.heart,
              title3: AppLocalizations.of(context)!.logOutTitle,
              subtitle3: AppLocalizations.of(context)!.logOutSubtitle,
              onLogout: () {
                donnerProfile.logOutAccount();
              },
              icon3: IconlyBold.logout,
            )
          ],
        ),
      ),
    );
  }
}
