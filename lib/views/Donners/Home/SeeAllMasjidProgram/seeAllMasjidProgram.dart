import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/HomeComp/donnationChoices/DefaultProgramSeeAll/DefaultprogramSeeAll.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';


class SeeAllMasjidProgramView extends StatefulWidget {
  const SeeAllMasjidProgramView({super.key});

  @override
  State<SeeAllMasjidProgramView> createState() => _SeeAllMasjidProgramViewState();
}

class _SeeAllMasjidProgramViewState extends State<SeeAllMasjidProgramView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.brownColor,
        title: Text(
          'All Programs',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.023,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          0.02.ph,
          StreamBuilder(
            stream: Apis.getAllSuffahCenterDefinePrograms(),
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
                return const Text('No Data');
              } else {
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return DonnationChoiceSeeAll(
                        image: data['image'],
                        title: data['programTitle'],
                        ontap: () {
                          // Get.toNamed(
                          //   RoutesNames.selectMasjidScreen,
                          //   arguments: [
                          //     data['programTitle'],
                          //     data['Price'],
                          //     country,
                          //     data['image'],
                          //     currency
                          //   ],
                          // );
                        },
                        program: data['programTitle'],
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
