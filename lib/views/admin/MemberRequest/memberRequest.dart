import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suffa_app/Service/Firebase/firebasehelper.dart';
import 'package:suffa_app/ViewModel/Admin/MemberRequestAccept/MemberRequestAcceptViewModel.dart';
import 'package:suffa_app/res/components/RequestMemberComp/RequestMemberComp.dart';
import 'package:suffa_app/utils/color/appColor.dart';
import 'package:suffa_app/utils/extenshion/extenshion.dart';

class MemberRequest extends StatefulWidget {
  const MemberRequest({super.key});

  @override
  State<MemberRequest> createState() => _MemberRequestState();
}

class _MemberRequestState extends State<MemberRequest> {
  final memberRequestViewModel = Get.put(MemberRequestAcceptViewModel());
  @override
  void dispose() {
    memberRequestViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Members Requested',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: context.mh * 0.023,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: Apis.getSuffaCenterMembers(),
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    0.40.ph,
                    const Center(
                      child: Text('There is No Request for Masjid Members'),
                    ),
                  ],
                );
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
                      title: data['name'],
                      image: data['masjidimg'],
                      email: data['email'],
                      onGreenBtnPressed: () {
                        memberRequestViewModel.acceptRequest(
                          data['MemberId'],
                          context,
                        );
                      },
                      centerId: data['Desig'],
                      address: data['Masjidname'],
                      city: data['city'],
                      onGreyBtnPressed: () {},
                      greenBtnText: 'Accept',
                      greyBtnText: 'Reject',
                    );
                  },
                ));
              }
            },
          )
        ],
      ),
    );
  }
}
