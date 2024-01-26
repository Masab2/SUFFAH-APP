import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/enum/AffiliatedProgramEnum.dart';
import 'package:suffa_app/res/components/HomeComp/SelectMasjidComp/masjidDisplayComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DonateNeedyPeopleView extends StatefulWidget {
  const DonateNeedyPeopleView({super.key});

  @override
  State<DonateNeedyPeopleView> createState() => _DonateNeedyPeopleViewState();
}

class _DonateNeedyPeopleViewState extends State<DonateNeedyPeopleView> {
  @override
  Widget build(BuildContext context) {
    final program = Get.arguments[0];
    final muntazimid = Get.arguments[1];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          program == ProgramType.ONETIMEMEAL ? 'OneTimeMeal' : 'RashanProgram',
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
              stream: Apis.getAllNeedyPeopleByProgram(
                  program == ProgramType.ONETIMEMEAL
                      ? 'OneTimeMeal'
                      : 'RashanProgram',
                  muntazimid),
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
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return MasjidDisplayComp(
                        masjidname: data['PersonName'],
                        image: data['PersonProfile'],
                        masjidaddress: data['PersonAddress'],
                        ontap: () {
                          Get.toNamed(RoutesNames.donateNeedyPeopleScreen,
                              arguments: program);
                        },
                        program: program == ProgramType.ONETIMEMEAL
                            ? 'OneTimeMeal'
                            : 'RashanProgram',
                        muntazimid: data['adminCreatedId'],
                      );
                    },
                  ));
                }
              })
        ],
      ),
    );
  }
}
