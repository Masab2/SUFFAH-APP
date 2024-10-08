import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/res/components/DisplayAffiliatedprogramForAdmin/DisplayAffiliatedProgramForAdmin.dart';
import 'package:suffa_app/utils/color/appColor.dart';

class AlSuffahActiveProgramView extends StatefulWidget {
  const AlSuffahActiveProgramView({super.key});

  @override
  State<AlSuffahActiveProgramView> createState() =>
      _AlSuffahActiveProgramViewState();
}

class _AlSuffahActiveProgramViewState extends State<AlSuffahActiveProgramView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.suffahRequestedProgram('Active'),
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
                      return DisplayAffiliatedProgramtoAdminComp(
                        title: data['programTitle'],
                        image: data['image'],
                        email: data['masjidname'],
                        onGreenBtnPressed: () async {
                          Apis.disableMasjidDonnationProgram(data['programId']);
                        },
                        centerId: data['MasjidId'],
                        address: data['purpose'],
                        city: '${data['Price']}',
                        onGreyBtnPressed: () async {},
                        greenBtnText: 'Disable',
                        greyBtnText: 'Enable',
                        status: data['Status'],
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
