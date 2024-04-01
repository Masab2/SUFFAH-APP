import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/selectProgramComp/selectProgramComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class SelectProgram extends StatefulWidget {
  const SelectProgram({super.key});

  @override
  State<SelectProgram> createState() => _SelectProgramState();
}

class _SelectProgramState extends State<SelectProgram> {
  final searchController = TextEditingController();
  late String id;
  late String masjidname;
  late String masjidid;
  late String masjidEmail;
  late String country;
  late String state;
  late String city;
  late String address;

  @override
  void initState() {
    id = Get.arguments[0];
    masjidname = Get.arguments[1];
    masjidid = Get.arguments[2];
    masjidEmail = Get.arguments[3];
    country = Get.arguments[4];
    state = Get.arguments[5];
    city = Get.arguments[6];
    address = Get.arguments[7];
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          masjidname,
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
            stream: Apis.getAllPrograms(),
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
                        vertical: context.mh * 0.03,
                      ),
                      child: SelectProgramComp(
                        image: data['image'],
                        title: data['programTitle'],
                        buttonTitle: 'Registered In This Program',
                        ontap: () {
                          Get.toNamed(
                            RoutesNames.addPersonalDataScreen,
                            arguments: [
                              id,
                              masjidname,
                              data['programTitle'],
                              masjidid,
                              masjidEmail,
                              country,
                              state,
                              city,
                              address,
                              data['Price'],
                            ],
                          );
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
