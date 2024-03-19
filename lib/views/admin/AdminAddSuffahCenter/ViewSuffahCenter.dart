import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/RequestMemberComp/RequestMemberComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';

class ViewSuffahCenter extends StatefulWidget {
  const ViewSuffahCenter({super.key});

  @override
  State<ViewSuffahCenter> createState() => _ViewSuffahCenterState();
}

class _ViewSuffahCenterState extends State<ViewSuffahCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suffah Center',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.getAllSuffaCenter(),
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
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return RequesttoAdminComp(
                        title: data['name'],
                        image: data['masjidimg'],
                        email: data['email'],
                        onGreenBtnPressed: () async {
                          // await controller.launchPhoneApp(data['phoneno']);
                        },
                        centerId: data['centerid'],
                        address: data['address'],
                        city: data['masjidname'],
                        onGreyBtnPressed: () {},
                        greenBtnText: 'Contact',
                        greyBtnText: 'Disable',
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          IconlyBold.add_user,
        ),
        onPressed: () {
          Get.toNamed(RoutesNames.addSuffahCenterScreen);
        },
      ),
    );
  }
}
