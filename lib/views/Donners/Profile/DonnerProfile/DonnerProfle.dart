import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            0.01.ph,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      return CustomContainer(
                          title: AppLocalizations.of(context)!.emailTitle,
                          subtitle: data['email']);
                    }
                  },
                ),
                Container(
                  height: context.mh * 0.33,
                  padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
                  margin: EdgeInsets.symmetric(
                      horizontal: context.mw * 0.04,
                      vertical: context.mw * 0.01),
                  decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.43),
                          blurRadius: 2.0, // soften the shadow
                          spreadRadius: 1.0, //extend the shadow
                          offset: const Offset(
                            4.0, // Move to right 5  horizontally
                            4.0, // Move to bottom 5 Vertically
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          0.01.ph,
                          SettingInfoListTile(
                              icon: IconlyBold.profile,
                              title: AppLocalizations.of(context)!.profileTitle,
                              subtitle: 'Vist Profile',
                              traling: const Icon(Icons.arrow_forward_ios)),
                          const Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          SettingInfoListTile(
                              icon: IconlyBold.heart,
                              title: AppLocalizations.of(context)!
                                  .trackDonnationTitle,
                              subtitle: 'Status',
                              traling: Icon(Icons.arrow_forward_ios)),
                          const Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          const SettingInfoListTile(
                              icon: CupertinoIcons.money_dollar_circle_fill,
                              title: 'Zakat Calulator',
                              subtitle: 'Calculatate your Zakat',
                              traling: Icon(Icons.arrow_forward_ios)),
                        ],
                      ),
                    ),
                  ),
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
