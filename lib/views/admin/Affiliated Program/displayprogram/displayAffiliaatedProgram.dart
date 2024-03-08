import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/RequestMemberComp/RequestMemberComp.dart';
import 'package:suffa_app/res/routes/routesNames.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class DisplayAffiliatedProgram extends StatefulWidget {
  const DisplayAffiliatedProgram({Key? key}) : super(key: key);

  @override
  State<DisplayAffiliatedProgram> createState() =>
      _DisplayAffiliatedProgramState();
}

class _DisplayAffiliatedProgramState extends State<DisplayAffiliatedProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Affiliated Program',
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
                    return RequesttoAdminComp(
                        title: data['programTitle'],
                        image: data['image'],
                        email: "${data['Price']} \t ${data['Currency']}",
                        onGreenBtnPressed: () {},
                        centerId: '',
                        address: data['Status'],
                        city: data['Currency'],
                        onGreyBtnPressed: () {},
                        greenBtnText: 'Disable',
                        greyBtnText: 'Rename');
                    // return Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: context.mw * 0.03,
                    //     vertical: context.mh * 0.03,
                    //   ),
                    //   child: SelectProgramComp(
                    //     image: data['image'],
                    //     title: data['programTitle'],
                    //     buttonTitle: 'Registered In This Program',
                    //     ontap: () {},
                    //   ),
                    // );
                  },
                ));
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(
          Icons.description,
          color: AppColor.whiteColor,
        ),
        onPressed: () {
          Get.toNamed(RoutesNames.addaffiliatedProgramScreenforAdmin);
        },
        label: Text(
          'Add Program',
          style: GoogleFonts.poppins(
            color: AppColor.whiteColor,
            fontSize: context.mh * 0.018,
          ),
        ),
      ),
    );
  }
}
