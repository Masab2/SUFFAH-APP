import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Donner/DonnorAuth/loginViewModel.dart';
import 'package:suffa_app/res/components/AppBar/AppBar.dart';
import 'package:suffa_app/res/components/DonnerProfile/CustomContainer.dart';
import 'package:suffa_app/res/components/DonnerProfile/DonnerProfileAccountSettings.dart';
import 'package:suffa_app/res/components/SuffahCenterProfile/suffaCenterProfile.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
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
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: context.mh * 0.40,
              width: context.mw,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColor.mehroonColor,
                    AppColor.brownColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: Apis.getLoginDonnerInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitChasingDots(
                            color: AppColor.mehroonColor,
                            duration: Duration(seconds: 5),
                            size: 40,
                          ),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No Data Found'));
                      } else {
                        return SingleChildScrollView(
                            child: CustomContainer(
                          title: snapshot.data!.docs.first['email'],
                          profile: snapshot.data!.docs.first['profilePic'],
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
            0.02.ph,
            SingleChildScrollView(
              child: Column(
                children: [
                  DonnerProfileView(
                    title1: l10n!.profileTitle,
                    subtitle: l10n.profileTitle,
                    icon1: IconlyBold.profile,
                  ),
                  0.02.ph,
                  DonnerProfileView(
                    title1: l10n.trackDonnationTitle,
                    subtitle: l10n.trackDonnationTitle,
                    icon1: IconlyBold.heart,
                  ),
                  0.02.ph,
                  DonnerProfileView(
                    title1: l10n.zakatCalculatorTitle,
                    subtitle: l10n.zakatCalculatorSubtitle,
                    icon1: Icons.calculate_outlined,
                  ),
                  0.02.ph,
                  DonnerProfileView(
                    title1: l10n.appSetting,
                    subtitle: l10n.editSettingSubtitle,
                    icon1: Icons.settings,
                  ),
                  0.02.ph,
                  DonnerProfileView(
                    title1: l10n.myDonnationTitle,
                    subtitle: l10n.myDonnationSubtitle,
                    icon1: IconlyBold.heart,
                  ),
                  0.02.ph,
                  DonnerProfileView(
                    title1: l10n.logOutTitle,
                    subtitle: l10n.logOutSubtitle,
                    icon1: IconlyBold.logout,
                  ),
                  0.02.ph,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
