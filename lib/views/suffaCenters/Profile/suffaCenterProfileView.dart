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

class SuffaCenterProfile extends StatefulWidget {
  const SuffaCenterProfile({super.key});

  @override
  State<SuffaCenterProfile> createState() => _SuffaCenterProfileState();
}

class _SuffaCenterProfileState extends State<SuffaCenterProfile> {
  @override
  Widget build(BuildContext context) {
    final id = Get.arguments;
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
          StreamBuilder(
            stream: Apis.getSuffaCenterData(id),
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
                return Expanded(
                  // Wrap the ListView.builder with Expanded
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Column(
                        children: [
                          UserInfoListTile(
                            icon: IconlyBold.user_2,
                            title: 'Masjid Name',
                            subtitle: data['masjidname'],
                          ),
                          0.01.ph,
                          UserInfoListTile(
                            icon: IconlyBold.message,
                            title: 'Email Address',
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
                          UserInfoListTile(
                            icon: IconlyBold.message,
                            title: 'Program Registered',
                            subtitle: data['Programs'][index],
                          ),
                          0.01.ph,
                          UserInfoListTile(
                            icon: IconlyBold.location,
                            title: 'Address',
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
