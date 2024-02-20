import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/res/components/SuffahCenterProfile/suffaCenterProfile.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DonnerProfileAccountSettings extends StatelessWidget {
  final String title1,
      title2,
      subtitle,
      subtitle2,
      mainheading,
      title3,
      subtitle3;
  final IconData icon1, icon2, icon3;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onLogout;
  const DonnerProfileAccountSettings(
      {super.key,
      required this.title1,
      required this.subtitle,
      required this.mainheading,
      required this.title2,
      required this.subtitle2,
      required this.icon1,
      required this.icon2,
      this.onSettingsTap,
      this.onLogout,
      required this.title3,
      required this.subtitle3,
      required this.icon3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        0.02.ph,
        Container(
          height: context.mh * 0.34,
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.04),
          margin: EdgeInsets.symmetric(
              horizontal: context.mw * 0.04, vertical: context.mw * 0.01),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(20),
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
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                0.02.ph,
                SettingInfoListTile(
                    ontap: onSettingsTap,
                    icon: icon1,
                    title: title1,
                    subtitle: subtitle,
                    traling: const Icon(Icons.arrow_forward_ios)),
                const Divider(
                  endIndent: 20,
                  indent: 20,
                ),
                SettingInfoListTile(
                    icon: icon2,
                    title: title2,
                    subtitle: subtitle2,
                    traling: const Icon(Icons.arrow_forward_ios)),
                const Divider(
                  endIndent: 20,
                  indent: 20,
                ),
                SettingInfoListTile(
                    ontap: onLogout,
                    icon: icon3,
                    title: title3,
                    subtitle: subtitle3,
                    traling: const Icon(Icons.logout)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DonnerProfileView extends StatelessWidget {
  final String title1,
      title2,
      title3,
      subtitle,
      subtitle2,
      subtitle3,
      mainheading;
  final IconData icon1, icon2, icon3;
  const DonnerProfileView(
      {super.key,
      required this.title1,
      required this.subtitle,
      required this.mainheading,
      required this.title2,
      required this.subtitle2,
      required this.icon1,
      required this.icon2,
      required this.title3,
      required this.subtitle3,
      required this.icon3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        0.01.ph,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mw * 0.05),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              mainheading,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Card(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.symmetric(horizontal: context.mw * 0.03),
          child: Column(
            children: [
              0.02.ph,
              UserInfoListTile(icon: icon1, title: title1, subtitle: subtitle),
              const Divider(
                endIndent: 20,
                indent: 20,
              ),
              UserInfoListTile(icon: icon2, title: title2, subtitle: subtitle2),
              const Divider(
                endIndent: 20,
                indent: 20,
              ),
              UserInfoListTile(icon: icon2, title: title2, subtitle: subtitle2),
            ],
          ),
        ),
      ],
    );
  }
}
