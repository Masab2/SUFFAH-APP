import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../../../../res/components/RequestMemberComp/RequestMemberComp.dart';

class DisplayAlshuffaRegisteredShop extends StatefulWidget {
  const DisplayAlshuffaRegisteredShop({super.key});

  @override
  State<DisplayAlshuffaRegisteredShop> createState() =>
      _DisplayAlshuffaRegisteredShopState();
}

class _DisplayAlshuffaRegisteredShopState
    extends State<DisplayAlshuffaRegisteredShop> {
  late String masjidid;
  @override
  void initState() {
    masjidid = Get.arguments[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registered Shops',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.getShopsforMasjid(masjidid),
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
                return const Center(child: Text('No Data Found'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    reverse: false,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return RequesttoAdminComp(
                        title: data['ShopTitle'],
                        image: data['Image'],
                        email: data['Phoneno'],
                        onGreenBtnPressed: () async {},
                        centerId: data['ShopId'],
                        address: data['Address'],
                        city: data['City'],
                        onGreyBtnPressed: () async {},
                        greenBtnText: 'Contact',
                        greyBtnText: 'Disable',
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
