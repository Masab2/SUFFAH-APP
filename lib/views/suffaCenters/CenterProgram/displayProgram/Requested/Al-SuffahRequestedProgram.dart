import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:suffa_app/utils/color/appColor.dart';

import '../../../../../Service/Firebase/firebasehelper.dart';
import '../../../../../res/components/RequestMemberComp/RequestMemberComp.dart';

class AlSuffahRequestedprogramView extends StatefulWidget {
  const AlSuffahRequestedprogramView({super.key});

  @override
  State<AlSuffahRequestedprogramView> createState() =>
      _AlSuffahRequestedprogramViewState();
}

class _AlSuffahRequestedprogramViewState
    extends State<AlSuffahRequestedprogramView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.suffahRequestedProgram('Requested'),
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
                      return RequesttoAdminComp(
                        title: data['programTitle'],
                        image: data['image'],
                        email: data['masjidname'],
                        onGreenBtnPressed: () async {},
                        centerId: data['MasjidId'],
                        address: data['purpose'],
                        city: '${data['Price']} PKR',
                        onGreyBtnPressed: () async {},
                        greenBtnText: 'Rename',
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
