import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/TextFormFeilds/customizedFeild.dart';
import 'package:suffa_app/res/components/selectProgramComp/selectProgramComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/asset/ImageAsset.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SelectProgram extends StatefulWidget {
  const SelectProgram({super.key});

  @override
  State<SelectProgram> createState() => _SelectProgramState();
}

class _SelectProgramState extends State<SelectProgram> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final id = Get.arguments[0];
    final masjidname = Get.arguments[1];
    final masjidid = Get.arguments[2];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          masjidname,
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.020,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomizedFeild(
            controller: searchController,
            hint: 'Search Programs',
            prefixIcon: const Icon(IconlyLight.search),
          ),
          0.03.ph,
          StreamBuilder(
            stream: Apis.getAllPrograms(),
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
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mw * 0.03,
                        vertical: context.mh * 0.02,
                      ),
                      child: SelectProgramComp(
                        image: ImageAsset.hungryimg,
                        title: data['programTitle'],
                        buttonTitle: 'Registered In This Program',
                        ontap: () {
                          Get.toNamed(RoutesNames.addPersonalDataScreen,
                              arguments: [
                                id,
                                masjidname,
                                data['programTitle'],
                                masjidid,
                              ]);
                        },
                      ),
                    );
                  },
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
