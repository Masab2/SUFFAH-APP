import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/HomeComp/SelectMasjidComp/masjidDisplayComp.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SelectMasjidsView extends StatefulWidget {
  const SelectMasjidsView({super.key});

  @override
  State<SelectMasjidsView> createState() => _SelectMasjidsViewState();
}

class _SelectMasjidsViewState extends State<SelectMasjidsView> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final program = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'AL-SUFFAH CENTER',
            style: GoogleFonts.poppins(
              fontSize: context.mh * 0.024,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            CustomizedFeild(
              controller: searchController,
              hint: 'Search Masjids',
              prefixIcon: const Icon(IconlyLight.search),
            ),
            0.03.ph,
            StreamBuilder(
                stream: Apis.getAllSuffaCenterByProgram(program),
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
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return MasjidDisplayComp(
                          masjidname: data['masjidname'],
                          image: data['masjidimg'],
                          masjidaddress: data['address'],
                          ontap: () {
                            Get.toNamed(RoutesNames.donateNeedyPeopleScreen,
                                arguments: [
                                  'OneTimeMeal',
                                  data['adminCreatedId'],
                                ]);
                          },
                          program: program,
                          muntazimid: data['adminCreatedId'],
                        );
                      },
                    ));
                  }
                })
          ],
        ));
  }
}
