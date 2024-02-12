import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/utils/color/appColor.dart';

import '../../../../../res/components/RequestMemberComp/RequestMemberComp.dart';

class AlSuffahRejectedView extends StatefulWidget {
  const AlSuffahRejectedView({super.key});

  @override
  State<AlSuffahRejectedView> createState() => _AlSuffahRejectedViewState();
}

class _AlSuffahRejectedViewState extends State<AlSuffahRejectedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.suffahRequestedProgram('Rejected'),
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
                        title: data['programTitle'],
                        image: data['image'],
                        email: data['masjidname'],
                        onGreenBtnPressed: () async {},
                        centerId: data['MasjidId'],
                        address: data['purpose'],
                        city: '${data['Price']} PKR',
                        onGreyBtnPressed: () async {},
                        greenBtnText: 'Remove',
                        greyBtnText: 'Request Again',
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
