import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/SuffahCenterProfile/suffaCenterProfile.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../../../res/components/adminDashBoardTiles/adminTilesUperheading/upperHeading.dart';

class SuffaCenterProfile extends StatefulWidget {
  const SuffaCenterProfile({super.key});

  @override
  State<SuffaCenterProfile> createState() => _SuffaCenterProfileState();
}

class _SuffaCenterProfileState extends State<SuffaCenterProfile> {
  late String id;
  late String masjidname;
  @override
  void initState() {
    id = Get.arguments[0];
    masjidname = Get.arguments[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Al-Suffah Center Profile',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.023,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          UpperHeading(
            icon: Icons.mosque,
            title: masjidname,
          ),
          0.03.ph,
          StreamBuilder(
            stream: Apis.getSuffaCenterData(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitChasingDots(
                    color: AppColor.mehroonColor,
                    duration: Duration(seconds: 5),
                    size: 40,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Text('No Data Found');
              } else {
                return Expanded(
                  // Wrap the ListView.builder with Expanded
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      List<dynamic> programs = data['Programs'];
                      return Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.mw * 0.05),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Program Registered',
                                    style: GoogleFonts.poppins(
                                      fontSize: context.mh * 0.020,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: context.mh * 0.20,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: programs.length,
                                  itemBuilder: (context, programindex) {
                                    return UserInfoListTile(
                                        icon: Icons.system_security_update,
                                        title: programs[programindex],
                                        subtitle: 'Registered');
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.mw * 0.05),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Masjid Information',
                                style: GoogleFonts.poppins(
                                  fontSize: context.mh * 0.020,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          UserInfoListTile(
                            icon: IconlyBold.user_2,
                            title: 'Masjid Name',
                            subtitle: data['masjidname'],
                          ),
                          0.01.ph,
                          UserInfoListTile(
                            icon: IconlyBold.message,
                            title: 'Masjid Muntazim Email',
                            subtitle: data['email'],
                          ),
                          0.01.ph,
                          UserInfoListTile(
                            icon: IconlyBold.location,
                            title: 'Country',
                            subtitle: data['country'],
                          ),
                          0.01.ph,
                          UserInfoListTile(
                            icon: Icons.location_city,
                            title: 'City',
                            subtitle: data['city'],
                          ),
                          0.01.ph,
                          UserInfoListTile(
                            icon: IconlyBold.call,
                            title: 'Phone No',
                            subtitle: data['phoneno'],
                          ),
                          0.01.ph,
                          0.01.ph,
                          UserInfoListTile(
                            icon: IconlyBold.location,
                            title: 'Masjid Address',
                            subtitle: data['address'],
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
