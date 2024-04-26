import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/DonnerProfile/CustomContainer.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Column(
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
                      return Center(child: Text(l10n!.noDataFound));
                    } else {
                      return Column(
                        children: [
                          CustomContainer(
                            title: snapshot.data?.docs.first['email'],
                            profile: snapshot.data?.docs.first['profilePic'],
                          ),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
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
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text(l10n!.noDataFound));
              } else {
                return Column(
                  children: [
                    0.03.ph,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mw * 0.03,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'UserID',
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.018,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: context.mh * 0.01,
                          left: context.mw * 0.03,
                          right: context.mw * 0.03),
                      height: context.mh * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColor.mehroonColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          snapshot.data?.docs.first['uid'],
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.017,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    0.02.ph,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mw * 0.03,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          l10n!.emailHint,
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.018,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: context.mh * 0.01,
                          left: context.mw * 0.03,
                          right: context.mw * 0.03),
                      height: context.mh * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColor.mehroonColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          snapshot.data?.docs.first['email'],
                          style: GoogleFonts.poppins(
                            fontSize: context.mh * 0.017,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}
