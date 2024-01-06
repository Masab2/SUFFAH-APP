import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/DonnorAuth/loginViewModel.dart';
import 'package:suffa_app/res/components/DonnerProfile/DonnerProfileAccountSettings.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

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
                      return DonnerProfileView(
                          title1: 'UID',
                          subtitle: data['uid'],
                          mainheading: 'Personal Info',
                          title2: 'Email',
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
              title1: 'Settings',
              subtitle: 'edit settings',
              mainheading: 'Account Settings',
              title2: 'My Donnation',
              subtitle2: 'View Donnation',
              icon1: IconlyBold.setting,
              icon2: IconlyBold.heart,
              title3: 'LogOut',
              subtitle3: 'Logout your Account',
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
