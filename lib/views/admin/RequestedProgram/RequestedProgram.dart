import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

import '../../../res/components/RequestMemberComp/RequestMemberComp.dart';
import '../../../utils/color/appColor.dart';

class RequestedProgramView extends StatefulWidget {
  const RequestedProgramView({super.key});

  @override
  State<RequestedProgramView> createState() => _RequestedProgramViewState();
}

class _RequestedProgramViewState extends State<RequestedProgramView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requested Program',
          style: GoogleFonts.poppins(
            fontSize: context.mh * 0.024,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          0.02.ph,
          StreamBuilder(
            stream: Apis.suffahRequestedProgram("Requested"),
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
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Column(
                        children: [
                          RequesttoAdminComp(
                            title: data['programTitle'],
                            image: data['image'],
                            email: data['masjidname'],
                            onGreenBtnPressed: () async {
                              await Apis.updateSuffahProgramStatus(
                                data['programId'],
                                'Active',
                              ).then((value) {
                                Get.snackbar('Success', 'Status Active');
                              });
                            },
                            centerId: data['MasjidId'],
                            address: data['purpose'],
                            city: '${data['Price']} PKR',
                            onGreyBtnPressed: () async {
                              await Apis.updateSuffahProgramStatus(
                                data['programId'],
                                'Rejected',
                              ).then((value) {
                                Get.snackbar('Confirmed', 'Rejected');
                              });
                            },
                            greenBtnText: 'Accept',
                            greyBtnText: 'Reject',
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
